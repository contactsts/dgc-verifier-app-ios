import UIKit
import Foundation
import SwiftDGC
import RealmSwift

class CertificateRecoveryView: UIView {
       
    // MARK: - Subviews
    
    private let stackView = UIStackView()
    
    private let sectionTitle = CertificateSectionTitle()
    
    private let targetAgentView = TitleValueView()
    private let firstResultView = TitleValueView()
    private let countryView = TitleValueView()
    private let issuedByView = TitleValueView()
    private let dateFromView = TitleValueView()
    private let dateUntilView = TitleValueView()
    
    private let monoLabel = Label(.monospaced)
    
    // MARK: - Holder
    
    public var holder: HCert? {
        didSet {
            
            let recoveries = holder?.body["r"].array
            guard let recovery = recoveries?.first else { return }
            
            
            let realm = try! Realm()

                    
            let targetAgent = RLMValueSetValue.getDisplayNameByCode(valueSetName: .diseaseAgentTargeted, valueSetValueCode: recovery["tg"].string)
            let dateFrom = recovery["df"].string ?? " - "
            let firstResult = recovery["fr"].string ?? " - "
            let country = recovery["co"].string ?? " - "
            let dateUntil = recovery["du"].string ?? " - "
            let issuer = recovery["is"].string ?? " - "
            
            
            
            targetAgentView.titleLabel.text = targetAgent
            dateFromView.titleLabel.text = dateFrom
            firstResultView.titleLabel.text = firstResult
            countryView.titleLabel.text = country
            dateUntilView.titleLabel.text = dateUntil
            issuedByView.titleLabel.text = issuer
        }
    }
    
    // MARK: - Init
    
    init() {
        super.init(frame: .zero)
        setup()
        
        targetAgentView.descriptionLabel.text = UBLocalized.certificate_recovery_targeted_agent
        firstResultView.descriptionLabel.text = UBLocalized.certificate_recovery_first_result
        countryView.descriptionLabel.text = UBLocalized.certificate_recovery_state_of_test
        issuedByView.descriptionLabel.text = UBLocalized.certificate_recovery_certificate_issuer
        dateFromView.descriptionLabel.text = UBLocalized.certificate_recovery_valid_from
        dateUntilView.descriptionLabel.text = UBLocalized.certificate_recovery_valid_until
        
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

        sectionTitle.titleLabel.text = UBLocalized.certificate_recovery_section_title
        stackView.addArrangedView(sectionTitle)
        
        stackView.addArrangedView(targetAgentView)
        stackView.addArrangedView(firstResultView)
        stackView.addArrangedView(countryView)
        stackView.addArrangedView(issuedByView)
        stackView.addArrangedView(dateFromView)
        stackView.addArrangedView(dateUntilView)
        
    }
}
