//
/*
 * Copyright (c) 2021 Ubique Innovation AG <https://www.ubique.ch>
 *
 * This Source Code Form is subject to the terms of the Mozilla Public
 * License, v. 2.0. If a copy of the MPL was not distributed with this
 * file, You can obtain one at https://mozilla.org/MPL/2.0/.
 *
 * SPDX-License-Identifier: MPL-2.0
 */

//
import AVFoundation
import Foundation
import SwiftCBOR
import SwiftDGC
import UIKit
import RxSwift
import RxCocoa
import RxGesture
import RealmSwift

class VerifyScannerViewController: ViewController {
    // MARK: - Public Callbacks
    
    var player: AVAudioPlayer?
    private let requestLabel = Label(.textBold, textColor: .white, textAlignment: .center)
    
    
    //    public var scanningSucceededCallback: ((HolderModel) -> Void)?
    public var scanningSucceededCallback: ((HCertPlus) -> Void)?
    public var dismissTouchUpCallback: (() -> Void)?
    let certificatesCount = BehaviorRelay<Int>(value: 0)
    
    private var timer: Timer?
    
    public func restart() {
        cameraErrorView?.alpha = 0.0
        showError(error: nil)
        qrView?.startScanning()
        qrView?.setCameraLight(on: isLightOn)
    }
    
    // MARK: - Subviews
    
    // -------------------------- PRIVATE ------------------------------
    
    private var isLightOn: Bool = false
    
    var isToggleExternalOn : Bool = false {
        didSet {
            countryPickerView.isHidden = !isToggleExternalOn
            let image = isToggleExternalOn ? UIImage(named: "rules-external") : UIImage(named: "rules-internal")
            toggleExternalButton.setImage(image, for: UIControl.State.normal)
            externalRulesInfo.text = isToggleExternalOn ? UBLocalized.verifier_qr_scanner_scan_qr_external : UBLocalized.verifier_qr_scanner_scan_qr_internal
        }
    }
    
    var currentCountry : FLCountry? {
        didSet {
            countryPickerView.country = currentCountry
        }
    }
    
    let disposeBag = DisposeBag()
    
    // ---------------------------- UI ----------------------------------
    
    private var noCertificateWarning = UIView()
    private var noCertificateWarningLabel = UILabel()
    
    private var qrView: QRScannerView?
    private let overlayView = VerifierQRScannerFullOverlayView()
    
    
    private let lightButton = ScannerLightButton.verifierButton()
    
    
    
    private let toggleExternalButton = ImageButton(icon: "ic-notification")
    //    private let toggleExternalButton = Button(image: UIImage(named: "ic-notification")?.ub_image(with: .white), accessibilityName: UBLocalized.close_button)
    
    
    private let externalRulesInfo = UILabel()
    private let countryPickerView = CountryPickerView()
    
    private let fakeScanButton1 = Button(image: UIImage(named: "ic-scan-code")?.ub_image(with: .white), accessibilityName: UBLocalized.close_button)
    private let fakeScanButton2 = Button(image: UIImage(named: "ic-scan-code")?.ub_image(with: .white), accessibilityName: UBLocalized.close_button)
    private let fakeScanButton3 = Button(image: UIImage(named: "ic-scan-code")?.ub_image(with: .white), accessibilityName: UBLocalized.close_button)
    
    
    
    
    
    private let label = Label(.uppercaseBold, textColor: .white, textAlignment: .center)
    private let closeButton = Button(image: UIImage(named: "ic-close")?.ub_image(with: .white), accessibilityName: UBLocalized.close_button)
    
    private var cameraErrorView: CameraErrorView?
    
    
    // =============================================================================
    
    // MARK: - Init
    
    override init() {
        super.init()
        qrView = QRScannerView(delegate: self)
        
        
        self.setupPlayer()
        let realm = try! Realm()
        let certificatesResult = realm.objects(RLMCertificate.self)
        
    
        Observable.collection(from: certificatesResult)
            .subscribe { [weak self] event in
                let certificatesCount = event.element?.count ?? 0
                self?.noCertificateWarning.isHidden = (certificatesCount > 0)
        }
        .disposed(by: disposeBag)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setup()
        setupInteraction()
        
        restart()
        
        isToggleExternalOn = false
        currentCountry = CountryManager.sharedInstance.defaultCountry
        
        
        NotificationCenter.default.addObserver(forName: UIApplication.didBecomeActiveNotification, object: nil, queue: nil) { [weak self] _ in
            guard let strongSelf = self else { return }
            strongSelf.restart()
        }
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        stopScanning()
    }
    
