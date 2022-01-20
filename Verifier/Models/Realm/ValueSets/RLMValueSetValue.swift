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


class RLMValueSetValue: BaseRealm {
    
    @Persisted var display: String?
    @Persisted var code: String?
    @Persisted var lang: String?
    @Persisted var active: Bool?
    @Persisted var system: String?
    @Persisted var version: String?
    
    @Persisted(originProperty: "valueSetValues") var valueSet: LinkingObjects<RLMValueSet>

    
    
    convenience required init(afValueSetValue: AFValueSetValue, code: String) {
        self.init()
        
        self.code = code
        self.display = afValueSetValue.display
        self.lang = afValueSetValue.lang
        self.active = afValueSetValue.active
        self.system = afValueSetValue.system
        self.version = afValueSetValue.version
    }
    
    
    static func getDisplayNameByCode(valueSetName: ValueSetName, valueSetValueCode: String?) -> String {
        
        guard let valueSetValueCode = valueSetValueCode else {
            return " - "
        }

        let realm = try! Realm()
        
        let valueSetValue = realm.objects(RLMValueSetValue.self)
            .filter("ANY valueSet.valueSetId == %@", valueSetName.rawValue)
            .filter("code == %@", valueSetValueCode)
            .first
        guard let valueSetValue = valueSetValue else { return valueSetValueCode}
        
        return valueSetValue.display ?? valueSetValueCode

    }
    
    //    override required init() {
    //        fatalError("init() has not been implemented")
    //    }
    
}
