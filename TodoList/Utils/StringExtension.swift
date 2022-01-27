//
//  StringExtansion.swift
//  TodoList
//
//  Created by Danil Lyskin on 22.01.2022.
//

import Foundation

extension String {
    
    /**
        Удаление пробельных символов из конца строки
     
        - Returns:
            - *String* строка без пробельных символов в конце строки
     */
    func deleteAllWhitespaceInEnd() -> String {
        guard self.count > 0 else {
            return ""
        }
        
        var str = self
        var index = str.index(before: str.endIndex)
        
        while str[index].isWhitespace {
            str.removeLast()
            
            if str.count > 0 {
                index = str.index(before: str.endIndex)
            } else {
                break
            }
        }
        
        return str
    }
    
    var localized: String {
        NSLocalizedString(self, comment: "")
    }
}
