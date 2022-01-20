import UIKit
import Foundation
import SwiftDGC

class CertificateData: UIView {
    
    
    private let stackScrollView = StackScrollView()
    
    private let certificatePersonView = CertificatePersonView()
    private let certificateTypeView = CertificateTypeView()
    
    private let certificateRecoveryView = CertificateRecoveryView()
    private let certificateTestView = CertificateTestView()
    private let certificateVaccineView = CertificateVaccineView()
    private let certificateTehnicalView = CertificateTehnicalView()
    
    private let loadingView = VerifyLoadingView()
    private let statusView = VerifyStatusView()
    private let infoView = VerifyInfoView()
    private let infoErrorView1 = VerifyInfoView()
    private let uselessWarning = UIView()
    private let uselessWarningLabel = UILabel()
    
    private let errorLabel = Label(.smallErrorLight, textAlignment: .right)
    
    
    public var holder: HCertPlus? {
        didSet {
            update(true)
        }
    }
    
    public var state: VerificationState? {
        didSet { update(true) }
    }
    
    
    
    // MARK: - Init
    
    init() {
        super.init(frame: .zero)
        setup()
        
    }
    
    @available(*, unavailable)
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Setup
    
    private func setup() {
        self.addSubview(stackScrollView)
        
        stackScrollView.scrollView.alwaysBounceVertical = false
        stackScrollView.stackView.spacing = Padding.small
        stackScrollView.stackView.isLayoutMarginsRelativeArrangement = true
        let p = Padding.medium + Padding.small
        stackScrollView.stackView.layoutMargins = UIEdgeInsets(top: 0.0, left: p, bottom: 0.0, right: p)
        
        stackScrollView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        stackScrollView.addArrangedView(loadingView)
        stackScrollView.addArrangedView(infoErrorView1)
        stackScrollView.addArrangedView(statusView)
        stackScrollView.addArrangedView(infoView)
        stackScrollView.addArrangedView(errorLabel)
        
        
        uselessWarningLabel.font = UIFont.systemFont(ofSize: 12)
        uselessWarningLabel.numberOfLines = 0
        uselessWarningLabel.textAlignment = .center
        uselessWarning.backgroundColor = UIColor(hexString: "#ffecb3")
        uselessWarning.layer.cornerRadius = 5
        uselessWarning.addSubview(uselessWarningLabel)
        uselessWarningLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(6)
            make.trailing.equalToSuperview().offset(-6)
            make.bottom.equalToSuperview().offset(-6)
            make.leading.equalToSuperview().offset(6)
        }
        stackScrollView.addArrangedView(uselessWarning)
        
        infoErrorView1.ub_setHidden(true)
        statusView.ub_setHidden(true)
        infoView.ub_setHidden(true)
        errorLabel.ub_setHidden(true)
        uselessWarning.ub_setHidden(true)
        
        let v = UIView()
        v.addSubview(certificatePersonView)
        
