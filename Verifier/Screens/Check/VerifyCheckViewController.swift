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

import UIKit
import Foundation
import SnapKit
import SwiftDGC
import RealmSwift
import RxSwift
import RxCocoa

class VerifyCheckViewController: ViewController {
    // MARK: - API

    public var okPressedTouchUpCallback: (() -> Void)?

    // MARK: - Subviews

    private let checkContentViewController = VerifyCheckContentViewController()
    private var contentHeight: CGFloat = 0.0

    private let imageView = UIImageView()
    private let backgroundView = UIView()
    
    private let realm = try! Realm()

    // MARK: - Start Check

    public var holder: HCertPlus? {
        didSet {
            startCheck()
            checkContentViewController.holder = holder
        }
    }

    // MARK: - Internal

    private var verifier: Verifier?

    private var state: VerificationState = .loading {
        didSet {
            updateBackground(true)
            self.checkContentViewController.state = state
        }
    }
    
    
    let disposeBag = DisposeBag()

    // MARK: - View

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .clear

        setup()
        setupInteraction()
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        contentHeight = checkContentViewController.view.frame.size.height
    }

    // MARK: - Start check

    private func startCheck() {
        guard var holder = self.holder else { return }
        guard var hcert = holder.hCert else { return }
        
        let certificatesCount = realm.objects(RLMCertificate.self).count
        if certificatesCount == 0  {
            hcert.validityFailures.append(UBLocalized.error_no_certificates_please_resync)
        }
        
        

        checkContentViewController.view.isHidden = false
        checkContentViewController.view.transform = CGAffineTransform(translationX: 0.0, y: contentHeight)

        UIView.animate(withDuration: 0.15) {
            self.backgroundView.alpha = 1.0
        }

        UIView.animate(withDuration: 0.25, delay: 0.0, options: [.allowUserInteraction, .curveEaseInOut, .beginFromCurrentState]) {
            self.checkContentViewController.view.transform = .identity
        } completion: { _ in }
        
        
        
//        var certificate = HCert(from: holder.value.qr ?? "")
//        guard let certificate = certificate else { return }
        
        
        var errorsList : [String] = []
        
        // Add certificate related errors
        errorsList.append(contentsOf: hcert.validityFailures)
        
        // Add rules related errors
        var failedRules : [String] = []
        for (ruleId, ruleResult) in holder.ruleValidationResult.rulesStatus {
            if ruleResult == .fail {
                failedRules.append(ruleId)
            }
        }
        if failedRules.count > 0 {
            let failedRulesCount = failedRules.count
            let allRulesCount = holder.ruleValidationResult.rulesStatus.count
//            let newError = "\(UBLocalized.verifier_verify_error_info_for_certificate_with_invalid_rules) (\(allRulesCount - failedRulesCount)/\(allRulesCount))"
            let newError = UBLocalized.verifier_verify_error_info_for_certificate_with_invalid_rules
            errorsList.append(newError)
        }
    
        
        state = errorsList.count == 0 ? .success("Success") : .failure(errors: errorsList)

    }

    private func okPressed() {
        checkContentViewController.view.isHidden = false
        checkContentViewController.view.transform = .identity

        UIView.animate(withDuration: 0.15) {
            self.backgroundView.alpha = 0.0
        }

        UIView.animate(withDuration: 0.25, delay: 0.0, options: [.allowUserInteraction, .curveEaseInOut, .beginFromCurrentState]) {
            self.checkContentViewController.view.transform = CGAffineTransform(translationX: 0.0, y: self.contentHeight)
        } completion: { _ in }
    }

    // MARK: - Setup

    private func setup() {
        view.addSubview(backgroundView)
        backgroundView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }

        backgroundView.addSubview(imageView)

        imageView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(self.view.snp.topMargin).offset(Padding.medium)
        }

        addSubviewController(checkContentViewController) { make in
            make.top.equalTo(self.imageView.snp.bottom).offset(Padding.medium - 2.0)
            make.left.right.equalToSuperview()
            make.bottom.equalToSuperview()
        }

        checkContentViewController.view.isHidden = true
        backgroundView.alpha = 0.0

        updateBackground(false)
    }

    private func setupInteraction() {
        checkContentViewController.okButtonTouchUpCallback = { [weak self] in
            guard let strongSelf = self else { return }
            strongSelf.okPressed()
            strongSelf.okPressedTouchUpCallback?()
        }
        
        
        self.backgroundView.rx.tapGesture().when(.recognized).subscribe(onNext: { [weak self] _ in
            guard let strongSelf = self else { return }
            strongSelf.okPressed()
            strongSelf.okPressedTouchUpCallback?()
        }).disposed(by: disposeBag)
        
        
        self.backgroundView.rx
            .swipeGesture([.down])
            .when(.recognized)
            .subscribe(onNext: { [weak self] gesture in
                guard let strongSelf = self else { return }
                strongSelf.okPressed()
                strongSelf.okPressedTouchUpCallback?()
            })
            .disposed(by: disposeBag)

        checkContentViewController.dismissCallback = { [weak self] progress in
            guard let strongSelf = self else { return }

            strongSelf.backgroundView.alpha = 1.0 - progress

            if progress == 1.0 {
                strongSelf.okPressedTouchUpCallback?()
            }
        }

        checkContentViewController.retryButtonCallback = { [weak self] in
            guard let strongSelf = self else { return }
            strongSelf.verifier?.restart()
        }
    }

    public func dismissResult() {
        checkContentViewController.okButtonTouchUpCallback?()
    }

    // MARK: - Update

    private func updateBackground(_ animated: Bool) {
        let actions = {
            switch self.state {
            case .loading:
                self.imageView.image = UIImage(named: "ic-header-load")
                self.imageView.rotate(time: 1.0)
                self.backgroundView.backgroundColor = .cc_grey
            case .success:
                self.imageView.layer.removeAllAnimations()
                self.imageView.image = UIImage(named: "ic-header-valid")
                self.backgroundView.backgroundColor = .cc_green
            case .failure:
                self.imageView.layer.removeAllAnimations()
                self.imageView.image = UIImage(named: "ic-header-invalid")
                self.backgroundView.backgroundColor = .cc_red
            }
        }

        if animated {
            UIView.animate(withDuration: 0.2) { actions() }
        } else {
            actions()
        }
    }
}
