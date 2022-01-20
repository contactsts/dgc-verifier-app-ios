import UIKit
import SnapKit
import Nuke
import RxSwift
import RxCocoa
import SwiftDate
import RealmSwift



extension UITextField {
    func setLeftView(image: UIImage) {
        let iconView = UIImageView(frame: CGRect(x: 10, y: 15, width: 15, height: 15)) // set your Own size
        iconView.alpha = 0.4
        iconView.image = image
        let iconContainerView: UIView = UIView(frame: CGRect(x: 0, y: 0, width: 35, height: 45))
        iconContainerView.addSubview(iconView)
        leftView = iconContainerView
        leftViewMode = .always
        self.tintColor = .red
    }
    
    func setLeftPadding() {
        let iconContainerView: UIView = UIView(frame: CGRect(x: 0, y: 0, width: 15, height: 45))
        leftView = iconContainerView
        leftViewMode = .always
        self.tintColor = .red
    }
}

class SearchField: BaseUIView {
    
    
    @IBOutlet var xibContent: UIView!
    
    @IBOutlet weak var searchTextField: UITextField!
    
    var disposeBag = DisposeBag()
    
    // ---------------------------------------------
    
    
    override func initViews() {
        super.initViews()
        initFromXib()
        
        // ---------- Customizations ----------
        
        searchTextField.borderStyle = .none
        searchTextField.clearButtonMode = .always
        searchTextField.placeholder = "Search..."
        
        //        var searchImage = UIImage(named: "search")
        //
        //        searchTextField.leftViewMode = .always
        //        let searchImageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 10, height: 10))
        //        searchImageView.image = searchImage
        //        searchTextField.leftView = searchImageView
        
        searchTextField.setLeftView(image: UIImage.init(named: "search")!)
        searchTextField.tintColor = .darkGray
        searchTextField.layer.cornerRadius = 5
    }
    
    
    func initFromXib() {
        let name = String(describing: type(of: self))
        let bundle = Bundle(for: type(of: self))
        bundle.loadNibNamed(name, owner: self, options: nil)
        self.addSubview(xibContent)
        xibContent.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0))
        }
    }
    
    
    
}
