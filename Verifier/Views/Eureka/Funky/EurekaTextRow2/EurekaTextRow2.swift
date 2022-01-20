
import Foundation
import Eureka
import SnapKit
import RxSwift
import RxCocoa





public class EurekaTextCell2: BaseEurekaCell2<String> {


    // ---------------------------- UI -----------------------------

    @IBOutlet weak var titleLabel: UILabel!

    @IBOutlet weak var textField: UITextField!

    @IBOutlet weak var hintLabel: UILabel!
    @IBOutlet weak var errorLabel: UILabel!


    // ------------------------- PRIVATE ---------------------------

    private var rowCasted: EurekaTextRow2!

    // ==============================================================



    override func initViews() {
        super.initViews()

        rowCasted = (row as! EurekaTextRow2)
        
        

        textField.borderStyle = .none
        textField.clearButtonMode = .always
        textField.placeholder = "Type something..."
        textField.backgroundColor = UIColor(hexString: "#ff0000")
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
        textField.rx.text.orEmpty.distinctUntilChanged().subscribe(onNext: { [weak self] value in
            self?.rowCasted.onResult.onNext(value)
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



public final class EurekaTextRow2: BaseEurekaRow2<EurekaTextCell2>, RowType {

    // ------------------ INNER CLASSES ------------------

    public enum InputType : String {
        case text, numeric
    }

    // ------------------ IN ------------------

    

    
    public override var value: String? {
        didSet {
            self.updateCell()
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