    // MARK: - Setup
    private func setupPlayer() {
        guard let path = Bundle.main.path(forResource: "beep", ofType:"ogg") else {
             return }
         let url = URL(fileURLWithPath: path)
        do {
            player = try AVAudioPlayer(contentsOf: url)
        } catch let error {
            print(error.localizedDescription)
        }
    }
    
    private func setupInteraction() {
        
        view.rx
            .swipeGesture([.down, .right])
            .when(.recognized)
            .subscribe(onNext: { [weak self] gesture in
                self?.dismissTouchUpCallback?()
            })
            .disposed(by: disposeBag)
        
        
        closeButton.touchUpCallback = { [weak self] in
            guard let strongSelf = self else { return }
            strongSelf.dismissTouchUpCallback?()
        }
        
        lightButton.touchUpCallback = { [weak self] in
            guard let strongSelf = self else { return }
            strongSelf.toggleLight()
        }
        
        toggleExternalButton.touchUpCallback = { [weak self] in
            guard let strongSelf = self else { return }
            strongSelf.toggleInternalExternal()
        }
        
        countryPickerView.rx.tapGesture().when(.recognized).subscribe(onNext: { [weak self] _ in
            self?.selectExternalCountry()
        }).disposed(by: disposeBag)
        
        fakeScanButton1.touchUpCallback = { [weak self] in
            guard let strongSelf = self else { return }
            strongSelf.fakeScan(1)
        }
        
        fakeScanButton2.touchUpCallback = { [weak self] in
            guard let strongSelf = self else { return }
            strongSelf.fakeScan(2)
        }
        
        fakeScanButton3.touchUpCallback = { [weak self] in
            guard let strongSelf = self else { return }
            strongSelf.fakeScan(3)
        }
        
        fakeScanButton1.touchUpCallback = { [weak self] in
            guard let strongSelf = self else { return }
            strongSelf.fakeScan(1)
        }
        
        noCertificateWarning.rx.tapGesture().when(.recognized).subscribe(onNext: { [weak self] _ in
            guard let strongSelf = self else { return }
            let settingsVC = SettingsViewController()
            settingsVC.presentInNavigationController(from: strongSelf)
        }).disposed(by: disposeBag)
    }
    
    private func setup() {
        if let qv = qrView {
            view.addSubview(qv)
            qv.snp.makeConstraints { make in
                make.edges.equalToSuperview()
            }
            
            view.addSubview(overlayView)
            
            overlayView.snp.makeConstraints { make in
                make.edges.equalToSuperview()
            }
        }
        
        let backgroundView = UIView()
        backgroundView.backgroundColor = UIColor.cc_black.withAlphaComponent(0.5)
        
        view.addSubview(backgroundView)
        
        let statusBarHeight = UIApplication.shared.statusBarFrame.size.height
        
        backgroundView.snp.makeConstraints { make in
            make.top.left.right.equalToSuperview()
            make.height.equalTo(statusBarHeight <= 20.0 ? 90.0 : 110.0)
        }
        
        backgroundView.addSubview(label)
        
        label.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.bottom.equalToSuperview().inset(Padding.medium + 2.0)
        }
        
        label.text = UBLocalized.verifier_title_qr_scan
        
        backgroundView.addSubview(closeButton)
        
        closeButton.snp.makeConstraints { make in
            make.right.equalToSuperview().inset(Padding.small)
            make.centerY.equalTo(label)
            make.size.equalTo(44.0)
        }
        
        // ---------
        
        view.addSubview(noCertificateWarning)
        noCertificateWarning.snp.makeConstraints { make in
            make.top.equalTo(label.snp.bottom).offset(40)
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().offset(-20)
        }
        noCertificateWarning.backgroundColor = .white
        noCertificateWarning.layer.cornerRadius = 5
        
        noCertificateWarningLabel.numberOfLines = 0
        noCertificateWarningLabel.text = UBLocalized.error_no_certificates_please_resync
        noCertificateWarningLabel.textColor = .red
        noCertificateWarningLabel.font = UIFont.boldSystemFont(ofSize: 15)
        noCertificateWarningLabel.textAlignment = .center
        noCertificateWarningLabel.backgroundColor = .clear
        
