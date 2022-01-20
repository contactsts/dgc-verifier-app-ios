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

/// The backend environment under which the application runs.
enum Environment : String {
    case dev
    case abnahme
    case prod

    /// The current environment, as configured in build settings.
    static var current: Environment {
//        return .prod
        #if DEBUG
            return .dev
        #elseif RELEASE_DEV
            return .dev
        #elseif RELEASE_PROD
            return .prod
        #else
            fatalError("Missing build setting for environment")
        #endif
    }

    var appStoreURL: URL {
        return URL(string: "https://www.sts.ro")!
    }

    var privacyURL: URL {
        return URL(string: "https://www.sts.ro")!
    }

    
}

