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


import Foundation
import SwiftDGC
import RxSwift
import RxCocoa

class VerifyCheckContentViewController: ViewController {
    
    
    
    let disposeBag = DisposeBag()
    
    private let segmentedView = UISegmentedControl(items: [
        UBLocalized.certificate_result_segment_data,
        UBLocalized.certificate_result_segment_rules,
    ])
    
    
    private let okButton = Button(title: UBLocalized.ok_button, style: .normal(.cc_blue))
    
    
    
    
    private let certificateData = CertificateData()
    private let certificateRules = CertificateRules()
    //
    
    
    public var okButtonTouchUpCallback: (() -> Void)?
    public var dismissCallback: ((CGFloat) -> Void)?
    
    private var originalPosition: CGPoint = .zero
    private var currentPositionTouched: CGPoint = .zero
    
    public var state: VerificationState? {
        didSet { certificateData.state = state }
    }
    
    public var holder: HCertPlus? {
        didSet {
            segmentedView.selectedSegmentIndex = 0
            let rulesTitle = (holder?.isExternal ?? false) ? UBLocalized.certificate_result_segment_rules : UBLocalized.certificate_result_segment_rules_national
            segmentedView.setTitle(rulesTitle, forSegmentAt: 1)
            certificateData.holder = holder
            certificateRules.holder = holder
            segmentedViewChanged()
        }
    }
    
    
    
    
    public var retryButtonCallback: (() -> Void)?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
        setupButton()
        setupStateViews()
        
        let panGestureRecognizer = UIPanGestureRecognizer(target: self, action: #selector(panGestureAction(_:)))
        view.addGestureRecognizer(panGestureRecognizer)
    }
    
    @objc func panGestureAction(_ panGesture: UIPanGestureRecognizer) {
        let translation = panGesture.translation(in: view)
        
        if panGesture.state == .began {
            originalPosition = view.frame.origin
            currentPositionTouched = panGesture.location(in: view)
        } else if panGesture.state == .changed {
            view.transform = CGAffineTransform(translationX: 0.0, y: max(0.0, translation.y))
            dismissCallback?(max(0.0, min(1.0, translation.y / view.frame.size.height)))
        } else if panGesture.state == .ended {
            let velocity = panGesture.velocity(in: view).y
            
            if velocity >= 1200 || translation.y > 0.5 * view.frame.size.height {
                let points = max(0.0, view.frame.size.height - translation.y)
                let duration = points / velocity
                
                UIView.animate(withDuration: TimeInterval(min(0.2, duration)), delay: 0.0, options: [.beginFromCurrentState, .allowUserInteraction, .curveEaseInOut]) {
                    self.view.transform = CGAffineTransform(translationX: 0.0, y: self.view.frame.size.height)
                } completion: { _ in
                    self.dismissCallback?(1.0)
                }
            } else {
                let points = max(0.0, translation.y)
                let duration = points / velocity
                
                UIView.animate(withDuration: TimeInterval(min(0.2, duration)), delay: 0.0, options: [.beginFromCurrentState, .allowUserInteraction, .curveEaseInOut]) {
                    self.view.transform = .identity
                    self.dismissCallback?(0.0)
                } completion: { _ in }
            }
        }
    }
    
    private func setupView() {
        view.backgroundColor = .white
        
        let maskLayer = CAShapeLayer()
        maskLayer.path = UIBezierPath(roundedRect: view.bounds, byRoundingCorners: [.topLeft, .topRight], cornerRadii: CGSize(width: 20, height: 20)).cgPath
        view.layer.mask = maskLayer
    }
    
    private func setupStateViews() {
        // title View
        let label = Label(.uppercaseBold, textAlignment: .center)
        label.text = UBLocalized.covid_certificate_title
        
        //        view.addSubview(label)
        //
        //        let lr = Padding.large - Padding.small
        //        label.snp.makeConstraints { make in
        //            make.top.equalToSuperview().inset(Padding.medium)
        //            make.left.right.equalToSuperview().inset(lr)
        //        }
        
        view.addSubview(segmentedView)
        segmentedView.selectedSegmentIndex = 0
        segmentedView.snp.makeConstraints { make in
            //            make.top.equalTo(label.snp.bottom).offset(Padding.medium - 2.0)
            make.top.equalToSuperview().inset(Padding.medium)
            make.leading.equalToSuperview().offset(Padding.medium + Padding.small)
            make.trailing.equalToSuperview().offset(-Padding.medium - Padding.small)
        }
        
        // content view
        
        let p = Padding.medium + Padding.small
        view.addSubview(certificateData)
        certificateData.snp.makeConstraints { make in
            make.top.equalTo(segmentedView.snp.bottom).offset(10)
            make.left.right.equalToSuperview()
            make.bottom.equalTo(self.okButton.snp.top).offset(-p)
        }
        
        view.addSubview(certificateRules)
        certificateRules.snp.makeConstraints { make in
            make.edges.equalTo(certificateData)
        }
        
        certificateRules.isHidden = true
    }
    
    
    private func setupButton() {
        
        certificateData.rx.swipeGesture(.left).when(.recognized)
            .subscribe(onNext: { [weak self] _ in
                self?.segmentedView.selectedSegmentIndex = 1
                self?.segmentedViewChanged()
            }).disposed(by: disposeBag)
        
        certificateRules.rx.swipeGesture(.right).when(.recognized)
            .subscribe(onNext: { [weak self] _ in
                self?.segmentedView.selectedSegmentIndex = 0
                self?.segmentedViewChanged()
            }).disposed(by: disposeBag)
        
        
        segmentedView.rx.selectedSegmentIndex.subscribe(onNext : { [weak self] currentIndex in
            self?.segmentedViewChanged()
        }).disposed(by: disposeBag)
                                                        
        
        okButton.touchUpCallback = { [weak self] in
            guard let strongSelf = self else { return }
            strongSelf.okButtonTouchUpCallback?()
        }
        
        view.addSubview(okButton)
        
        okButton.snp.makeConstraints { make in
            make.left.greaterThanOrEqualToSuperview().inset(Padding.medium)
            make.right.lessThanOrEqualToSuperview().inset(Padding.medium)
            make.centerX.equalToSuperview()
            make.width.greaterThanOrEqualToSuperview().multipliedBy(0.5).priority(.medium)
            
            let bottomPadding = UIApplication.shared.keyWindow?.safeAreaInsets.bottom ?? 0.0
            if bottomPadding > 0 {
                make.bottom.equalTo(self.view.snp.bottomMargin).inset(Padding.small)
            } else {
                make.bottom.equalToSuperview().inset(Padding.small)
            }
        }
    }
    
    
    private func segmentedViewChanged() {
        let currentIndex = segmentedView.selectedSegmentIndex
        if currentIndex == 0 {
            self.certificateData.isHidden = false
            self.certificateRules.isHidden = true
        }
        
        if currentIndex == 1 {
            self.certificateData.isHidden = true
            self.certificateRules.isHidden = false
        }
    }
    
    
}


