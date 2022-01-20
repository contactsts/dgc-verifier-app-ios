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
import CertLogic
import RealmSwift
import SwiftyJSON



public struct RuleValidationsResult {
    public var validity : HCertValidity = .valid
    public var rulesStatus : [String : Result] = [:]
}

public struct HCertPlus {
    
    var hCert : HCert?
    var isExternal = false
    var country: FLCountry?
    
    
    var ruleValidationResult = RuleValidationsResult()
    
    
    func validateCertLogicRules() -> (RuleValidationsResult) {
        var result = RuleValidationsResult()
        result.validity = .valid
        
        var validity: HCertValidity = .valid
        guard let hCert = hCert else {
            return result
        }
        let certType = getCertificationType(type: hCert.type)
        
        
        
        let countryCode = isExternal ? country?.code : CountryManager.sharedInstance.defaultCountryCode.uppercased()
        guard let countryCode = countryCode else {
            return result
        }
        
        let rules = HCertPlus.getRulesFor(hCertPlus: self)
        CertLogicEngineManager.sharedInstance.setRules(ruleList: rules)
        
        
        let valueSets = self.getValueSetsForExternalParameters()
        let filterParameter = FilterParameter(validationClock: Date(),
                                              countryCode: countryCode,
                                              certificationType: certType,
                                              region: countryCode
        )
        
        
        let externalParameters = ExternalParameter(validationClock: Date(),
                                                   valueSets: valueSets,
                                                   exp: hCert.exp,
                                                   iat: hCert.iat,
                                                   issuerCountryCode: hCert.issCode,
                                                   kid: hCert.kidStr)
        let certLogicResult = CertLogicEngineManager.sharedInstance.validate(filter: filterParameter, external: externalParameters,
                                                                             payload: hCert.body.description)
        let failsAndOpen = certLogicResult.filter { validationResult in
            return validationResult.result != .passed
        }
        if failsAndOpen.count > 0 {
            result.validity = .ruleInvalid
        }
        
        
        //        var rulesDictionary : [String : Result] = [:]
        for currentRuleResult in certLogicResult {
            guard let ruleId = currentRuleResult.rule?.identifier else { continue }
            let ruleResult = currentRuleResult.result
            result.rulesStatus[ruleId] = ruleResult
        }
        
        return result
        
    }
    
    
    
    // ======================================= Convert to CertLogic intern classes ==============================
    
    
    //    func getCertificateType(hcert: HCert) -> CertificateType {
    //        return .recovery
    //    }
    


    
    func getCertificationType(type: SwiftDGC.HCertType) -> CertificateType {
        var certType: CertificateType = .general
        switch type {
        case .recovery:
            certType = .recovery
        case .test:
            certType = .test
        case .vaccine:
            certType = .vaccination
        case .unknown:
            certType = .general
        }
        return certType
    }
    
    public func getValueSetsForExternalParameters() -> Dictionary<String, [String]> {
        var returnValue = Dictionary<String, [String]>()
        
        let realm = try! Realm()
        let valueSets = realm.objects(RLMValueSet.self)
        
        valueSets.forEach { valueSet in
            let keys : [String] = valueSet.valueSetValues.map{ $0.code! }
            returnValue[valueSet.valueSetId!] = keys
        }
        return returnValue
    }
    
    
    
    public static func getRulesFor(hCertPlus: HCertPlus) -> [Rule] {
        let realm = try! Realm()
        
        let countryCode = hCertPlus.isExternal ? hCertPlus.country?.code : CountryManager.sharedInstance.defaultCountryCode.uppercased()
        guard let countryCode = countryCode else { return [] }
        
        var query : Results<RLMRule>
        // Filter by country
        if hCertPlus.isExternal {
            query = realm.objects(RLMRule.self).filter("isNational = false").filter("countryCode = %@", countryCode.uppercased())
        } else {
            query = realm.objects(RLMRule.self).filter("isNational = true")
        }
        
        // Filter by certificate type
        let certificateType = getRuleCertificateType(hCert: hCertPlus.hCert)
        query = query.filter("certificateType == %@ OR certificateType == 'General'", certificateType)
        
        
        // FIlter by expired or updated
        var queryArray = filterRulesByEnabled(list: query)
        return self.convertRLMRulesToCertlogicRules(rulesList: queryArray)
    }
    
    
    
    static func getRuleCertificateType (hCert: HCert?) -> String? {
        var certificateType : String? = nil
        
        switch hCert?.type {
        case .test:
            certificateType = "Test"
        case .vaccine:
            certificateType = "Vaccination"
        case .recovery:
            certificateType = "Recovery"
        default:
            certificateType = nil
        }
        return certificateType
    }
    
    
    private static func filterRulesByEnabled(list : Results<RLMRule>) -> [RLMRule] {
        let currentDate = Date()
        var listArray =  list.filter("validFrom <= %@", currentDate)
            .filter("validTo >= %@", currentDate)
            .toArray()
        
        // Because same rule can have multiple versions only pick the last one
        let rulesDictionary = Dictionary(grouping: listArray, by: { currentRule in
            return currentRule.identifier
        })

        var result : [RLMRule] = []
        for (ruleIdentifier, rulesList) in rulesDictionary {
            var sortedRuleList = rulesList
            sortedRuleList.sort {
                GeneralUtils.isFirstVersionBigger(version1: $0.version, version2: $1.version!)
            }
            guard let activeVersion = sortedRuleList.first else { continue }
            result.append(activeVersion)
        }

        return result
    }
    
        
    private static func convertRLMRulesToCertlogicRules(rulesList: [RLMRule]) -> [Rule] {
        return rulesList.map { realmRule in
            guard let jsonString = realmRule.logic else { return nil }
            guard let jsonData = jsonString.data(using: .utf8) else { return nil }
            
            do {
                let json = try JSON(data: jsonData)
                return Rule(identifier: realmRule.identifier!,
                            type: realmRule.type!,
                            version: realmRule.version!,
                            schemaVersion: realmRule.schemaVersion!,
                            engine: realmRule.engine!,
                            engineVersion: realmRule.engineVersion!,
                            certificateType: realmRule.certificateType!,
                            description: [Description(lang: "en", desc: realmRule.displayName ?? "")],
                            validFrom: DateUtils.formatDateToStringUTC(date: realmRule.validFrom!),
                            validTo: DateUtils.formatDateToStringUTC(date: realmRule.validTo!),
                            affectedString: realmRule.affectedFields.toArray(),
                            logic: json,
                            countryCode: realmRule.countryCode!,
                            region: realmRule.countryCode)
            } catch {
//                print("Unexpected error: \(error).")
                return nil
            }
        }.flatMap { $0 }
    }
    
    
}
