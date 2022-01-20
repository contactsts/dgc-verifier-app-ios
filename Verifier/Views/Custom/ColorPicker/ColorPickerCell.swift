import UIKit
import SnapKit
import Nuke
import RxSwift
import RxCocoa
import SwiftDate
import RealmSwift

class ColorPickerCell: BaseUICollectionViewCell {
    
    var colorView: ColorView = {
        let view = ColorView()

        return view
    }()
    
    var colorNameLabel: UILabel = {
        let view = UILabelUtils.getSubtitleLabel()
        view.numberOfLines = 0
        view.textAlignment = .center
        return view
    }()
    
    // -----------------------------------------------
    
    var materialColor: MaterialColor? {
        didSet {
            guard let materialColor = materialColor else {
                return
            }
            
            colorView.backgroundColor = materialColor.color
            colorNameLabel.text = "\(materialColor.name)\n\(materialColor.shade.rawValue)"
        }
    }
    
    
    var disposeBag = DisposeBag()
    
    // ---------------------------------------------
    
    //    override init(frame: CGRect) {
    //        super.init(frame: frame)
    //        self.cellInit()
    //    }
    
    //    required init?(coder aDecoder: NSCoder) {
    //        super.init(coder: aDecoder)
    //        self.cellInit()
    //    }
    
    override func initViews() {
        super.initViews()
        cellBackground.addSubview(colorView)
        cellBackground.addSubview(colorNameLabel)
        bottomDivider.isHidden = true
//        cellBackground.backgroundColor = .green
    }
    
    override func initLayout() {
        super.initLayout()
        
        colorView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(6)
            make.width.equalTo(colorView.snp.height)
            make.centerX.equalToSuperview()
        }
        
        colorNameLabel.snp.makeConstraints { make in
            make.top.equalTo(colorView.snp.bottom).offset(6)
            make.bottom.equalToSuperview().offset(-12)
            make.centerX.equalToSuperview()
        }
    }
    
    override func initBindings() {
        
    }
    
    
}
