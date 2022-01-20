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


class RLMCertificate: BaseRealm {
    
    @Persisted var kid: String?
    @Persisted var countryCode: String?
    @Persisted var rawData: String?
    @Persisted var locked: Bool? = false
    @Persisted var kidLocked: String?
    
    
    convenience init(afCertificate: AFCertificate) {
        self.init()
        self.kid = afCertificate.kid
        self.countryCode = afCertificate.country
        self.rawData = afCertificate.rawData
        self.locked = afCertificate.locked
        self.kidLocked = afCertificate.kidLocked
    }

}
