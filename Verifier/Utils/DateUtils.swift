//
//  DateUtils.swift
//  ScorePal
//
//  Created by Cioraneanu Mihai on 8/31/19.
//  Copyright © 2019 Cioraneanu Mihai. All rights reserved.
//

import Foundation



class DateUtils {
    
    static func getMillis () -> Int {
        let currentDate = Date()
        let since1970 = currentDate.timeIntervalSince1970
        return Int(since1970 * 1000)
    }
    
    static func formatSeconds(seconds: Int) -> String {
        let hours = Int(seconds) / 3600
        let minutes = Int(seconds) / 60 % 60
        let seconds = Int(seconds) % 60
        return String(format:"%02i:%02i:%02i", hours, minutes, seconds)
    }
    
    static func formatDateOnlyToString(date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let formattedDate = dateFormatter.string(from: date)
        return formattedDate
    }
    
    
    static func formatDateToString(date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        let formattedDate = dateFormatter.string(from: date)
        return formattedDate
    }
    
    static func formatStringToDateUTC(date: String?) -> Date? {
        guard let date = date else { return nil }
        let dateFormatter = DateFormatter()
        // 2031-01-01T00:00:00Z
//        dateFormatter.dateFormat = "yyyy-MM-ddTHH:mm:ssZ"
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss'Z'"

        // Convert String to Date
        return dateFormatter.date(from: date)
    }
    
    
    static func formatDateToStringUTC(date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss'Z'"
        let formattedDate = dateFormatter.string(from: date)
        return formattedDate
    }
    
    
    
    
    
}
