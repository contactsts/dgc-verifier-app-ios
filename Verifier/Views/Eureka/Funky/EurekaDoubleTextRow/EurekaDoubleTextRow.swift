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

public struct EurekaDoubleTextCellData : Equatable {
//    var title1: String = ""
//    var title2: String = ""
    
    var value1: String = ""
    var value2: String = ""
    
    public static func == (lhs: EurekaDoubleTextCellData, rhs: EurekaDoubleTextCellData) -> Bool {
        return lhs.value1 == rhs.value1 && lhs.value2 == rhs.value2
    }
}

//public class EurekaDoubleTextCell: Cell<String>, CellType {
public class EurekaDoubleTextCell: BaseEurekaCell<EurekaDoubleTextCellData> {
    
    
    // ------------------------- UI ---------------------------
    
    @IBOutlet weak var titleLabel1: UILabel!
    @IBOutlet weak var textField1: FunkyTextField!
    @IBOutlet weak var hintLabel1: UILabel!
    @IBOutlet weak var errorLabel1: UILabel!


    @IBOutlet weak var titleLabel2: UILabel!
    @IBOutlet weak var textField2: FunkyTextField!
    @IBOutlet weak var hintLabel2: UILabel!
    @IBOutlet weak var errorLabel2: UILabel!
    
    
    // ------------------------- PRIVATE ---------------------------
    
    var rowCasted: EurekaDoubleTextRow!
    
    // ===========================================================================================
    
    
    override func initViews() {
        super.initViews()
        rowCasted = row as! EurekaDoubleTextRow
        
        if rowCasted.type == .numeric {
            textField1.keyboardType = .numberPad
            textField2.keyboardType = .numberPad
        } else if rowCasted.type == .text {
            textField1.autocapitalizationType = .words
            textField1.keyboardType = .default
            textField2.autocapitalizationType = .words
            textField2.keyboardType = .default
        }
        
        textField1.text = row.value?.value1
        textField2.text = row.value?.value2
        
        titleLabel1.text = rowCasted.title
        titleLabel2.text = rowCasted.title2
        
        errorLabel1.text = "No errors what so ever"
        errorLabel1.isHidden = true
        
        errorLabel2.text = "No errors what so ever"
        errorLabel2.isHidden = true
        
        hintLabel1.isHidden = true
        hintLabel2.isHidden = true
    }
    
    override func initLayout() {
        super.initLayout()
    }
    
    override func initBindings() {
        super.initBindings()
        
        
        rowCasted.onResult.skip(1).subscribe(onNext: { [weak self] value in
            guard let self = self else { return }
            
            if self.rowCasted.value != value {
                print("EurekaDoubleRow \(self.rowCasted.title) onResult \(value)")
                self.rowCasted.value = value
            }
        }).disposed(by: disposeBag)
        
        
        textField1.rx.text.orEmpty.skip(1).subscribe(onNext: { [weak self] value in
            guard let self = self else { return }
            
//            print("EurekaTextRow.textField \(self.rowCasted.title) \(value)")
            
            var rowValue = self.rowCasted.value!
            if rowValue.value1 != value {
                print("EurekaDoubleRow \(self.rowCasted.title) textfield1 \(value)")
                rowValue.value1 = value
                self.rowCasted.value = rowValue
            }
        }).disposed(by: disposeBag)
        
        
        textField2.rx.text.orEmpty.skip(1).subscribe(onNext: { [weak self] value in
            guard let self = self else { return }
//            print("EurekaTextRow.textField \(self.rowCasted.title) \(value)")
            
            var rowValue = self.rowCasted.value!
            if rowValue.value2 != value {
                print("EurekaDoubleRow \(self.rowCasted.title) textfield2 \(value)")
                rowValue.value2 = value
                self.rowCasted.value = rowValue
            }
        }).disposed(by: disposeBag)
    }

    
    
    
    public override func update() {
        super.update()
        
        titleLabel1.text = row.title ?? "No title"
        titleLabel2.text = row.title ?? "No title"
        
        textField1.text = row.value?.value1 ?? ""
        textField2.text = row.value?.value2 ?? ""
        

//        errorLabel1.isHidden = row.isValid
//        let errorLabelString1 = row.validationErrors.map { $0.msg }.joined(separator: "\n")
//        errorLabel1.text = errorLabelString1
//
//
//        errorLabel2.isHidden = row.isValid
//        let errorLabelString1 = row.validationErrors.map { $0.msg }.joined(separator: "\n")
//        errorLabel1.text = errorLabelString1
    }

    
}




// The custom Row also has the cell: CustomCell and its correspond value

public final class EurekaDoubleTextRow: BaseEurekaRow<EurekaDoubleTextCell, EurekaDoubleTextCellData>, RowType {
    
    
    public required init(tag: String?) {
        super.init(tag: tag)
//        onResult = onResultRelay.asObservable()
    }
    
    // ------------------ INNER CLASSES ------------------
    
    public enum InputType : String {
        case text, numeric
    }
    
    // ----------------------- IN -------------------------
    
    var type : InputType = .text
    
    var title2: String? = ""

    public override var value: Cell.Value? {
        didSet {
            if oldValue != value {
                print("EurekaDoubleRow \(title) value \(value)")
                updateCell()
                onResult.accept(value!)
            }
        }
    }
    
    // ----------------------- OUT ---------------------------
    
    let onResult = BehaviorRelay<EurekaDoubleTextCellData>(value: EurekaDoubleTextCellData(value1: "", value2: ""))
//    var onResult: Observable<EurekaDoubleTextCellData>! = nil
    

    
    
    

}
