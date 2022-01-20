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

class CountryService {
    
    public func syncCountriesList(useForce: Bool = false, completion: @escaping () -> Void ) {
        
        // Check if we really need to perform this
        if !useForce {
            let lastSync = CountryService.getSyncedAt()
            let timePassed = Date().timeIntervalSince(lastSync)
            if timePassed < CertificateService.SECONDS_BETWEEN_SYNC {
                completion()
                return
            }
        }
        
        let countriesList = CountryRepository().getCountriesList() { countryCodesList in
            guard let countryCodesList = countryCodesList else {
                completion()
                return
            }
            self.saveCountriesToRealm(countryCodesList: countryCodesList)
            CountryService.setSyncedAt()
            completion()
        }
    }
    
    
    
    private func saveCountriesToRealm(countryCodesList: [String]) {
        let realm = try! Realm()
        
        try! realm.write {
            realm.delete(realm.objects(RLMCountry.self))
            
            
            let newCountries = countryCodesList.map { countryCode in
                return RLMCountry(countryCode: countryCode)
            }
            
            realm.add(newCountries)
        }
    }

    
    private static var SYNCED_AT_KEY = "countries_synced_at"
    
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
