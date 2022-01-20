//
//  DateUtils.swift
//  ScorePal
//
//  Created by Cioraneanu Mihai on 8/31/19.
//  Copyright © 2019 Cioraneanu Mihai. All rights reserved.
//

import Foundation



class GeneralUtils {
    
    static func isFirstVersionBigger (version1: String?, version2: String?) -> Bool {
        
        guard let version1 = version1 else { return false }
        guard let version2 = version2 else { return false }

//        let version1 = "1.3"
//        let version2 = "1.2.9"
        let versionCompare = version1.compare(version2, options: .numeric)
        if versionCompare == .orderedSame {
            return false
        } else if versionCompare == .orderedAscending {
            return false
        } else if versionCompare == .orderedDescending {
            return true
        }
        return false
    }
    
}
