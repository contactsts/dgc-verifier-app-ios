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
import SwiftyJSON



struct AFRuleDetailed: Decodable {
    
    var identifier: String?
    var type: String?
    var country: String?
    var region: String?
    var version: String?
    var schemaVersion: String?
    var engine: String?
    var engineVersion: String?
    var certificateType: String?
    var description: [AFRuleDetailedDescription]
    var validFrom: String?
    var validTo: String?
    var affectedFields: [String]
    var logic: JSON?
    
    private enum CodingKeys: String, CodingKey {
        case identifier = "Identifier"
        case type = "Type"
        case country = "Country"
        case region = "Region"
        case version = "Version"
        case schemaVersion = "SchemaVersion"
        case engine = "Engine"
        case engineVersion = "EngineVersion"
        case certificateType = "CertificateType"
        case description = "Description"
        case validFrom = "ValidFrom"
        case validTo = "ValidTo"
        case affectedFields = "AffectedFields"
        case logic = "Logic"
    }
    
    
}


struct AFRuleDetailedDescription : Decodable {
    var lang : String?
    var desc : String?
}
