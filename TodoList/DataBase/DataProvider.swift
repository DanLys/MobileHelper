//
//  DataProvider.swift
//  TodoList
//
//  Created by Danil Lyskin on 15.01.2022.
//

import RealmSwift
import OSLog

/**
 Класс, взаимодействующий с базой данных
 
 Синглтон класс, отвечающий за:
    - Сохранение
    - Обновление
    - Удаление
 
    задач в базе данных
 */
class DataProvider {
    
    //MARK: Инициализация

    /**
        Поле через которое происходит использование функций *DataProvider*
     */
    static var shared: DataProvider = {
        DataProvider()
    }()
    
    private let uiRealm: Realm!
    private let loggin: OSLog!
    
    private init() {
        let version = Realm.Configuration(schemaVersion: 2)
        self.uiRealm = try! Realm(configuration: version)
        
        loggin = OSLog(subsystem: "ToDo List", category: "DataBase provider")
    }
    
    //MARK: Основной функционал
    /**
        Сохранение изменений
     */
    private func commit() {
        do {
            try self.uiRealm.commitWrite()
            os_log(.info, log: loggin, "Commit updates db")
        } catch {
            os_log(.error, log: loggin, "Error commiting updates in db")
        }
    }
    
    /**
        Добавление новой задачи в базу данных
            
        - Parameters:
            - task: *TaskDTO* представление задачи
    */
    func saveTask(task: TaskDTO) {
        
        if #available(iOS 14.0, *) {
            os_log(.info, log: loggin, "Start save new task: \(task)")
        } else {
            NSLog("Start save new task: %@", "\(task)")
        }
        
        self.uiRealm.beginWrite()
        self.uiRealm.add(task)
        
        commit()
    }
    
    /**
        Получение всех задач из базы данных
     
        - Returns:
            Массив задач *TaskDTO*
     */
    func gettingAllTasks() -> [TaskDTO] {
        os_log(.info, "Getting all tasks")
        
        return self.uiRealm.objects(TaskDTO.self).map { $0 }
    }
    
    /**
        Удаление  задачи из базы данных
            
        - Parameters:
            - task: *TaskDTO* представление задачи
    */
    func deleteTask(task: TaskDTO) {
        if #available(iOS 14.0, *) {
            os_log(.info, log: loggin, "Start delete task: \(task)")
        } else {
            NSLog("Start delete task: %@", "\(task)")
        }
        
        self.uiRealm.beginWrite()
        self.uiRealm.delete(task)
        
        commit()
    }
    
    /**
        Удаление всех задач из базы данных
     */
    func deleteAllTasks() {
        os_log(.info, log: loggin, "Start deleting all tasks")
        
        self.uiRealm.beginWrite()
        self.uiRealm.delete(gettingAllTasks())
        
        commit()
    }
    
    /**
        Обновление  задачи в базе данных
            
        - Parameters:
            - oldTask: *TaskDTO* представление задачи, которое было раньше
            - to: *TaskDTO* представление обновленной задачи
    */
    func update(oldTask: TaskDTO, to newTask: TaskDTO) {
        if #available(iOS 14.0, *) {
            os_log(.info, log: loggin, "Start update old task:\n\(oldTask)\nto\n\(newTask)")
        } else {
            NSLog("Start update old task:\n%@\nto\n%@", "\(oldTask)", "\(newTask)")
        }
        
        self.uiRealm.beginWrite()
        oldTask.name = newTask.name
        oldTask.descriptions = newTask.descriptions
        
        commit()
    }
}
