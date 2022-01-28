//
//  SortedMap.swift
//  TodoList
//
//  Created by Danil Lyskin on 24.01.2022.
//

/**
    Класс реализующий отсортированный словарь, хранящий массив
    
    - Parameters:
        - Key: *Comparable* тип ключа
        - Value: Тип хранимого элемента
 
    - count:  *Int* количество элементов
*/
class SortedMap<Key: Comparable, Value> {
    private var arr = [(key: Key, value: [Value])]()
    var count: Int = 0
    
    /**
        Поиск массива по ключу
     
        - Returns:
            *Int* индекс, где ключ меньше, либо равен искомому
        
        Complexity: O(logN)
     */
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
    
    /**
        Проверка на наличие ключа по индексу
     
        - Parameters:
            - index: *Int* индекс
            - key: *Key* ключ
        
        - Returns:
            *Bool* результат проверки
     */
    private func check(index: Int, and key: Key) -> Bool {
        index < count && arr[index].key == key
    }
    
    /**
        Получение значения по ключу
     
        - Parameters:
            - key: *Key* ключ
     
        - Returns:
            *[Value]?* значение
     */
    private func getBy(key: Key) -> [Value]? {
        let index = lowerBound(key: key)
        
        if check(index: index, and: key) {
            return arr[index].value
        }
        
        return nil
    }
    
    /**
        Удаление значения по ключу
     
        - Parameters:
            - key: *Key* ключ
     */
    private func removeBy(key: Key) {
        let index = lowerBound(key: key)
        
        if check(index: index, and: key) {
            arr.remove(at: index)
            count -= 1
        }
    }
    
    /**
        Добавление значения по ключу
     
        - Parameters:
            - key: *Key* ключ
            - value: *[Value]?* значение
     */
    private func addBy(key: Key, and value: [Value]?) {
        guard let value = value else {
            removeBy(key: key)
            return
        }
        
        let index = lowerBound(key: key)
        
        if check(index: index, and: key) {
            arr[index].value = value
        } else if index == 0 && count != 0 && arr[index].key > key {
            arr.insert((key: key, value: value), at: index)
            count += 1
        } else {
            arr.insert((key: key, value: value), at: count != 0 ? index + 1 : index)
            count += 1
        }
    }
    
    /**
        Взятие индекса по ключу
     
        - Parameters:
            - key: *Key* ключ
     
        - Returns:
            *Int* индекс, если такого ключа нет, то возвращается -индекс элемента с ключем меньшим, либо равным
     */
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