        certificatePersonView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
            //                .inset(UIEdgeInsets(top: Padding.large + Padding.small, left: p, bottom: p, right: p))
        }
        
        
        
        let dividerSpace = UIView()
        dividerSpace.snp.makeConstraints { make in
            make.height.equalTo(3)
        }
        stackScrollView.addArrangedView(dividerSpace)
        
        stackScrollView.addArrangedView(certificateTypeView)
        stackScrollView.addArrangedView(v)
        
        stackScrollView.addArrangedView(certificateRecoveryView)
        stackScrollView.addArrangedView(certificateTestView)
        stackScrollView.addArrangedView(certificateVaccineView)
        stackScrollView.addArrangedView(certificateTehnicalView)
        
        
        
        // ===================== Other stuff ============================
        
        infoErrorView1.set(text: UBLocalized.verifier_verify_success_info_for_certificate_valid, backgroundColor: .cc_greyish, icon: UIImage(named: "ic-privacy-gray"), showReloadButton: false)
    }
    
    
    public func update(_ animated: Bool) {
        
        
        stackScrollView.scrollView.setContentOffset(.zero, animated: false)
        // content changes
        certificatePersonView.holder = holder?.hCert
        certificateTypeView.holder = holder?.hCert
        certificateVaccineView.holder = holder?.hCert
        certificateTehnicalView.holder = holder?.hCert
        
        
        
        certificateRecoveryView.holder = holder?.hCert
        certificateTestView.holder = holder?.hCert
        
        switch holder?.hCert?.type {
            
        case .recovery:
            certificateTestView.ub_setHidden(true)
            certificateVaccineView.ub_setHidden(true)
            certificateRecoveryView.ub_setHidden(false)
            
        case .test:
            certificateTestView.ub_setHidden(false)
            certificateVaccineView.ub_setHidden(true)
            certificateRecoveryView.ub_setHidden(true)
            
        case .vaccine:
            certificateTestView.ub_setHidden(true)
            certificateVaccineView.ub_setHidden(false)
            certificateRecoveryView.ub_setHidden(true)
            
        default:
            print("Nothing")
        }
        
        certificateTehnicalView.ub_setHidden(false)
        
        
        
        errorLabel.text = nil
        
        switch state {
        case .loading:
            loadingView.rotate()
        case .success:
            self.statusView.ub_setHidden(false)
            statusView.set(text: UBLocalized.verifier_verify_success_title.bold(), backgroundColor: .cc_greenish, icon: UIImage(named: "ic-check"))
            //            errorLabel.text = UBLocalized.verifier_qr_scanner_scan_qr_success
            
            if holder?.hCert?.type == .test {
                uselessWarning.ub_setHidden(false)
                uselessWarningLabel.text = UBLocalized.verifier_qr_scanner_scan_qr_success
            }
            
            
            
        case let .failure(errorsList):
            self.statusView.ub_setHidden(false)
            
            let color: UIColor = .cc_redish
            
            
            let text: NSAttributedString = UBLocalized.verifier_verify_error_info_for_certificate_invalid.bold()
            
            statusView.set(text: text, backgroundColor: color, icon: UIImage(named: "ic-info-alert-red"))
            
            let codes = errorsList.map { currentError in
                switch currentError {
                case "Cryptographic signature not valid.":
                    return UBLocalized.verifier_verify_error_info_for_certificate_invalid_invalid_signature
                case "Certificate past expiration date.":
                    return UBLocalized.verifier_verifiy_error_expired
                case "Certificate issuance date is in the future.":
                    return UBLocalized.verifier_verifiy_error_issuance_date_is_in_future
                case "No entries in the certificate.":
                    return UBLocalized.verifier_verifiy_error_no_entries
                    
                case "Recovery statement is not valid yet.":
                    
                    return UBLocalized.verifier_verifiy_error_no_entries
                    //                    "hcert.err.rec.future" = "Recovery statement is not valid yet.";
                    //                    "hcert.err.rec.past" = "Recovery statement is not valid anymore.";
                    
                default:
                    return currentError
                }
            }.joined(separator: "\n")
            if codes.count > 0 {
                errorLabel.text = codes
            }
            
            
        case .none:
            break
        }
        
        // animations
        let actions = {
            switch self.state {
            case .loading:
                self.loadingView.rotate()
                
                self.loadingView.ub_setHidden(false)
                self.statusView.ub_setHidden(true)
                //                self.infoView.ub_setHidden(true)
                self.errorLabel.ub_setHidden(true)
                //                self.infoErrorView1.ub_setHidden(true)
            case .success:
                self.loadingView.stopRotation()
                
                self.loadingView.ub_setHidden(true)
                self.statusView.ub_setHidden(false)
                //                self.infoView.ub_setHidden(false)
                self.errorLabel.ub_setHidden(false)
                self.errorLabel.textAlignment = .center
                //                self.infoErrorView1.ub_setHidden(true)
                
            case .failure:
                
                //                let (signatureError, revocationError, _) = self.state?.getVerifierErrorState() ?? (nil, nil, nil)
                //
                //                let showInfo1 = signatureError == nil
                //                let showInfo2 = showInfo1 && revocationError == nil && !(self.state?.wasRevocationSkipped ?? false)
                let showInfo1 = true
                let showInfo2 = true
                self.loadingView.stopRotation()
                
                self.loadingView.ub_setHidden(true)
                self.statusView.ub_setHidden(false)
                //                self.infoView.ub_setHidden(true)
                //                self.infoErrorView1.ub_setHidden(!showInfo1)
                self.errorLabel.ub_setHidden(false)
            default:
                break
            }
            
            self.stackScrollView.stackView.layoutIfNeeded()
            self.layoutIfNeeded()
        }
        
        if animated {
            UIView.animate(withDuration: 0.25) {
                actions()
            }
        } else {
            actions()
        }
    }
}
