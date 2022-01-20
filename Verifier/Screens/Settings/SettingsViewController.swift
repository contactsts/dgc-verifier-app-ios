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
import UIKit
import Eureka
import RxSwift
import RxCocoa
import RealmSwift
import SwiftUI
import SwiftDGC
import RealmSwift

class SettingsViewController: FormViewController {
    
    
   var settingsSection = Section("Settings")
    
    lazy var languageRow: EurekaLabelRow = {
        let view = EurekaLabelRow() { row in
            row.title = "Language"
            row.value = " - "
            row.showArrow = true
        }
        return view
    }()
    
    lazy var syncCertificatesRow: EurekaLabelRow = {
        let view = EurekaLabelRow() { row in
            row.title = "Synchronize with the national backend"
            row.value = "Last updated: xxx"
            row.showArrow = true
        }
        return view
    }()
    
    
    var aboutSection = Section("About")
    
    lazy var privacyPolicyRow: EurekaLabelRow = {
        let view = EurekaLabelRow() { row in
            row.title = "Privacy policy and terms of use"
            row.value = nil
//            row.value = "Last updated: xxx"
        }
        return view
    }()
    
    
    lazy var versionRow: EurekaLabelRow = {
        let view = EurekaLabelRow() { row in
            row.title = "Version"
            row.value = ""
            row.showArrow = false
        }
        return view
    }()
    
    
    let disposeBag = DisposeBag()
    let viewModel = SettingsViewModel()
    
    

    var realm = try! Realm()
    
    // -----------------

    override func viewDidLoad() {
        super.viewDidLoad()
        
//        realm = try! Realm()
        let rlmRulesList = realm.objects(RLMRule.self)
        Observable.collection(from: rlmRulesList)
            .subscribe { [weak self] event in
                self?.updateLastSyncDateLabel()
        }
        .disposed(by: disposeBag)
        
        
        form
        +++ settingsSection
            <<< languageRow
            <<< syncCertificatesRow
        
        +++ aboutSection
            <<< privacyPolicyRow
            <<< versionRow
        
        
        setupInteraction()
        bindFromViewModel()
        updateUI()
        updateTranslations()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        title = UBLocalized.settings_title
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
    }
    
    
    func updateUI() {
        updateVersionLabel()
//        updateLastSyncDateLabel()
    }
    
    func updateTranslations() {
        settingsSection.header?.title = UBLocalized.settings_title
        settingsSection.reload()
        
        languageRow.title = UBLocalized.language_title
        let currentLanguage = LocaleManager.instance.currentLange
        let selectedCountryLanguage = CountryManager.sharedInstance.countriesListForLanguage.first { $0.id == currentLanguage }
        languageRow.value = selectedCountryLanguage?.title
        
        
        syncCertificatesRow.title = UBLocalized.settings_sync_with_server_title
        
        
        aboutSection.header?.title = UBLocalized.settings_about_title
        aboutSection.reload()
        
        privacyPolicyRow.title = UBLocalized.settings_privacy
        versionRow.title = UBLocalized.settings_version
    }
    
    func updateVersionLabel() {
        let appVersionString: String = Bundle.main.object(forInfoDictionaryKey: "CFBundleShortVersionString") as! String
        let environment = (Environment.current == .dev) ? " - dev" : ""
        versionRow.value = "\(appVersionString) \(environment)"
    }
    
    
    
    
    func setupInteraction() {
        
        languageRow.onResult.subscribe(onNext: { [weak self] value in
            if case .select = value {
                self?.onSelectLanguage()
            }
        }).disposed(by: disposeBag)
        
        privacyPolicyRow.onResult.subscribe(onNext: { [weak self] value in
            if case .select = value {
                self?.onGoToPrivacyPolicy()
            }
        }).disposed(by: disposeBag)
        
        syncCertificatesRow.onResult.subscribe(onNext: { [weak self] value in
            if case .select = value {
                self?.onRefreshCertificates()
            }
        }).disposed(by: disposeBag)
    }
    
    
    func bindFromViewModel() {
        self.viewModel.isFetchingCertificate.bind { [weak self] value in
            self?.syncCertificatesRow.isRowDisabled = value
        }
    }
    
    
    
    func presentInNavigationController(from rootViewController: UIViewController) {
        let navCon = NavigationController(rootViewController: self, useNavigationBar: true)

        if UIDevice.current.isSmallScreenPhone {
            navCon.modalPresentationStyle = .fullScreen
        }

        rootViewController.present(navCon, animated: true, completion: nil)
    }
    
}



