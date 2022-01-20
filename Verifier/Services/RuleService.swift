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
//import Alamofire
import Networking
import RealmSwift
import Eureka
import CertLogic

class RuleService {
    
    
    
    public func syncRulesList(useForce: Bool = false, completion: @escaping () -> Void ) {
        
        if !useForce {
            let lastSync = RuleService.getSyncedAt()
            let timePassed = Date().timeIntervalSince(lastSync)
            if timePassed < CertificateService.SECONDS_BETWEEN_SYNC {
                completion()
                return
            }
        }
        
        var newRules : [RulePair] = []
        var group = DispatchGroup()
        
        group.enter()
        syncRulesListExternal { rules in
            group.leave()
            newRules.append(contentsOf: rules)
        }
        
        group.enter()
        syncRulesListNational { rules in
            group.leave()
            newRules.append(contentsOf: rules)
        }
        
        group.notify(queue: .main) {
            self.saveRulesToRealm(ruleSetsList: newRules)
            
            if newRules.count > 0 {
                RuleService.setSyncedAt()
            }
            completion()
        }
        
        
    }
    
    private func syncRulesListExternal(completion: @escaping ([RulePair]) -> Void ) {
        RuleRepository().getExternalRulesSummary() { summaryRulesList in
            guard let summaryRulesList = summaryRulesList else {
                completion([])
                return
            }
            
            var group = DispatchGroup()
            var newRules : [RulePair] = []
            
            for (index,currentRuleSummary) in summaryRulesList.enumerated() {
                guard let countryCode = currentRuleSummary.country else { continue }
                guard let hashCode = currentRuleSummary.hash else { continue }
                
                group.enter()
                RuleRepository().getExternalRuleDetailed(countryCode: countryCode, hash: hashCode) { detailedRule in
                    group.leave()
                    guard let detailedRule = detailedRule  else { return }
                    newRules.append(RulePair(aFRuleSummary: currentRuleSummary, aFRuleDetailed: detailedRule))
                }
            }
            
            group.notify(queue: .main) {
                completion(newRules)
            }
        }
    }
    
    
    
    private func syncRulesListNational(completion: @escaping ([RulePair]) -> Void ) {
        RuleRepository().getNationalRulesSummary() { summaryRulesList in
            guard let summaryRulesList = summaryRulesList else {
                completion([])
                return
            }
            
            var group = DispatchGroup()
            var newRules : [RulePair] = []
            
            for (index,currentRuleSummary) in summaryRulesList.enumerated() {
                guard let countryCode = currentRuleSummary.country else { continue }
                guard let hashCode = currentRuleSummary.hash else { continue }
                
                group.enter()
                RuleRepository().getNationalRuleDetailed(hash: hashCode) { detailedRule in
                    group.leave()
                    guard let detailedRule = detailedRule  else { return }
                    let rulePair = RulePair(aFRuleSummary: currentRuleSummary, aFRuleDetailed: detailedRule, isNational: true)
                    newRules.append(rulePair)
                }
            }
            
            group.notify(queue: .main) {
                completion(newRules)
            }
        }
    }
    
    
    
    private func saveRulesToRealm(ruleSetsList: [RulePair]) {
        let realm = try! Realm()
        
        try! realm.write {
            realm.delete(realm.objects(RLMRule.self))
            
            
            let rlmRulesList = ruleSetsList.map { currentRulePair in
                return RLMRule(rulePair: currentRulePair)
            }
            
            realm.add(rlmRulesList)
        }
    }
    
    
    
    
    // ---------------------------------------------------------------
    
    private static var SYNCED_AT_KEY = "rules_synced_at"
    
    public static func setSyncedAt() {
        let currentDate = Date()
        UserDefaults.standard.set(currentDate.timeIntervalSince1970, forKey: SYNCED_AT_KEY)
    }
    
    public static func getSyncedAt() -> Date {
        let defaults = UserDefaults.standard
        let date = Date(timeIntervalSince1970: UserDefaults.standard.double(forKey: SYNCED_AT_KEY))
        return date
    }
    
    
    
    

    
}

struct RulePair {
    var aFRuleSummary : AFRuleSummary
    var aFRuleDetailed : AFRuleDetailed
    var isNational : Bool = false
}
