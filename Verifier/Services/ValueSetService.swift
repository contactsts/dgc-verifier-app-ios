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
import Networking
import RealmSwift

class ValueSetService {
    
    
    
    public func syncValueSets(useForce: Bool = false, completion: @escaping  () -> Void ) {
        // Check if we really need to perform this
        if !useForce {
            let lastSync = ValueSetService.getSyncedAt()
            let timePassed = Date().timeIntervalSince(lastSync)
            if timePassed < CertificateService.SECONDS_BETWEEN_SYNC {
                completion()
                return
            }
        }
        
        let valueSetsList = ValueSetRepository().getIndex() { valueSetsIndexes in
            guard let valueSetsIndexes = valueSetsIndexes else {
                completion()
                return
            }
            self.saveValueSetIndexesToRealm(valueSetIndexes: valueSetsIndexes)
            ValueSetService.setSyncedAt()
            completion()
        }
    }
    
    
    
    private func saveValueSetIndexesToRealm (valueSetIndexes: [AFValueSetIndex]) {
        let realm = try! Realm()
        
        try! realm.write {
            // See what hashes have actually changed
            let oldValueSets = realm.objects(RLMValueSetIndex.self)
            
            
            for currentValueSetIndex in valueSetIndexes {
                guard let currentValueSetHash = currentValueSetIndex.hash else { continue }
                guard let currentValueSetId = currentValueSetIndex.id else { continue }

                if oldValueSets.filter("nameId == %@", currentValueSetId).filter("hashCode == %@", currentValueSetHash).count == 1 {
                    continue
                }
                
                
                
                // Delete old index if any for that ID
                realm.delete(realm.objects(RLMValueSetIndex.self).filter("nameId == %@", currentValueSetId))
                
                // Save the index with this ID
                let newValueSetIndex = RLMValueSetIndex(afValueSetIndex: currentValueSetIndex)
                realm.add(newValueSetIndex)
                
                // Get index values
                
                
                ValueSetRepository().getValueSetByHash(hash: currentValueSetHash) { afValueSet in
                    guard let afValueSet = afValueSet else { return }
                    let realm = try! Realm()
                    try! realm.write {
                        realm.delete(realm.objects(RLMValueSet.self).filter("valueSetId == %@", currentValueSetId))
                        
//                        guard let valueSetValueDictionary =  afValueSet.valueSetValues else { return }
                        let valueSetValueDictionary =  afValueSet.valueSetValues
                        
                        
                        var newValueSetValuesList : [RLMValueSetValue] = []
                        for (afValueSetValueCode, afValueSetValue) in valueSetValueDictionary {
                            let newValueSetValue = RLMValueSetValue(afValueSetValue: afValueSetValue, code: afValueSetValueCode)
                            realm.add(newValueSetValue)
                            newValueSetValuesList.append(newValueSetValue)
                        }
                        let newValueSet = RLMValueSet(afValueSet: afValueSet, rlmValueSet: newValueSetValuesList)
                        realm.add(newValueSet)
                    }
                }
            
            }
        }
    }
    
    
    
    // ---------------------------------------------------------------
    
    private static var SYNCED_AT_KEY = "value_sets_synced_at"
    
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
