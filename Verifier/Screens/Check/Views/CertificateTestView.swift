import UIKit
import Foundation
import SwiftDGC
import RealmSwift

class CertificateTestView: UIView {
       
    // MARK: - Subviews
    
    private let stackView = UIStackView()
    
    private let sectionTitle = CertificateSectionTitle()
    
    private let targetAgentView = TitleValueView()
    private let testTypeView = TitleValueView()
    private let testManufacturer = TitleValueView()
    private let sampleTakenAtView = TitleValueView()
    private let testResultView = TitleValueView()
    private let testLocationView = TitleValueView()
    private let countryView = TitleValueView()
    private let issuedBy = TitleValueView()
    
    
    private let monoLabel = Label(.monospaced)
    
    // MARK: - Holder
    
    public var holder: HCert? {
        didSet {
            
            let tests = holder?.body["t"].array
            guard let test = tests?.first else { return }
            
            
            let testingCenter = test["tc"].string ?? " - "
            let testResult = RLMValueSetValue.getDisplayNameByCode(valueSetName: .laboratoryResult, valueSetValueCode: test["tr"].string)
            let manufacturer = RLMValueSetValue.getDisplayNameByCode(valueSetName: .laboratoryTestManufacturer, valueSetValueCode: test["ma"].string)
            let issuer = test["is"].string ?? " - "
            let testType = RLMValueSetValue.getDisplayNameByCode(valueSetName: .laboratoryTestType, valueSetValueCode: test["tt"].string)
            
            
            
            let sampleTakenAt = test["sc"].string ?? " - "
            let targetAgent = RLMValueSetValue.getDisplayNameByCode(valueSetName: .diseaseAgentTargeted, valueSetValueCode: test["tg"].string)
            let country = RLMValueSetValue.getDisplayNameByCode(valueSetName: .country, valueSetValueCode: test["co"].string)
            

            targetAgentView.titleLabel.text = targetAgent
            testTypeView.titleLabel.text = testType
            testManufacturer.titleLabel.text = manufacturer
            sampleTakenAtView.titleLabel.text = sampleTakenAt
            testResultView.titleLabel.text = testResult
            testLocationView.titleLabel.text = testingCenter
            countryView.titleLabel.text = country
            issuedBy.titleLabel.text = issuer
        }
    }
    
    // MARK: - Init
    
    init() {
        super.init(frame: .zero)
        setup()
        
        
        
//        certificate_test_target_agent
        targetAgentView.descriptionLabel.text = UBLocalized.certificate_test_target_agent
        testTypeView.descriptionLabel.text = UBLocalized.certificate_test_type_of_test
        testManufacturer.descriptionLabel.text = UBLocalized.certificate_test_manufacturer
        sampleTakenAtView.descriptionLabel.text = UBLocalized.certificate_test_date_sample_collection
        testResultView.descriptionLabel.text = UBLocalized.certificate_test_result
        testLocationView.descriptionLabel.text = UBLocalized.certificate_test_testing_center
        countryView.descriptionLabel.text = UBLocalized.certificate_test_member_state
        issuedBy.descriptionLabel.text = UBLocalized.certificate_test_certificate_issuer
        
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

        sectionTitle.titleLabel.text = UBLocalized.certificate_test_section_title
        stackView.addArrangedView(sectionTitle)
        
        stackView.addArrangedView(targetAgentView)
        stackView.addArrangedView(testTypeView)
        stackView.addArrangedView(testManufacturer)
        stackView.addArrangedView(sampleTakenAtView)
        stackView.addArrangedView(testResultView)
        stackView.addArrangedView(testLocationView)
        stackView.addArrangedView(countryView)
        stackView.addArrangedView(issuedBy)
    }
}
