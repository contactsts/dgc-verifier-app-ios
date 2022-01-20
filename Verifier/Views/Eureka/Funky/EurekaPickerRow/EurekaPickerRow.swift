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


//public class EurekaPickerCell: Cell<String>, CellType {
public class EurekaPickerCell: BaseEurekaCell<String> {
    
    
    // ------------------------- UI ---------------------------
    
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var hintLabel: UILabel!
    @IBOutlet weak var errorsLabel: UILabel!
    
    @IBOutlet weak var valueLabel: UILabel!
    @IBOutlet weak var eurekaPickerTagList: EurekaPickerTagList!
    
    //    @IBOutlet weak var clearImageView: UIImageView!
    
    @IBOutlet weak var chevronImageView: UIImageView!
    @IBOutlet weak var clearFunkyButton: FunkyButton!
    
    
    // ------------------------- PRIVATE ---------------------------

    var rowCasted: EurekaPickerRow!
    let genericPickerVC = GenericPickerVC(list: [])
    
    // =====================================================
    
    
    override func initViews() {
        super.initViews()
        rowCasted = (row as! EurekaPickerRow)
        
        clearFunkyButton.titleLabel.text = "Clear"
        valueLabel.text = "Not set"
        
        titleLabel.text = row.title
        errorsLabel.text = "No errors what so ever"
        
        //        chevronImageView.isHidden = !showArrow
        errorsLabel.isHidden = true
        
        genericPickerVC.titleStackViewText = rowCasted.pickerVCTitle
        genericPickerVC.subtitleStackViewLabel.isHidden = true
    }
    
    
    override func initLayout() {
        super.initLayout()
    }
    
    override func initBindings() {
        super.initBindings()
        
        genericPickerVC.result.skip(1).subscribe(onNext: { [weak self] items in
            self?.eurekaPickerTagList.selectedItems = items
            self?.eurekaPickerTagList.collectionView.reloadData()
        }).disposed(by: disposeBag)
        
        eurekaPickerTagList.result.subscribe(onNext: { [weak self] items in
            self?.rowCasted.selectedOptions = items
            self?.row.value = items.map({ $0.id }).compactMap{ $0 }.joined(separator: ",")
            self?.update()
        }).disposed(by: disposeBag)
        
        clearFunkyButton.rx
            .tapGesture()
            .when(.recognized)
            .subscribe(onNext: { [weak self] value in
                //                let eurekaPickerRow = self?.row as! EurekaPickerRow
                //                eurekaPickerRow.onClear.onNext(())
            }).disposed(by: disposeBag)
        
        self.rx
            
            .tapGesture(configuration: { gestureRecognizer, delegate in
                gestureRecognizer.delegate = self
            })
            .when(.recognized)
            .subscribe(onNext: { [weak self] value in
                self?.onShowGenericPickerVC()
            }).disposed(by: disposeBag)
    }


    
    public override func update() {
        super.update()
        
        let eurekaPickerRow = row as! EurekaPickerRow
        titleLabel.text = row.title ?? "No title"

        let hasValue = eurekaPickerRow.selectedOptions.count > 0
        valueLabel.isHidden = hasValue
        eurekaPickerTagList.isHidden = !hasValue
        
        self.clearFunkyButton.isHidden = !eurekaPickerRow.showClear
        self.chevronImageView.isHidden = !eurekaPickerRow.showArrow
        self.hintLabel.isHidden = (eurekaPickerRow.hint == nil)
        self.hintLabel.text = eurekaPickerRow.hint
        //        self.eurekaPickerTagList
        
        errorsLabel.isHidden = row.isValid
        let errorLabelString = row.validationErrors.map { $0.msg }.joined(separator: "\n")
        errorsLabel.text = errorLabelString
    }
    
    
    public override func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRequireFailureOf otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        let eurekaPickerRow = self.row as! EurekaPickerRow
        if gestureRecognizer.view == self.clearFunkyButton {
            return false
        }
        return true
    }
    
    
    func onShowGenericPickerVC() {
        let eurekaPickerRow = row as! EurekaPickerRow
        genericPickerVC.list = eurekaPickerRow.options
        genericPickerVC.selectedItem = eurekaPickerRow.selectedOptions
        formViewController()?.navigationController?.pushViewController(genericPickerVC, animated: true)
    }
    
    
    
    
}


//public final class EurekaPickerRow: Row<EurekaPickerCell>, RowType {
public final class EurekaPickerRow: BaseEurekaRow<EurekaPickerCell, String>, RowType {
    
    // ------------------ IN ------------------
    
    var options : [GenericPickerItem] = []
    var selectedOptions : [GenericPickerItem] = []
    var mode: GenericPickerMode = .single
    
    var pickerVCTitle = ""
    var pickerVCSubtitle = ""
    
    var showArrow: Bool = true {
        didSet {
            self.updateCell()
        }
    }
    
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
    
    // ------------------ OUT ------------------
    
    let onClear = PublishSubject<Void>()
    let onSelect = PublishSubject<Void>()
    
    let onResult = BehaviorRelay<Events>(value: .nothing)
    
    
    enum Events {
        case color(MaterialColor?)
        case nothing
    }
    
}
