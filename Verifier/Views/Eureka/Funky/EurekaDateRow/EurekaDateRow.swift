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



//public class EurekaDateCell: Cell<Date>, CellType {
public class EurekaDateCell: BaseEurekaCell<Date> {
    
    
    // ------------------------- UI ---------------------------
    
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var hintLabel: UILabel!
    @IBOutlet weak var errorsLabel: UILabel!
    
    @IBOutlet weak var valueLabel: UILabel!
    
    //    @IBOutlet weak var clearImageView: UIImageView!
    
    @IBOutlet weak var chevronImageView: UIImageView!
    @IBOutlet weak var clearFunkyButton: FunkyButton!
    
    // ------------------------- PRIVATE ---------------------------

    let datePickerVC = DatePickerVC()
    var rowCasted: EurekaDateRow!
    
    // ==============================================================
    
    
    override func initViews() {
        super.initViews()
        rowCasted = row as! EurekaDateRow
        
        clearFunkyButton.titleLabel.text = "Clear"
        
        titleLabel.text = row.title
        valueLabel.text = "Not set"
        errorsLabel.text = "No errors what so ever"
        
        errorsLabel.isHidden = true
    }
    
    override func initLayout() {
        super.initLayout()
    }
    
    
    override func initBindings() {
        super.initBindings()
        
        clearFunkyButton.rx
            .tapGesture()
            .when(.recognized)
            .subscribe(onNext: { [weak self] value in
//                self?.row.value = nil
//                self?.update()
                self?.rowCasted.onResult.accept(nil)
            }).disposed(by: disposeBag)
        
        self.rx
            .tapGesture(configuration: { gestureRecognizer, delegate in
                gestureRecognizer.delegate = self
            })
            .when(.recognized)
            .subscribe(onNext: { [weak self] value in
                self?.showDatePicker()
            }).disposed(by: disposeBag)
        
        
        datePickerVC.result.subscribe(onNext: { [weak self] date in
//            print("Current date = \(date)")
//            self?.row.value = date
//            self?.update()
            self?.rowCasted.onResult.accept(date)
        }).disposed(by: disposeBag)
        
        
        
        rowCasted.onResult.subscribe(onNext: { [weak self] value in
            guard let self = self else { return }
//            print("EurekaTextRow.onResult \(self.rowCasted.title) \(self.rowCasted.value)")

            if self.rowCasted.value != value {
                self.rowCasted.value = value
            }
        }).disposed(by: disposeBag)
        
        
//        textField.rx.text.orEmpty.skip(1).subscribe(onNext: { [weak self] value in
//            guard let self = self else {
//                return
//            }
////            print("EurekaTextRow.textField \(self.rowCasted.title) \(value)")
//
//            if self.rowCasted.onResult.value != value {
//                self.rowCasted.onResult.accept(value)
//            }
//        }).disposed(by: disposeBag)
    }
    
    
   
    
    

    
    public override func update() {
        super.update()
        titleLabel.text = row.title ?? "No title"
        valueLabel.text = row.value != nil ? DateUtils.formatDateOnlyToString(date: row.value!) : "Not set"
        
        let eurekaDateRow = row as! EurekaDateRow
        //        self.clearImageView.isHidden = !eurekaLabelRow.showClear
        
        
        let showClearButton = (row.value != nil && eurekaDateRow.showClear)
        self.clearFunkyButton.isHidden = !showClearButton
        self.chevronImageView.isHidden = !eurekaDateRow.showArrow
        self.hintLabel.isHidden = (eurekaDateRow.hint == nil)
        self.hintLabel.text = eurekaDateRow.hint
        
        errorsLabel.isHidden = row.isValid
        let errorLabelString = row.validationErrors.map { $0.msg }.joined(separator: "\n")
        errorsLabel.text = errorLabelString
           
//        self.formViewController()?.tableView.beginUpdates()
//        self.formViewController()?.tableView.endUpdates()
    }
    
    
    
    public override func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRequireFailureOf otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        let eurekaDateRow = self.row as! EurekaDateRow
        
        if gestureRecognizer.view == self.clearFunkyButton {
            return false
        }
        return true
    }
    
    
    
    
    
    func showDatePicker() {
        datePickerVC.initialDate = row.value ?? Date()
        formViewController()?.presentPanModal(datePickerVC)
    }
    
    
}

// The custom Row also has the cell: CustomCell and its correspond value
//public final class EurekaDateRow: Row<EurekaDateCell>, RowType {
public final class EurekaDateRow: BaseEurekaRow<EurekaDateCell, Date>, RowType {

    // ----------------------- IN -------------------------
    
    public override var value: Cell.Value? {
        didSet {
            if oldValue != value {
                updateCell()
            }
        }
    }
    
    
    var showArrow: Bool = true {
        didSet {
            self.updateCell()
        }
    }
    
    var showClear: Bool = true {
        didSet {
            self.updateCell()
        }
    }
    
    var hint: String? {
        didSet {
            self.updateCell()
        }
    }
    
    // ----------------------- OUT -------------------------
    
    let onResult = BehaviorRelay<Date?>(value: nil)

    
}
