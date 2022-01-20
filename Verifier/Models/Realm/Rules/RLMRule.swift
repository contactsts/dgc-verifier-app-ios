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
import RealmSwift


class RLMRule: BaseRealm {
    
    @Persisted var hashCode: String?
    @Persisted var identifier: String?
    @Persisted var version: String?
    @Persisted var countryCode: String?
    
    @Persisted var isNational: Bool = false
    
    @Persisted var type: String?
    @Persisted var schemaVersion: String?
    @Persisted var engine: String?
    @Persisted var engineVersion: String?
    @Persisted var certificateType: String?
    @Persisted var displayName: String?
    @Persisted var validFrom: Date?
    @Persisted var validTo: Date?
    @Persisted var affectedFields = List<String>()
    @Persisted var logic: String?
    
    
    
    convenience init(rulePair: RulePair) {
        self.init()
        
        let afRuleSummary = rulePair.aFRuleSummary
        let afRuleDetailed = rulePair.aFRuleDetailed
        
        self.hashCode = afRuleSummary.hash
        self.identifier = afRuleSummary.identifier
        self.version = afRuleSummary.version
        self.countryCode = afRuleSummary.country
        
//        let a = afRuleDetailed.description.filter { $0.lang == "en" }
        
        self.type = afRuleDetailed.type
        self.schemaVersion = afRuleDetailed.schemaVersion
        self.engine = afRuleDetailed.engine
        self.engineVersion = afRuleDetailed.engineVersion
        self.certificateType = afRuleDetailed.certificateType
        self.displayName = afRuleDetailed.description.filter { $0.lang == "en" }.first?.desc
        self.validFrom = DateUtils.formatStringToDateUTC(date: afRuleDetailed.validFrom)
        self.validTo = DateUtils.formatStringToDateUTC(date: afRuleDetailed.validTo)  
//        self.affectedFields = afRuleDetailed.affectedFields
        afRuleDetailed.affectedFields.forEach { currentField in
            self.affectedFields.append(currentField)
        }
        
        self.isNational = rulePair.isNational
        
        self.logic = afRuleDetailed.logic?.description
    }
    
}