extension SettingsViewController {
    
    
    func onSelectLanguage() {
        let languagesList = CountryManager.sharedInstance.countriesListForLanguage
        
        let currentLanguage = LocaleManager.instance.currentLange
        let selectedCountryLanguage = CountryManager.sharedInstance.countriesListForLanguage.first { $0.id == currentLanguage }
        let selectedItem = selectedCountryLanguage != nil ? [selectedCountryLanguage!] : []

        let genericPickerVC = GenericPickerVC(list: languagesList, selectedItem: selectedItem, mode: .single)
        genericPickerVC.showDoneButton = false
        genericPickerVC.titleStackViewText = UBLocalized.settings_pick_language
        
        
//        genericPickerVC.presentInNavigationController(from: self)
        
        
        self.navigationController?.pushViewController(genericPickerVC, animated: true)

        genericPickerVC.result.subscribe(onNext: { [weak self] value in
            guard let rawValue = value.first?.id else {
                return
            }
            
            LocaleManager.instance.setLanguage(rawValue)
            self?.updateTranslations()
            NotificationCenter.default.post(name: Notification.Name(LCLLanguageChangeNotification), object: nil)
        }).disposed(by: self.disposeBag)
    }
    
    
    
    func onRefreshCertificates() {
        let isLoading = self.viewModel.isFetchingCertificate.value
        if isLoading {
            return
        }
        
        self.viewModel.isFetchingCertificate.accept(true)
        
        var group = DispatchGroup()
        
        group.enter()
        CountryService().syncCountriesList(useForce: true) { [weak self] in
            group.leave()
        }
        
        group.enter()
        CertificateService().syncCertificatesList(useForce: true) { [weak self] in
            group.leave()
        }
        
        group.enter()
        ValueSetService().syncValueSets(useForce: true) {
            group.leave()
        }

        group.enter()
        RuleService().syncRulesList(useForce: true) {
            group.leave()
        }
        
        group.notify(queue: .main) {
            self.updateLastSyncDateLabel()
            self.viewModel.isFetchingCertificate.accept(false)
        }
    }
    
    func updateLastSyncDateLabel() {
//        let realm = try! Realm()
//        let countryCertificates = realm.objects(RLMCertificate.self).first
//        var certificateUpdateDate = " - "
//        if countryCertificates != nil {
//            certificateUpdateDate = DateUtils.formatDateToString(date: countryCertificates!.cretedAt)
//        }
        
        
        
        let certificateLastSync = CertificateService.getSyncedAt()
        let certificateLastSyncText = (certificateLastSync == Date(timeIntervalSince1970: 0)) ? " - " : DateUtils.formatDateToString(date: certificateLastSync)

        let valueSetLastSync = ValueSetService.getSyncedAt()
        let valueSetLastSyncText = (valueSetLastSync == Date(timeIntervalSince1970: 0)) ? " - " : DateUtils.formatDateToString(date: valueSetLastSync)

        let rulesLastSync = RuleService.getSyncedAt()
        let rulesLastSyncText = (rulesLastSync == Date(timeIntervalSince1970: 0)) ? " - " : DateUtils.formatDateToString(date: rulesLastSync)

        let countriesLastSync = CountryService.getSyncedAt()
        let countriesLastSyncText = (countriesLastSync == Date(timeIntervalSince1970: 0)) ? " - " : DateUtils.formatDateToString(date: countriesLastSync)

        let lines : [String] = [
            "\(UBLocalized.settings_sync_date_certificates): \(certificateLastSyncText)",
            "\(UBLocalized.settings_sync_date_rules): \(rulesLastSyncText)",
            "\(UBLocalized.settings_sync_date_value_sets): \(valueSetLastSyncText)",
            "\(UBLocalized.settings_sync_date_countries): \(countriesLastSyncText)"
        ]
        
        let minDate = min(certificateLastSync, valueSetLastSync, rulesLastSync, countriesLastSync)
        let minDateString = (minDate == Date(timeIntervalSince1970: 0)) ? " - " : DateUtils.formatDateToString(date: minDate)
        syncCertificatesRow.value = minDateString
//        syncCertificatesRow.value = lines.joined(separator: "\n")
        syncCertificatesRow.updateCell()
    }
    

    
    
    func onGoToPrivacyPolicy() {
        let vc = PrivacyViewController()
        vc.presentInNavigationController(from: self)
    }
    
}





