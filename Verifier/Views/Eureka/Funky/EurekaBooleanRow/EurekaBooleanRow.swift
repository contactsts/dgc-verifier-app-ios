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
import LTHRadioButton
import RxSwift
import RxCocoa

//public class EurekaBooleanCell: Cell<Bool>, CellType {
public class EurekaBooleanCell: BaseEurekaCell<Bool> {
    
    
    // ------------------------- UI ---------------------------
    
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var selectedRadioButton: LTHRadioButton!
    
    // ------------------------- PRIVATE ---------------------------
    
    var rowCasted: EurekaBooleanRow!
    
    // ==============================================================
    
    
    override func initViews() {
        super.initViews()
        rowCasted = (row as! EurekaBooleanRow)
        
        titleLabel.text = row.title
//        selectedRadioButton.deselect()
    }
    
    override func initLayout() {
        super.initLayout()
    }
    
    override func initBindings() {
        super.initBindings()
        
        self.rx
            //            .tapGesture()
            .tapGesture(configuration: { gestureRecognizer, delegate in
                gestureRecognizer.delegate = self
            })
            .when(.recognized)
            .subscribe(onNext: { [weak self] value in
                guard let self = self else {
                    return
                }
                let newValue = !(self.rowCasted.value ?? false)
                if (newValue != self.rowCasted.value) {
                    self.rowCasted.value = newValue
                    self.update()
                }
//                self.rowCasted.onResult.accept(newValue)
//                self.rowCasted.didSelect()
//                self.rowCasted.updateCell()
            }).disposed(by: disposeBag)
        
        
        rowCasted.onResult.subscribe(onNext: { [weak self] value in
            guard let self = self else { return }

            if self.rowCasted.value != value {
                self.rowCasted.value = value
                self.update()
            }
        }).disposed(by: disposeBag)
        
    }
    
    
    
    
    public override func update() {
        super.update()
        titleLabel.text = row.title ?? "No title"
        
        let value = row.value ?? false
        if value {
            selectedRadioButton.select()
        } else {
            selectedRadioButton.deselect()
        }
        
        //        valueImage.image = value ?  UIImage(named: EurekaBooleanRow.checkedImageName) :  UIImage(named: EurekaBooleanRow.uncheckedImageName)
    }
    
//    open override func didSelect() {
//        let newValue = !(row.value ?? false)
//        row.value = newValue
//        //        rowCasted.onResult.accept(newValue)
//        row.updateCell()
//        super.didSelect()
//    }
    
    
    
}


//public final class EurekaBooleanRow: Row<EurekaBooleanCell>, RowType {
public final class EurekaBooleanRow: BaseEurekaRow<EurekaBooleanCell, Bool>, RowType {
    
    // ----------------------- IN --------------------------
    
    public override var value: Cell.Value? {
        didSet {
            if oldValue != value {
//                updateCell()
                onResult.accept(value ?? false)
            }
        }
    }
    
    
    // ----------------------- OUT -------------------------
    
    let onResult = BehaviorRelay<Bool>(value: false)
    
    
}
