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
import RealmSwift

class HCertStorageDelegate: PublicKeyStorageDelegate {

    static var instance = HCertStorageDelegate()
    
    // ------
    
    var realm: Realm
    
    init() {
        realm = try! Realm()
    }
    
    func getEncodedPublicKeys(for kidStr: String) -> [String] {
        let usedCertificate = realm.objects(RLMCertificate.self).filter("kid == %@ OR kidLocked == %@", kidStr, kidStr).first
        return usedCertificate != nil ? [usedCertificate!.rawData!] : []
    }
}
