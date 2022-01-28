//
//  Date.swift
//  TodoList
//
//  Created by Danil Lyskin on 17.01.2022.
//

import Foundation

extension Date {
    
    /**
        Полученние строки фомата *dd.MM.yyyy* из даты
     
        - Returns:
            *String* строка из даты
     */
    func showDate() -> String {
        let calendar = Calendar.current
        
        let day = calendar.component(.day, from: self)
        let month = calendar.component(.month, from: self)
        
        return "\(day > 9 ? "\(day)" : "0\(day)").\(month > 9 ? "\(month)" : "0\(month)").\(calendar.component(.year, from: self))"
    }
    
    /**
        Перевод из *String* в *Date* в формате *dd.MM.yyyy*
     
        - Returns:
            *Date* дата из строки
     */
    private static func formatteDate(_ isoDate: String) -> Date {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        dateFormatter.dateFormat = "dd.MM.yyyy"
        return dateFormatter.date(from: isoDate)!
    }
    
    /**
        Получение текущей даты в формате *dd.MM.yyyy*
     
        - Returns:
            *Date* настоящая дата
     */
    static func getNowDate() -> Date {
        formatteDate(NSDate.now.showDate())
    }
    
    /**
        Получение даты в формате *dd.MM.yyyy*
     
        - Returns:
            *Date* дата
     */
    func getDateWithFormatter() -> Date {
        Date.formatteDate(self.showDate())
    }
}
