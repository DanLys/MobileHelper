//
//  SortedMap.swift
//  TodoList
//
//  Created by Danil Lyskin on 24.01.2022.
//

import Foundation
import SwiftUI

class SortedMap<Key: Comparable, Value> {
    var arr = [(key: Key, value: [Value])]()
    var count: Int = 0
    
    private func lowerBound(key: Key) -> Int {
        guard arr.count > 0 else {
            return 0
        }
        
        var left = 0
        var right = arr.count
        
        while right - left > 1 {
            let mid = (left + right) / 2
            
            if arr[mid].key == key {
                return mid
            }
            
            if arr[mid].key <= key {
                left = mid
            } else {
                right = mid
            }
        }
        
        return left
    }
    
    private func check(index: Int, and key: Key) -> Bool {
        index < count && arr[index].key == key
    }
    
    private func getBy(key: Key) -> [Value]? {
        let index = lowerBound(key: key)
        
        if check(index: index, and: key) {
            return arr[index].value
        }
        
        return nil
    }
    
    private func removeBy(key: Key) {
        let index = lowerBound(key: key)
        
        if check(index: index, and: key) {
            arr.remove(at: index)
            count -= 1
        }
    }
    
    private func addBy(key: Key, and value: [Value]?) {
        guard let value = value else {
            removeBy(key: key)
            return
        }
        
        let index = lowerBound(key: key)
        
        if check(index: index, and: key) {
            arr[index].value = value
        } else {
            arr.insert((key: key, value: value), at: index != 0 ? index + 1 : index)
            count += 1
        }
    }
    
    func getIndexBy(key: Key) -> Int {
        let index = lowerBound(key: key)
        
        if check(index: index, and: key) {
            return index
        }
        
        return -index
    }
    
    subscript(key: Key) -> [Value]? {
        get { getBy(key: key) }
        set(value) { addBy(key: key, and: value) }
    }
    
    subscript(index: Int) -> [Value]? {
        get { arr[index].value }
        set(value) { addBy(key: arr[index].key, and: value) }
    }
}