        noCertificateWarning.addSubview(noCertificateWarningLabel)
        noCertificateWarningLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(8)
            make.trailing.equalToSuperview().offset(-8)
            make.bottom.equalToSuperview().offset(-8)
            make.leading.equalToSuperview().offset(8)
        }
        noCertificateWarning.isUserInteractionEnabled = true
        
        // ---------
        
        

        
        
        
        if qrView?.canEnableTorch ?? false {
            view.addSubview(lightButton)
            lightButton.snp.makeConstraints { make in
                let bottomPadding = UIApplication.shared.keyWindow?.safeAreaInsets.bottom ?? 0.0
                if bottomPadding > 0 {
                    make.bottom.equalTo(self.view.snp.bottomMargin).inset(Padding.medium)
                } else {
                    make.bottom.equalToSuperview().inset(Padding.large)
                }
                
                make.right.equalToSuperview().offset(-Padding.medium - Padding.small)
            }
        }
        
        view.addSubview(toggleExternalButton)
        toggleExternalButton.snp.makeConstraints { make in
            make.right.equalToSuperview().offset(-Padding.medium - Padding.small)
            
            if qrView?.canEnableTorch ?? false {
                make.bottom.equalTo(lightButton.snp.top).offset(-Padding.medium - Padding.small)
            } else {
                let bottomPadding = UIApplication.shared.keyWindow?.safeAreaInsets.bottom ?? 0.0
                if bottomPadding > 0 {
                    make.bottom.equalTo(self.view.snp.bottomMargin).inset( 2 * Padding.medium + 44)
                } else {
                    make.bottom.equalToSuperview().inset(2 * Padding.large + 44)
                }
            }
            
            
        }

        
        // -----
        let qrLeftMargin = 2.0 * Padding.medium + VerifierQRScannerOverlay.lineWidth * 1.5
        let delta =  UIScreen.main.bounds.size.width / 2 - qrLeftMargin
        view.addSubview(requestLabel)
        requestLabel.snp.makeConstraints { make in
//            make.top.equalTo(scannerOverlay.snp.bottom).offset(Padding.large + Padding.small)
            make.top.equalTo(view.snp.centerY).offset(delta + Padding.medium)
            make.left.right.equalTo(view)
        }
        
        requestLabel.text = UBLocalized.verifier_qr_scanner_scan_qr_text
        
        
       
        externalRulesInfo.textColor = .white
        externalRulesInfo.numberOfLines = 0
        externalRulesInfo.textAlignment = .center
        externalRulesInfo.font = UIFont.systemFont(ofSize: 14)
        view.addSubview(externalRulesInfo)
        externalRulesInfo.snp.makeConstraints { make in
            
            make.top.equalTo(requestLabel.snp.bottom).offset(16)
//            make.top.equalTo(toggleExternalButton.snp.top).offset(10)
            make.leading.equalToSuperview().offset(75)
            make.trailing.equalToSuperview().offset(-75)
//            make.bottom.equalToSuperview().offset(-60)
        }
        
        countryPickerView.setColorMode(.white)
        countryPickerView.nameLabel.textColor = .white
        countryPickerView.chevronImageView.tintColor = .white
        view.addSubview(countryPickerView)
        countryPickerView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.height.equalTo(42)
            make.top.equalTo(externalRulesInfo.snp.bottom).offset(3
            )
            
//            make.bottom.equalTo(externalRulesInfo.snp.top).offset(-8)
//            make.top.equalTo(toggleExternalButton.snp.top).offset(5)
        }
        
        
        
        
        
