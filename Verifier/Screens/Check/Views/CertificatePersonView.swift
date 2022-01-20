import UIKit
import Foundation
import SwiftDGC

class CertificatePersonView: UIView {

    private let stackView = UIStackView()
    
    private let sectionTitle = CertificateSectionTitle()
    
    private let nameView = TitleValueView()
    private let lastNameView = TitleValueView()
    private let birthdayView = TitleValueView()
    
    private let monoLabel = Label(.monospaced)
    
    // MARK: - Holder
    
    public var holder: HCert? {
        didSet {
            let gn = holder?.body["nam"]["gnt"].string ?? " - "
            nameView.titleLabel.text = gn
            
            let fn = holder?.body["nam"]["fnt"].string ?? " - "
            lastNameView.titleLabel.text = fn
            
            let dateOfBirth = holder?.body["dob"].string ?? " - "
            birthdayView.titleLabel.text = dateOfBirth
            
            
            let fnt = holder?.body["nam"]["fnt"].string ?? ""
            let gnt = holder?.body["nam"]["gnt"].string ?? ""
            let mono = "\(fnt)<<\(gnt)"
            monoLabel.text = mono
        }
    }
    
    // MARK: - Init
    
    init() {
        super.init(frame: .zero)
        setup()
        
        nameView.descriptionLabel.text = UBLocalized.certificate_person_first_name
        lastNameView.descriptionLabel.text = UBLocalized.certificate_person_last_name
        birthdayView.descriptionLabel.text = UBLocalized.certificate_person_birthdate
        
        accessibilityElements = [lastNameView, nameView, birthdayView, monoLabel]
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
        
        sectionTitle.titleLabel.text = UBLocalized.certificate_person_section_title
        stackView.addArrangedView(sectionTitle)
        stackView.addArrangedView(lastNameView)
        stackView.addArrangedView(nameView)
        stackView.addArrangedView(birthdayView)
//        stackView.addArrangedView(monoLabel)
    }
}
