//
//  TodoListTests.swift
//  TodoListTests
//
//  Created by Danil Lyskin on 19.11.2021.
//

import XCTest
@testable import TodoList

class TaskCardCreatorTests: XCTestCase {
    
    var sut: TaskCardCreatorViewController!
    var sut2: ViewController!
    let db = DataProvider.shared
    
    override func setUpWithError() throws {
        try super.setUpWithError()
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        sut2 = (storyboard.instantiateViewController(withIdentifier: "ToDoMainViewController") as! ViewController)
        sut2.loadViewIfNeeded()
        
        sut = TaskCardCreatorViewController()
        sut.delegate = sut2
        sut.loadViewIfNeeded()
    }

    override func tearDownWithError() throws {
        sut = nil
        sut2 = nil
        
        try super.tearDownWithError()
    }
    
    func testTrimmerEmptyString() {
        // Given
        
        var str = ""
        
        // When

        str = str.deleteAllWhitespaceInEnd()
        
        // Then
        
        XCTAssertEqual(str, "")
    }
    
    func testTrimmerOnlyWhitespaceString() {
        // Given
        
        var str = " \n\t"
        
        // When
        
        str = str.deleteAllWhitespaceInEnd()
        
        // Then
        
        XCTAssertEqual(str, "")
    }
    
    func testTrimmerStringWhitWhiteSpaceInTheEnd() {
        // Given
        
        var str = "Hello world!"
        str.append(contentsOf: "\n \t")
        
        // When

        str = str.deleteAllWhitespaceInEnd()
        
        // Then
        
        XCTAssertEqual(str, "Hello world!")
    }
    
    func testAddingTask() {
        db.deleteAllTasks()
        sut.nameField.text = "Hello"
        sut.descriptionField.text = "World!"
        
        let addButton: UIButton = sut.addButton
        XCTAssertNotNil(addButton, "View Controller does not have UIButton property")
            
        addButton.sendActions(for: .touchUpInside)
        
        let tasks = db.gettingAllTasks()
        XCTAssertEqual(tasks.count, 1)
        
        XCTAssertTrue(tasks.contains { task in
            task.name == "Hello" && task.descriptions == "World!"
        })
        
        db.deleteAllTasks()
    }

}
