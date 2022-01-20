import UIKit
import Foundation
import SwiftDGC
import RealmSwift

class CertificateTehnicalView: UIView {
       
    // MARK: - Subviews
    
    private let stackView = UIStackView()
    
    private let sectionTitle = CertificateSectionTitle()
    
    private let schemaVersionView = TitleValueView()
    private let issuerView = TitleValueView()
    private let issuedAtView = TitleValueView()
    private let expiredAtView = TitleValueView()
    private let uvciView = TitleValueView()
    

    
    
    private let monoLabel = Label(.monospaced)
    
    // MARK: - Holder
    
    public var holder: HCert? {
        didSet {
            guard let holder = holder else { return }
            
            
            let schemaVersion = holder.body["ver"].string ?? " - "
            let issuer = holder.issCode
            let iat = DateUtils.formatDateToString(date: holder.iat)
            let exp = DateUtils.formatDateToString(date: holder.exp)

            
            schemaVersionView.titleLabel.text = schemaVersion
            issuerView.titleLabel.text = issuer
            issuedAtView.titleLabel.text = iat
            expiredAtView.titleLabel.text = exp
            uvciView.titleLabel.text = getUVCI(holder: holder)
        }
    }
    
    private func getUVCI(holder: HCert) -> String? {
        
        let uvciTest =  holder.body["t"].array?.first?["ci"].string
        if uvciTest != nil { return uvciTest }
        
        let uvciRecovery =  holder.body["r"].array?.first?["ci"].string
        if uvciRecovery != nil { return uvciRecovery }
        
        let uvciVaccine =  holder.body["v"].array?.first?["ci"].string
        if uvciVaccine != nil { return uvciVaccine }
        
        return " - "
    }
    
    // MARK: - Init
    
    init() {
        super.init(frame: .zero)
        setup()
        

        schemaVersionView.descriptionLabel.text = UBLocalized.certificate_tehnical_schema_version
        issuerView.descriptionLabel.text = UBLocalized.certificate_tehnical_issuer
        issuedAtView.descriptionLabel.text = UBLocalized.certificate_tehnical_issued_at
        expiredAtView.descriptionLabel.text = UBLocalized.certificate_tehnical_expires_at
        uvciView.descriptionLabel.text = UBLocalized.certificate_tehnical_uvci

        
//        accessibilityElements = [lastNameView, nameView, birthdayView, monoLabel]
        isAccessibilityElement = false
    }
    
    @available(*, unavailable)
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Setup
    private func setup() {
        addSubview(stackView)
        stackView.axis = .vertical
        stackView.spacing = 2.0 * Padding.medium
        
        stackView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }

        sectionTitle.titleLabel.text = "Detalii tehnice"
        stackView.addArrangedView(sectionTitle)
        
        stackView.addArrangedView(schemaVersionView)
        stackView.addArrangedView(issuerView)
        stackView.addArrangedView(issuedAtView)
        stackView.addArrangedView(expiredAtView)
        stackView.addArrangedView(uvciView)
    }
}
