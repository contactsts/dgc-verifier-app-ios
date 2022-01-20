
import Foundation
import Eureka
import SnapKit
import RxSwift
import RxCocoa


protocol BaseCellProtocol {
    func initViews()
    func initLayout()
    func initBindings()
}

extension BaseCellProtocol {
    func initViews() {}
    func initLayout() {}
    func initBindings() {}
}



final class EurekaTextCell3: Cell<String>, CellType, BaseCellProtocol {


    // ---------------------------- UI -----------------------------
       
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var textField: UITextField!
    
    @IBOutlet weak var hintLabel: UILabel!
    @IBOutlet weak var errorLabel: UILabel!
    
    
    // ------------------------- PRIVATE ---------------------------
    
    let disposeBag = DisposeBag()
    
    var rowCasted: EurekaTextRow3!
    
    // ==============================================================
    

    required init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    
    public override func setup() {
        super.setup()

        rowCasted = (row as! EurekaTextRow3)
        
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
        
        
        // -----------------
        
        
        textField.rx.text.orEmpty.distinctUntilChanged().subscribe(onNext: { [weak self] value in
            self?.rowCasted.onResult.onNext(value)
//            guard let self = self else {
//                return
//            }
//
//            if (value !== self.rowCasted.onResult.value) {
//                self.rowCasted.onResult.accept(value)
//            }
        }).disposed(by: disposeBag)
        
    }
    
    
    public override func update() {
        super.update()
  
        titleLabel.text = row.title ?? "No title"
        textField.text = row.value ?? ""
        
        self.hintLabel.isHidden = (rowCasted.hint == nil)
        self.hintLabel.text = rowCasted.hint

        errorLabel.isHidden = row.isValid
        let errorLabelString = row.validationErrors.map { $0.msg }.joined(separator: "\n")
        errorLabel.text = errorLabelString
    }
}



final class EurekaTextRow3: Row<EurekaTextCell3>, RowType {
    
    required init(tag: String?) {
        super.init(tag: tag)
        cellProvider = CellProvider<EurekaTextCell3>(nibName: "EurekaTextCell3")
    }
    
    
    // ------------------ INNER CLASSES ------------------
    
    public enum InputType : String {
        case text, numeric
    }
    
    // ------------------ IN ------------------
    
    override var value: Cell.Value? {
        didSet {
            if oldValue != value {
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
    
    let onResult = PublishSubject<String?>()
    
    // ==============================================
}
