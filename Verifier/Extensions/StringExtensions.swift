//
//  StringExtensions.swift
//  ScorePal
//
//  Created by Mihai Cioraneanu on 30/03/2020.
//  Copyright © 2020 Cioraneanu Mihai. All rights reserved.
//

import Foundation


extension String {
    

    var localized: String {
        if let _ = UserDefaults.standard.string(forKey: "i18n_language") {} else {
            // we set a default, just in case
            UserDefaults.standard.set("fr", forKey: "i18n_language")
            UserDefaults.standard.synchronize()
        }
        
        let lang = UserDefaults.standard.string(forKey: "i18n_language")
        
        let path = Bundle.main.path(forResource: lang, ofType: "lproj")
        let bundle = Bundle(path: path!)
        
        return NSLocalizedString(self, tableName: nil, bundle: bundle!, value: "", comment: "")
    }
    
    
    var length: Int {
        return count
    }
    
    subscript (i: Int) -> String {
        return self[i ..< i + 1]
    }
    
    func substring(fromIndex: Int) -> String {
        return self[min(fromIndex, length) ..< length]
    }
    
    func substring(toIndex: Int) -> String {
        return self[0 ..< max(0, toIndex)]
    }
    
    subscript (r: Range<Int>) -> String {
        let range = Range(uncheckedBounds: (lower: max(0, min(length, r.lowerBound)),
                                            upper: min(length, max(0, r.upperBound))))
        let start = index(startIndex, offsetBy: range.lowerBound)
        let end = index(start, offsetBy: range.upperBound - range.lowerBound)
        return String(self[start ..< end])
    }
    
    
    
    
    func toBool(defaultValue: Bool) -> Bool {
        switch self.lowercased() {
        case "true", "t", "yes", "y", "1":
            return true
        case "false", "f", "no", "n", "0":
            return false
        default:
            return defaultValue
        }
    }
    
    
    
    //    mutating func fromBool(value: Bool)  {
    //        self = value ? "true" : "false"
    //    }
    
    static func fromBool(value: Bool) -> String {
        return value ? "true" : "false"
    }
    
    //    var bool: Bool? {
    //        switch self.lowercased() {
    //        case "true", "t", "yes", "y", "1":
    //            return true
    //        case "false", "f", "no", "n", "0":
    //            return false
    //        default:
    //            return nil
    //        }
    //    }
    
    
    static func toInt(string: String?) -> Int {
        guard let string = string else {
            return 0
        }
        
        return Int(string) ?? 0
    }
    
    func toInt() -> Int {
//         guard let self = self else {
//             return 0
//         }
         
         return Int(self) ?? 0
     }
    

    
}


extension Optional where Wrapped == String {
//extension String? {
    func toInt() -> Int {
         guard let self = self else {
             return 0
         }
         
         return Int(self) ?? 0
     }
}
