//
//  Date.swift
//  TodoList
//
//  Created by Danil Lyskin on 17.01.2022.
//

import Foundation

extension Date {
    
    func showDate() -> String {
        let calendar = Calendar.current
        
        let day = calendar.component(.day, from: self)
        let month = calendar.component(.month, from: self)
        
        return "\(day > 9 ? "\(day)" : "0\(day)").\(month > 9 ? "\(month)" : "0\(month)").\(calendar.component(.year, from: self))"
    }
    
    private static func formatteDate(_ isoDate: String) -> Date {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        dateFormatter.dateFormat = "dd.MM.yyyy"
        return dateFormatter.date(from: isoDate)!
    }
    
    static func getNowDate() -> Date {
        formatteDate(NSDate.now.showDate())
    }
    
    func getDateWithFormatter() -> Date {
        Date.formatteDate(self.showDate())
    }
}
