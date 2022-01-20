import UIKit
import SnapKit

import Nuke
import RxSwift
import RxCocoa
import SwiftDate
import RealmSwift

@IBDesignable
class FunkyButton: BaseUIView {
    
    
    @IBOutlet var xibContent: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    
    
    @IBInspectable
    var text: String = "" {
        didSet {
            self.titleLabel.text = text
        }
    }
    
    
    var disposeBag = DisposeBag()
    let result = PublishSubject<Void>()
    
    // ---------------------------------------------
    
    
    override func initViews() {
        super.initViews()
        initFromXib()
        
        // ---------- Customizations ----------
        
        titleLabel.textColor = .black
        titleLabel.setContentCompressionResistancePriority(.required, for: .horizontal)
        
        self.layer.borderColor = UIColor.black.cgColor
        self.layer.borderWidth = 1
        self.layer.cornerRadius = 0
    }
    
    override func initBindings() {
        self.rx
            .tapGesture { [unowned self] gestureRecognizer, delegate in
                gestureRecognizer.cancelsTouchesInView = false
        }
        .when(.recognized)
        .subscribe(onNext: { [weak self] _ in
            self?.result.onNext(())
        }).disposed(by: disposeBag)
    }
    
    override func prepareForInterfaceBuilder() {
        initViews()
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
