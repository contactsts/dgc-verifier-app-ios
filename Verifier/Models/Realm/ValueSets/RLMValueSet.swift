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


class RLMValueSet: BaseRealm {
    
    @Persisted var valueSetId: String?
    @Persisted var valueSetDate: String?
    @Persisted var valueSetValues: List<RLMValueSetValue>
//    @Persisted var valueSetValues = List<RLMValueSetValue>()
    
    
    convenience required init(afValueSet: AFValueSet, rlmValueSet: [RLMValueSetValue] ) {
        self.init()
        
        self.valueSetId = afValueSet.valueSetId
        self.valueSetDate = afValueSet.valueSetDate

        self.valueSetValues.append(objectsIn: rlmValueSet)
    }
    
    //    override required init() {
    //        fatalError("init() has not been implemented")
    //    }
    
}


enum ValueSetName : String {
    case country = "country-2-codes"
    case laboratoryResult = "covid-19-lab-result"
    case laboratoryTestManufacturer = "covid-19-lab-test-manufacturer-and-name"
    case laboratoryTestType = "covid-19-lab-test-type"
    case diseaseAgentTargeted = "disease-agent-targeted"
    case sctVaccine = "sct-vaccines-covid-19"
    case vaccineAuthHolder = "vaccines-covid-19-auth-holders"
    case vaccineNames = "vaccines-covid-19-names"
}
