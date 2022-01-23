//
//  Task.swift
//  TodoList
//
//  Created by Danil Lyskin on 19.11.2021.
//

import Foundation
import RealmSwift

@objc
protocol AbstractTask {
    @objc dynamic var id: String { get }
}

/**
     Представление задачи
     
     - id: уникальное значение, являющееся `PrimaryKey`
     - name: название задачи
     - descriptions: описание задачи
 */
class TaskDTO: Object, AbstractTask {
    @objc dynamic var id = UUID().uuidString
    @objc dynamic var name: String = ""
    @objc dynamic var descriptions: String = ""
    @objc dynamic var date: Date = NSDate.now
    
    override static func primaryKey() -> String? {
        return "id"
    }
    
    convenience init(name: String, descriptions: String, date: Date) {
        self.init()
        
        self.name = name
        self.descriptions = descriptions
        self.date = date
    }
}
