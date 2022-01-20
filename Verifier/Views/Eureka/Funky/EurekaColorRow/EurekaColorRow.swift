//
//  ImageRow.swift
//  ScorePal
//
//  Created by Cioraneanu Mihai on 8/17/19.
//  Copyright © 2019 Cioraneanu Mihai. All rights reserved.
//

import Foundation
import Eureka
import SnapKit
import RxSwift
import RxCocoa



public class EurekaColorCell: BaseEurekaCell<MaterialColor> {
    //public class EurekaColorCell: Cell<MaterialColor>, CellType {
    
    // ---------------------------- UI -----------------------------
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var hintLabel: UILabel!
    @IBOutlet weak var errorsLabel: UILabel!
    
    //    @IBOutlet weak var colorView: UIView!
    @IBOutlet weak var colornameLabel: UILabel!
    
    @IBOutlet weak var clearButton: FunkyButton!
    @IBOutlet weak var colorView: ColorView!
    
    
    

    
    // ------------------------- PRIVATE ---------------------------
    
    var rowCasted: EurekaColorRow!
    
    // ==============================================================
    
    
    
    override func initViews() {
        super.initViews()
        rowCasted = (row as! EurekaColorRow)
        clearButton.titleLabel.text = "Clear"
    }
    
    override func initBindings() {
        super.initBindings()
        
        clearButton.rx
            .tapGesture()
            .when(.recognized)
            .subscribe(onNext: { [weak self] value in
                print("EurekaColorRow clearButton")
                self?.rowCasted.onResult.accept(.nothing)
            }).disposed(by: disposeBag)
        
              
        self.rx
            //            .tapGesture()
            .tapGesture(configuration: { gestureRecognizer, delegate in
                gestureRecognizer.delegate = self
            })
            .when(.recognized)
            .subscribe(onNext: { [weak self] value in
                self?.showColorPicker()
            }).disposed(by: disposeBag)
        
        
        rowCasted.onResult.subscribe(onNext: { [weak self] value in
            print("EurekaColorRow rowCasted.onResult \(value)")
            guard let self = self else { return }
            if case .nothing = value {
                self.rowCasted.value = nil
            }
            if case .color(let materialColor) = value {
                self.rowCasted.value = materialColor
            }
        }).disposed(by: disposeBag)
    }
    
    
    
    
    public override func update() {
        super.update()
        titleLabel.text = row.title ?? "No title"
        
        colorView.isHidden = (row.value == nil)
        
        if let rowValue = row.value  {
            colorView.backgroundColor = rowValue.color
            colornameLabel.text = rowValue.dispalyName
        } else {
            colornameLabel.text = "Not set"
        }
        
        
    
        //        self.clearImageView.isHidden = !eurekaLabelRow.showClear
        self.clearButton.isHidden = (row.value == nil)
        self.hintLabel.isHidden = (rowCasted.hint == nil)
        self.hintLabel.text = rowCasted.hint
        
        errorsLabel.isHidden = row.isValid
        let errorLabelString = row.validationErrors.map { $0.msg }.joined(separator: "\n")
        errorsLabel.text = errorLabelString
        
        
//        self.formViewController()?.tableView.beginUpdates()
//        self.formViewController()?.tableView.endUpdates()
        //        self.formViewController()?.tableView.reloadData()
    }
    
    public override func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRequireFailureOf otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        //            let eurekaLabelRow = self.row as! EurekaLabelRow
        //        if !eurekaLabelRow.showClear {
        //            return super.gestureRecognizer(gestureRecognizer, shouldRequireFailureOf: otherGestureRecognizer)
        //        }
        
        if gestureRecognizer.view == self.clearButton {
            return false
        }
        return true
    }
    
    
    func showColorPicker() {
        guard let viewController = self.formViewController() else {
            return
        }
        
        
        let colorPickerVC = ColorPickerVC(selectedColor: nil)
        viewController.present(colorPickerVC, animated: true, completion: nil)
        
        colorPickerVC.result.subscribe(onNext: { [weak self] value in
            colorPickerVC.dismiss(animated: true, completion: nil)
//            self?.row.value = value
            print("EurekaColorRow picked \(value)")
            self?.rowCasted.onResult.accept(.color(value))
        })
    }
    
    
    
    
}

// The custom Row also has the cell: CustomCell and its correspond value


public final class EurekaColorRow: BaseEurekaRow<EurekaColorCell, MaterialColor>, RowType {
    //public final class EurekaColorRow: Row<EurekaColorCell>, RowType {
    
    
    var showClear: Bool = false {
        didSet {
            self.updateCell()
        }
    }
    
    var hint: String? {
        didSet {
            self.updateCell()
        }
    }
    
    
    public override var value: Cell.Value? {
        didSet {
            if oldValue != value {
                onResult.accept(value == nil ? .nothing : .color(value))
                updateCell()
            }
        }
    }
    

//    let onSelect = PublishSubject<Void>()
    
    let onResult = BehaviorRelay<Events>(value: .nothing)
    
    
    enum Events {
        case color(MaterialColor?)
        case nothing
    }
    
}




