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


class LocaleManager {
    
    static var instance = LocaleManager()
    
    
    public var currentLange: String
    public var translationBundle: Bundle?
    
    init() {
        currentLange = UserDefaults.standard.string(forKey: "lang") ?? "ro"
        loadBundle()
    }
    
    
    
    public func setLanguage(_ language: String) {
        currentLange = language
        
        UserDefaults.standard.set(language, forKey: "lang")
        
        loadBundle()
    }
    
    private func loadBundle() {
        let path = Bundle.main.path(forResource: currentLange, ofType: "lproj")
        translationBundle = Bundle(path: path!)
    }
    
    
    // --------------
    
    
    public static func translate(_ string: String, with comment: String? = nil, or fallback: String? = nil) -> String {
        let text = NSLocalizedString(string, bundle: instance.translationBundle ?? Bundle.main, comment: comment ?? "No comment provided.")
        return text
      
      if text != string {
        return text
      }
      return fallback ?? string
    }
    
}
