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

class CertificateService {
    
    public static let SECONDS_BETWEEN_SYNC : Double = 3600
    
    
    
    public func syncCertificatesList(useForce: Bool = false, completion: @escaping () -> Void ) {
        
        // Check if we really need to perform this
        if !useForce {
            let lastSync = CertificateService.getSyncedAt()
            let timePassed = Date().timeIntervalSince(lastSync)
            if timePassed < CertificateService.SECONDS_BETWEEN_SYNC {
                completion()
                return
            }
        }
        
        let certificatesList = CertificateRepository().getCertificatesList() { afCertificatesList in
            guard let afCertificatesList = afCertificatesList else {
                completion()
                return
            }
            self.saveCertificatesToRealm(afCertificatesList: afCertificatesList)
            CertificateService.setSyncedAt()
            completion()
        }
    }
    
    
    
    private func saveCertificatesToRealm(afCertificatesList: [AFCertificate]) {
        let realm = try! Realm()
        
        try! realm.write {
            realm.delete(realm.objects(RLMCertificate.self))
            
            
            let realmCertificatesList = afCertificatesList.map { afCertificate in
                return RLMCertificate(afCertificate: afCertificate)
            }
            
            realm.add(realmCertificatesList)
        }
    }

    
    private static var SYNCED_AT_KEY = "certificates_synced_at"
    
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