//        if Environment.current == .dev {
        if false {
            view.addSubview(fakeScanButton1)
            view.addSubview(fakeScanButton2)
            view.addSubview(fakeScanButton3)
            fakeScanButton3.snp.makeConstraints { make in
                let bottomPadding = UIApplication.shared.keyWindow?.safeAreaInsets.bottom ?? 0.0
                if bottomPadding > 0 {
                    make.bottom.equalTo(self.view.snp.bottomMargin).inset(Padding.medium)
                } else {
                    make.bottom.equalToSuperview().inset(Padding.large)
                }
                
                let rightMargin = (qrView?.canEnableTorch ?? false ) ? lightButton.snp.left : view.snp.right
                
                make.right.equalTo(rightMargin).offset(-Padding.medium - Padding.small)
                
                make.top.equalTo(fakeScanButton1.snp.top)
                make.top.equalTo(fakeScanButton2.snp.top)
            }
            
            fakeScanButton2.snp.makeConstraints { make in
                make.right.equalTo(fakeScanButton3.snp.left).offset(-Padding.medium - Padding.small)
            }
            fakeScanButton1.snp.makeConstraints { make in
                make.right.equalTo(fakeScanButton2.snp.left).offset(-Padding.medium - Padding.small)
            }
        }
        
        
        
        cameraErrorView = CameraErrorView(backgroundColor: UIColor(white: 0.6, alpha: 1.0), center: true)
        view.addSubview(cameraErrorView!)
        cameraErrorView?.snp.makeConstraints { make in
            make.top.equalTo(backgroundView.snp.bottom)
            make.left.right.bottom.equalToSuperview()
        }
        
        cameraErrorView?.alpha = 0.0
    }
    
    private func toggleLight() {
        isLightOn = !isLightOn
        qrView?.setCameraLight(on: isLightOn)
        lightButton.isOn = isLightOn
    }
    
    private func toggleInternalExternal() {
        isToggleExternalOn = !isToggleExternalOn
    }
    
    
    private func selectExternalCountry() {
        let countryPickerVC = CountryPickerVC()
        countryPickerVC.result.subscribe(onNext: { [weak self] country in
            self?.currentCountry = country
        })
//        if self.navigationController == nil {
            self.present(countryPickerVC, animated: true, completion: nil)
//        } else {
//            self.navigationController?.pushViewController(countryPickerVC, animated: true)
//        }
        
    }
    
    private func fakeScan(_ type: Int) {
        
        
        
        
        let fakeProd = "HC1:NCFOXN%TSMAHN-HBUKN8N2A709SZ%K0II0S7 437PG/EB2QINOUA4DIL9APC5BD/GPWBILC9GGBYPLR-SNH10EQ928GEQW2DVJ5/O8*44$L5XK2AL867E%CM M9$/7O4KAJ2KRC911X4JFQE/ARZ88I9EU7J$*S-CK9B92FF9B9LW4G%89-8CNNM3L:Y0VD9B.OD4OYGFO-O%Z8JH1PCDJ*3TFH2V4IE9MIHJ6W48UK.GCY0$2PH/MIE9WT0K3M9UVZSVV*001HW%8UE9.955B9-NT0 2$$0X4PCY0+-CVYCDEBD0HX2JR$4O1K8KES/F-1JJ.KELN HGX2M%DB.-B97U: K- NW2DAEW$K4U0GS0IOHK9NTTKLC:H02K KP8EF1CBZ71-DMBLE/*BLVAFT5D75W9AAABG64TOS*WL2JC4:B*TJ0LC SES77VZBE1QBV7*NE8MV:CUJPE3AW.X0/0AS0BH.JQOQ% MV314DG7*LVXRL1F:+AG:BC8VTEN89Q8XSNHLR20J.BN1"
        
        let fakePreProdVaccine = "HC1:NCFOXN%TSMAHN-H-ZSZHLRB432A+2OH62WHC1PCRAISRH$QSI+C/+6RWG09OPV5-FJLF6CB9YPD.+IKYJH84:H3J1D1I3-*TW C57DO*SWY2113*SDMWTTIDLFK.+I WJM*Q9ZIHAPZXI$MI1VCSWC%PD5DL*9D.XIKXB8UJ06J9UBSVAXCIF4LEIIPBJ NIIZI.EJJ14B2MZ8DC8C6P16RD:XIBEIVG395EV3EVCK09D5WCFVA.QO5VA81K0ECM8CXVDC8C90JK.A96UJBC.P2R9CWZJ$7K+ CMEDBA1%IOEA7IB65C94JB-OM+/F9JAY-B/69K/FR/FOKEH-BFQMV8OBLEH-B1KB2WLQSHT7AUDBQEAJJKKKMWC8.RGWWDF FZWR8M3K734FI35J$JVY37S-PV0ALDMM 98DALIE99L99P.T9ZIR1VBDG5U9OS0P.4P429YS96.7/E8ZHFI+RJP5D9V49I$90LZVH2"
        
        let fakePreProdRecovery = "HC1:NCFOXN%TSMAHN-H-ZSZHLRB432A+2OH62%6D1PCRAISRHRRS1WT/+6RWG09OPV5-FJLF6CB93KD62KKYJH84:H3J1D1I3-*TW C57DO*S0U2FVCMSTRIDW+C:FL$7K WJM*Q9ZIQ0J1VCSWC%PDX1L3ADZXI+G1 73M70MIAY8286QXQ6IWM0EP8L6IWMW KAHA508XIORW6%5L*M47Q4UYQD*O%+Q.SQBDO4A7E:7LYP5PQSFLBK8GEQEA7IB65C94JBW+82C83DAZI9Q-B6LF00JZED+-C7DAHFE*ED4JB%B90AE74D68LV8OBLEH-B00JSELP2DQBI DM89DUDBQEAJJKKKMWC80Q8VRDICPQ6LD$SE6G/ HS1JAPTBO4E0VYZG+-T:GM*9S*2OB/4GBVK/FO$V75MI7D:W532P1%VO*45BM/-H-TD*4G1$5PZA%3UHV5:00EGR75"
        
                let fakePreprodTest = "HC1:NCFM70P90T9WTWGSLKC 4699FSPITA*1TYTTABB0XKFJCN:93F3*.3KES3F3KK3R-1Y50.FK6ZKZWERILOPCC8FHZA1+9LZAZM81G72A6BIAYG731BLS92T9I%6QBA0S6UPCFJCR1A+EDBKEZED+EDKWE3EFX3ET34X C:VD$8DB$D:TC 47B56JQE%EONF6OF63W5Q47:96.SAM%66461G73564KCVPC5UA QEZEDU1DKPCG/D5$C6344KCD3DX47B46IL6646H*6KWEKDDC%6-Q6QW66464KCAWE6T9G%6G%67W5JPCT3E5JDOA7Q478465W5I*6..DX%DZJC4/DN7A8%EX CH/D JC1/D.Y81$C1ECW.CAWE 6AJZA:X8S+9MPCG/D5 C+S98+9$PC5$CUZC$$5Y$527BIB82ME:8JXG7A:T RR789++OFPUQ2LY2L3YNHSUVAEIYIRXVBSP9/TDURK*0CVFBH3ZYS6 POWN*4H962UQ9+GGJINGKLVMLY02J3G"
        
//        let fakePreprodTest = "HC1:NCFOXN%TSMAHN-HWVK8 TLRBH9UY3I:D4-$C-36:X0-TMYZ4VWSK8QK.I*A5C%OQHIZC4.OI1RM8ZA*LP1Z2GHKW/F3IKJ5QH*AA:GJF8+:A0%0I-7FB8L4TU 4K/B$B2SA0.928.FP3P1KS$6UR0JJ7SO3Q0OPM98IMIBRU4SI.J9WVHWVH+ZEPV1AT1HRI%SHPVFNXUJRH0LH%Y2 UQ7S7TK24H95NITK292W7*RBT1ON1EYHXJD SI5K1*TB3:U-1VVS1UU15%HTNIPPAAMI PQVW5/O16%HAT1Z%PHOP+MMBT16Y5+Z9XV7G+SI*V2BKVZ0CNNL2J--87LPMIH-O92UQ4QM3O8/XJ7%FXSGJO83UQRTU:/HMZ8$E7TOT2RVN.02SV6ALG%I%95F/94O5MV1UN05EM$E5UM97H98$QP3R8BHTJTAZP1:GWZFH9RJCWM2C:YFEGSXOR%1CJL2* NI4UL+C-9954Q7OVM9EAGEW%B%+1JVHBXUQU74UKUSC20VS5QYW0X HBHNT*93YV4I2VAMEWG"
        
        
        var code = ""
        switch type {
        case 1:
            code = fakePreprodTest
        case 2:
            code = fakePreProdVaccine
        case 3:
            code = fakePreProdRecovery
        default:
            code = ""
        }
        
        qrScanningSucceededWithCode(code)
    }
    
    private func showError(error: CovidCertError?) {
        if error != nil {
            overlayView.showErrorView(error: error, animated: true)
            
            timer?.invalidate()
            timer = Timer.scheduledTimer(withTimeInterval: 1.5, repeats: false, block: { [weak self] _ in
                guard let strongSelf = self else { return }
                UIView.animate(withDuration: 0.2) {
                    strongSelf.showError(error: nil)
                }
            })
            
        } else {
            overlayView.showErrorView(error: error, animated: true)
        }
    }
    
    private func stopScanning() {
        timer?.invalidate()
        timer = nil
        qrView?.stopScanning()
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
}

extension VerifyScannerViewController: QRScannerViewDelegate {
    func qrScanningDidFail() {
        cameraErrorView?.alpha = 1.0
    }
    
    func qrScanningSucceededWithCode(_ str: String?) {
        
        print("QR code = %@", str)
        player?.play()
        
        if var certificate = HCert(from: str ?? "") {
            qrView?.stopScanning()
            
            let feedback = UIImpactFeedbackGenerator(style: .heavy)
            feedback.impactOccurred()
            
            var hCertPlus = HCertPlus(hCert: certificate, isExternal: isToggleExternalOn, country: currentCountry)
            hCertPlus.ruleValidationResult = hCertPlus.validateCertLogicRules()
            
            scanningSucceededCallback?(hCertPlus)
        } else {
            showError(error: .HCERT_IS_INVALID)
        }
        
        
    }
    
    func qrScanningDidStop() {
        showError(error: nil)
    }
    


}
