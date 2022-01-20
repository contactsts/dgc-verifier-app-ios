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


public class EurekaTextCell: BaseEurekaCell<String> {
    
    
    // ---------------------------- UI -----------------------------
    
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var textField: UITextField!
    
    @IBOutlet weak var hintLabel: UILabel!
    @IBOutlet weak var errorLabel: UILabel!
    
    
    // ------------------------- PRIVATE ---------------------------
    
    var rowCasted: EurekaTextRow!
    
    // ==============================================================
    
    
    
    override func initViews() {
        super.initViews()
        
        rowCasted = (row as! EurekaTextRow)
        
        textField.borderStyle = .none
        textField.clearButtonMode = .always
        textField.placeholder = "Type something..."
        textField.backgroundColor = UIColor(hexString: "#eeeeee")
        textField.setLeftPadding()
        textField.layer.cornerRadius = 5
        
        
        if rowCasted.type == .numeric {
            textField.keyboardType = .numberPad
        } else if rowCasted.type == .text {
            textField.keyboardType = .default
        }
        
        textField.autocapitalizationType = .words
        
        textField.text = row.value
        titleLabel.text = row.title
        errorLabel.text = "No errors what so ever"
        errorLabel.isHidden = true
    }
    
    override func initLayout() {
        super.initLayout()
    }
    
    
    override func initBindings() {
        super.initBindings()
        
        rowCasted.onResultRelay.skip(1).subscribe(onNext: { [weak self] value in
            guard let self = self else { return }
            
            
            if self.rowCasted.value != value {
            
                self.rowCasted.value = value
                self.update()
            }
        }).disposed(by: disposeBag)
        
        
        textField.rx.text.orEmpty.subscribe(onNext: { [weak self] value in
            guard let self = self else { return }
            
            
            if value != self.rowCasted.value {
            
                self.rowCasted.value = value
            }
        }).disposed(by: disposeBag)
        
        
        
    }
    
    
    public override func update() {
        super.update()
        print("Update row \(rowCasted.title) value = \(row.value)")
        titleLabel.text = row.title ?? "No title"
        textField.text = row.value ?? ""
        
        self.hintLabel.isHidden = (rowCasted.hint == nil)
        self.hintLabel.text = rowCasted.hint
        
        errorLabel.isHidden = row.isValid
        let errorLabelString = row.validationErrors.map { $0.msg }.joined(separator: "\n")
        errorLabel.text = errorLabelString
    }
    
    
}





//public final class EurekaTextRow: Row<EurekaTextCell>, RowType {
public final class EurekaTextRow: BaseEurekaRow<EurekaTextCell, String>, RowType {
    
    public required init(tag: String?) {
        super.init(tag: tag)
        onResult = onResultRelay.asObservable()
    }
    
    
    // ------------------ INNER CLASSES ------------------
    
    public enum InputType : String {
        case text, numeric
    }
    
    // ------------------ IN ------------------
    
    
    public override var value: Cell.Value? {
        didSet {
            if oldValue != value {
                print("Value didSet \(title) value = \(value)")
                onResultRelay.accept(value ?? "")
                updateCell()
            }
        }
    }
    
    var type : InputType = .text
    
    
    var hint: String? {
        didSet {
            self.updateCell()
        }
    }
    
    // ------------------ OUT ------------------
    
    let onResultRelay = BehaviorRelay<String>(value: "")
    var onResult: Observable<String>! = nil
    
    // ==============================================
    
}


