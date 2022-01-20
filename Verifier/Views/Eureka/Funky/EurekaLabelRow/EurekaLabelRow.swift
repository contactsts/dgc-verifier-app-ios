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


//public class EurekaLabelCell: Cell<String>, CellType {
public class EurekaLabelCell: BaseEurekaCell<String> {
    
    // ---------------------------- UI -----------------------------
    @IBOutlet weak var stackView: UIStackView!
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var hintLabel: UILabel!
    @IBOutlet weak var errorsLabel: UILabel!
    
    @IBOutlet weak var valueLabel: UILabel!
    
    @IBOutlet weak var chevronImageView: UIImageView!
    @IBOutlet weak var clearFunkyButton: FunkyButton!
    
    
    // ------------------------- PRIVATE ---------------------------
    
    var rowCasted: EurekaLabelRow!
    
    // ==============================================================
    
    
    
    override func initViews() {
        super.initViews()
        
        rowCasted = (row as! EurekaLabelRow)
        
        clearFunkyButton.titleLabel.text = "Clear"
        
        titleLabel.text = row.title
        valueLabel.text = row.value
        valueLabel.numberOfLines = 0
        
        
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
                guard let self = self else {
                    return
                }
                guard self.rowCasted.isDisabled == false else {
                    return
                }
                self.rowCasted.onResultRelay.accept(.clear)
            }).disposed(by: disposeBag)
        
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
                guard self.rowCasted.isDisabled == false else {
                    return
                }
                     
//                self.rowCasted.onSelect.onNext(())
                self.rowCasted.onResultRelay.accept(.select)
                
//                self.rowCasted.didSelect()
            }).disposed(by: disposeBag)
    }
    

    
    

    
    public override func update() {
        super.update()
        titleLabel.text = row.title ?? "No title"
        valueLabel.text = row.value ?? "No value"
        
        if row.value == nil {
            valueLabel.isHidden = true
            stackView.snp.makeConstraints { make in
                make.height.equalTo(40)
            }
        }
        
        
//        self.clearImageView.isHidden = !eurekaLabelRow.showClear
        self.clearFunkyButton.isHidden = !rowCasted.showClear
        self.chevronImageView.isHidden = !rowCasted.showArrow
        self.hintLabel.isHidden = (rowCasted.hint == nil)
        self.hintLabel.text = rowCasted.hint
        
        errorsLabel.isHidden = row.isValid
        let errorLabelString = row.validationErrors.map { $0.msg }.joined(separator: "\n")
        errorsLabel.text = errorLabelString
        
        if rowCasted.isRowDisabled {
            titleLabel.textColor = .lightGray
            titleLabel.textColor = .lightGray
        } else {
            titleLabel.textColor = .black
            titleLabel.textColor = .black
        }
    }
    
    
    
    public override func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRequireFailureOf otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        let eurekaLabelRow = self.row as! EurekaLabelRow
//        if !eurekaLabelRow.showClear {
//            return super.gestureRecognizer(gestureRecognizer, shouldRequireFailureOf: otherGestureRecognizer)
//        }

        if gestureRecognizer.view == self.clearFunkyButton {
            return false
        }
        return true
    }
    
    
    
    
}

public final class EurekaLabelRow: BaseEurekaRow<EurekaLabelCell, String>, RowType {

    
    public required init(tag: String?) {
        super.init(tag: tag)
        onResult = onResultRelay.asObservable()
    }
    
    // ------------------ IN ------------------
    
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
    
    var isRowDisabled: Bool = false {
        didSet {
            self.updateCell()
        }
    }
    
    // ------------------ OUT ------------------
    
//    let onClear = PublishSubject<Void>()
//    let onSelect = PublishSubject<Void>()
    

    let onResultRelay = BehaviorRelay<Events>(value: .clear)
    var onResult: Observable<Events>! = nil
    
    enum Events {
        case clear
        case select
    }
    
}


