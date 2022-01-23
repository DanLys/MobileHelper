//
//  ViewControllerTest.swift
//  TodoListTests
//
//  Created by Danil Lyskin on 23.01.2022.
//

import XCTest
@testable import TodoList

class ViewControllerTests: XCTestCase {
    
    var sut: ViewController!
    let db = DataProvider.shared
    
    override func setUpWithError() throws {
        try super.setUpWithError()
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        sut = (storyboard.instantiateViewController(withIdentifier: "ToDoMainViewController") as! ViewController)
        
        sut.loadViewIfNeeded()
        db.deleteAllTasks()
    }

    override func tearDownWithError() throws {
        sut = nil
        db.deleteAllTasks()
        
        try super.tearDownWithError()
    }
    
    private func addTask(_ n: Int) {
        for _ in 0..<n {
            let task = createTask(false)
            
            db.saveTask(task: task)
        }
    }
    
    private func createTask(_ flag: Bool) -> TaskDTO {
        let date = Date.getNowDate()
        return TaskDTO(name: "generated\(flag ? " updated" : "")", descriptions: "task", date: date)
    }
    
    private func checkEqualTasks(_ task: TaskDTO) {
        XCTAssertEqual(task.name, "generated")
        XCTAssertEqual(task.descriptions, "task")
        XCTAssertEqual(task.date, Date.getNowDate())
    }
    
    func testAddTaskToEmptyDB() {
        // Given
        
        let task = createTask(false)
        
        // When
        
        sut.addTask(task: task)
        
        // Then
        
        let tasks = db.gettingAllTasks()
        XCTAssertEqual(tasks.count, 1)
        checkEqualTasks(tasks[0])
    }
    
    func testAddTaskToNotEmptyDB() {
        // Given
        
        addTask(2)
        let task = createTask(false)
        
        // When
        
        sut.addTask(task: task)
        
        // Then
        
        XCTAssertEqual(db.gettingAllTasks().count, 3)
    }
    
    func testUpdateTask() {
        // Given
        
        var task = createTask(false)
        
        // When
        
        sut.addTask(task: task)
        task = createTask(true)
        sut.updateTask(task: task, indexPath: IndexPath(row: 0, section: 0))
        
        // Then
        
        let tasks = db.gettingAllTasks()
        XCTAssertEqual(tasks.count, 1)
        XCTAssertEqual(tasks[0].name, "generated updated")
    }
}
