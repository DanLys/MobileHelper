//
//  Double.swift
//  TodoList
//
//  Created by Danil Lyskin on 06.02.2022.
//

import Foundation

extension Double {
    mutating func convertByteToGb() -> Double {
        self = self / 1024 / 1024 / 1024
        
        var str = String(self)
        
        if str.contains(".") {
            for i in 0..<str.count {
                if str[i] == "." {
                    str.removeSubrange(str.index(str.startIndex, offsetBy: i + 3)..<str.endIndex)
                    break
                }
            }
        }
        
        return Double(str)!
    }
}
