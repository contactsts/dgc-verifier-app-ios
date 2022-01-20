import UIKit
import Foundation
import SwiftDGC

class CertificateTypeView: UIView {
    // MARK: - Title View
    

    
    // MARK: - Subviews
    
    private let stackViewBackgroundView = UIView()
    private let stackView = UIStackView()
    
    private let titleTest = UILabel()
    private let titleVaccine = UILabel()
    private let titleRecovery = UILabel()
    
    private let separator1 = UIView()
    private let separator2 = UIView()
    
    private let borderWidth = 1.0
    private let borderColor = UIColor.black
    private let selectedColor = UIColor(hexString: "#243784")
    private let unselectedColor = UIColor.white.withAlphaComponent(0.2)
    
    // MARK: - Holder
    
    public var holder: HCert? {
        didSet {
            let vaccineSelected = holder?.body["v"].array != nil
            let recoverySelected = holder?.body["r"].array != nil
            let testSelected = holder?.body["t"].array != nil
            
            titleTest.backgroundColor = testSelected ? selectedColor : unselectedColor
            titleRecovery.backgroundColor = recoverySelected ? selectedColor : unselectedColor
            titleVaccine.backgroundColor = vaccineSelected ? selectedColor : unselectedColor

            
            titleTest.textColor = testSelected ? .white : .black
            titleRecovery.textColor = recoverySelected ? .white : .black
            titleVaccine.textColor = vaccineSelected ? .white : .black
        }
    }
    
    // MARK: - Init
    
    init() {
        super.init(frame: .zero)
        setup()
        
        titleTest.text = UBLocalized.certificate_type_test
        titleVaccine.text = UBLocalized.certificate_type_vaccine
        titleRecovery.text = UBLocalized.certificate_type_recovery
        
        
        titleTest.textAlignment = .center
        titleVaccine.textAlignment = .center
        titleRecovery.textAlignment = .center
    }
    
    @available(*, unavailable)
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Setup
    
    private func setup() {
        addSubview(stackView)
        stackView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        stackView.axis = .horizontal
//        stackView.distribution = .fillEqually
        stackView.spacing = 0
        
        
        addSubview(stackViewBackgroundView)
        stackViewBackgroundView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        stackViewBackgroundView.layer.borderColor = borderColor.cgColor
        stackViewBackgroundView.layer.borderWidth = borderWidth
        stackViewBackgroundView.layer.cornerRadius = 5
        
        separator1.backgroundColor = borderColor
        separator2.backgroundColor = borderColor
        
        stackView.layer.cornerRadius = 5
        stackView.clipsToBounds = true
        
        stackView.addArrangedView(titleTest)
        stackView.addArrangedView(separator1)
        stackView.addArrangedView(titleVaccine)
        stackView.addArrangedView(separator2)
        stackView.addArrangedView(titleRecovery)
        
        titleTest.snp.makeConstraints { make in
            make.height.equalTo(35)
        }
        
        separator1.snp.makeConstraints { make in make.width.equalTo(borderWidth)}
        separator2.snp.makeConstraints { make in make.width.equalTo(borderWidth)}
        
        titleTest.snp.makeConstraints { make in
            make.width.equalTo(titleVaccine)
            make.width.equalTo(titleRecovery)
        }
        
        
        
        
        
    }
    
    
    func roundCorners(view :UIView, corners: UIRectCorner, radius: CGFloat){
            let path = UIBezierPath(roundedRect: view.bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
            let mask = CAShapeLayer()
            mask.path = path.cgPath
            view.layer.mask = mask
    }
    
}
