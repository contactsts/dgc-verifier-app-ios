import UIKit
import Foundation
import SwiftDGC
import RealmSwift

class CertificateVaccineView: UIView {
       
    // MARK: - Subviews
    
    private let stackView = UIStackView()
    
    private let sectionTitle = CertificateSectionTitle()
    
    private let targetAgentView = TitleValueView()
    private let vaccineProphylaxisView = TitleValueView()
    private let vaccineNameView = TitleValueView()
    private let vaccineAuthorityView = TitleValueView()
    private let doseNumberView = TitleValueView()
    private let vaccinationDateView = TitleValueView()
    private let countryView = TitleValueView()
    private let issuedBy = TitleValueView()
    
    
    private let monoLabel = Label(.monospaced)
    
    // MARK: - Holder
    
    public var holder: HCert? {
        didSet {
            
            let vaccines = holder?.body["v"].array
            guard let vaccine = vaccines?.first else { return }
            
            
            
            
            let doseNumber = vaccine["dn"].int != nil ? String(vaccine["dn"].int!) : " - "
            let country = RLMValueSetValue.getDisplayNameByCode(valueSetName: .country, valueSetValueCode: vaccine["co"].string)
            let medicalProduct = RLMValueSetValue.getDisplayNameByCode(valueSetName: .vaccineNames, valueSetValueCode: vaccine["mp"].string)
            let vaccineProfilaxis = RLMValueSetValue.getDisplayNameByCode(valueSetName: .sctVaccine, valueSetValueCode: vaccine["vp"].string)
            let authHolder = RLMValueSetValue.getDisplayNameByCode(valueSetName: .vaccineAuthHolder, valueSetValueCode: vaccine["ma"].string)
            let targetAgent = RLMValueSetValue.getDisplayNameByCode(valueSetName: .diseaseAgentTargeted, valueSetValueCode: vaccine["tg"].string)
            let serieDose = vaccine["sd"].int != nil ? String(vaccine["sd"].int!) : " - "
            let vaccinationDate = vaccine["dt"].string ?? " - "
            let issuer = vaccine["is"].string ?? " - "
            

            
            targetAgentView.titleLabel.text = targetAgent
            vaccineNameView.titleLabel.text = medicalProduct
            vaccineProphylaxisView.titleLabel.text = vaccineProfilaxis
            vaccineAuthorityView.titleLabel.text = authHolder
            doseNumberView.titleLabel.text = "\(doseNumber) / \(serieDose)"
            vaccinationDateView.titleLabel.text = vaccinationDate
            countryView.titleLabel.text = country
            issuedBy.titleLabel.text = issuer
        }
    }
    
    // MARK: - Init
    
    init() {
        super.init(frame: .zero)
        setup()
        
        
        
        
        
        targetAgentView.descriptionLabel.text = UBLocalized.certificate_vaccine_target_agent
        vaccineProphylaxisView.descriptionLabel.text = UBLocalized.certificate_vaccine_prophylaxis
        vaccineNameView.descriptionLabel.text = UBLocalized.certificate_vaccine_vaccine_name
        vaccineAuthorityView.descriptionLabel.text = UBLocalized.certificate_vaccine_authorization
        doseNumberView.descriptionLabel.text = UBLocalized.certificate_vaccine_doses
        vaccinationDateView.descriptionLabel.text = UBLocalized.certificate_vaccine_vaccination_date
        countryView.descriptionLabel.text = UBLocalized.certificate_vaccine_country
        issuedBy.descriptionLabel.text = UBLocalized.certificate_vaccine_issuer
        
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

        sectionTitle.titleLabel.text = UBLocalized.certificate_vaccine_section_title
        stackView.addArrangedView(sectionTitle)
        
        stackView.addArrangedView(targetAgentView)
        stackView.addArrangedView(vaccineProphylaxisView)
        stackView.addArrangedView(vaccineNameView)
        stackView.addArrangedView(vaccineAuthorityView)
        stackView.addArrangedView(doseNumberView)
        stackView.addArrangedView(vaccinationDateView)
        stackView.addArrangedView(countryView)
        stackView.addArrangedView(issuedBy)
    }
}
