//
//  TodoListUITests.swift
//  TodoListUITests
//
//  Created by Danil Lyskin on 19.11.2021.
//

import XCTest

class TodoListUITests: XCTestCase {

    var app: XCUIApplication!
    
    override func setUpWithError() throws {
        try super.setUpWithError()
        
        continueAfterFailure = false
        app = XCUIApplication()
    }
    
    func testAddTwoTask() {
        app.launchArguments = ["Test-empty-app"]
        app.launch()
        
        let plusbuttonButton = app/*@START_MENU_TOKEN@*/.buttons["PlusButton"]/*[[".buttons[\"plus\"]",".buttons[\"PlusButton\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
        plusbuttonButton.tap()
        
        let namefieldforcreatorTextView = app.textViews["NameFieldForCreator"]
        namefieldforcreatorTextView.tap()
        
        let fKey = app/*@START_MENU_TOKEN@*/.keys["F"]/*[[".keyboards.keys[\"F\"]",".keys[\"F\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
        fKey.tap()
        
        let iKey = app/*@START_MENU_TOKEN@*/.keys["i"]/*[[".keyboards.keys[\"i\"]",".keys[\"i\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
        iKey.tap()
        
        let rKey = app/*@START_MENU_TOKEN@*/.keys["r"]/*[[".keyboards.keys[\"r\"]",".keys[\"r\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
        rKey.tap()
        
        let sKey = app/*@START_MENU_TOKEN@*/.keys["s"]/*[[".keyboards.keys[\"s\"]",".keys[\"s\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
        sKey.tap()
        
        let tKey = app/*@START_MENU_TOKEN@*/.keys["t"]/*[[".keyboards.keys[\"t\"]",".keys[\"t\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
        tKey.tap()
        
        let descriptionfieldforcreatorTextView = app.textViews["DescriptionFieldForCreator"]
        descriptionfieldforcreatorTextView.tap()
        
        let tKey2 = app/*@START_MENU_TOKEN@*/.keys["T"]/*[[".keyboards.keys[\"T\"]",".keys[\"T\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
        tKey2.tap()
        
        let aKey = app/*@START_MENU_TOKEN@*/.keys["a"]/*[[".keyboards.keys[\"a\"]",".keys[\"a\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
        aKey.tap()
        sKey.tap()
        
        let kKey = app/*@START_MENU_TOKEN@*/.keys["k"]/*[[".keyboards.keys[\"k\"]",".keys[\"k\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
        kKey.tap()
        
        app.staticTexts["Description:"].tap()
        app/*@START_MENU_TOKEN@*/.staticTexts["ADD"]/*[[".buttons[\"ADD\"].staticTexts[\"ADD\"]",".buttons[\"AddButton\"].staticTexts[\"ADD\"]",".staticTexts[\"ADD\"]"],[[[-1,2],[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        plusbuttonButton.tap()
        namefieldforcreatorTextView.tap()
        
        let sKey2 = app/*@START_MENU_TOKEN@*/.keys["S"]/*[[".keyboards.keys[\"S\"]",".keys[\"S\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
        sKey2.tap()
        
        let eKey = app/*@START_MENU_TOKEN@*/.keys["e"]/*[[".keyboards.keys[\"e\"]",".keys[\"e\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
        eKey.tap()
        
        let cKey = app/*@START_MENU_TOKEN@*/.keys["c"]/*[[".keyboards.keys[\"c\"]",".keys[\"c\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
        cKey.tap()
        
        let oKey = app/*@START_MENU_TOKEN@*/.keys["o"]/*[[".keyboards.keys[\"o\"]",".keys[\"o\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
        oKey.tap()
        
        let nKey = app/*@START_MENU_TOKEN@*/.keys["n"]/*[[".keyboards.keys[\"n\"]",".keys[\"n\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
        nKey.tap()
        
        let dKey = app/*@START_MENU_TOKEN@*/.keys["d"]/*[[".keyboards.keys[\"d\"]",".keys[\"d\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
        dKey.tap()
        descriptionfieldforcreatorTextView.tap()
        tKey2.tap()
        aKey.tap()
        sKey.tap()
        kKey.tap()
        app.staticTexts["Name:"].tap()
        app/*@START_MENU_TOKEN@*/.buttons["AddButton"]/*[[".buttons[\"ADD\"]",".buttons[\"AddButton\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        
        XCTAssertEqual(app.tables["TaskTable"].cells.count, 2)
    }
    
    func testUpdateTask() {
        app.launchArguments = ["Test-empty-app", "Test-with-one-task"]
        app.launch()
        
        app.tables["TaskTable"].cells["Test:::Test:::withIndex0:0"].children(matching: .staticText).matching(identifier: "Test").element(boundBy: 0).tap()
        app.textViews["NameFieldForCreator"].tap()
        
        let uKey = app.keys["U"]
        uKey.tap()
        
        let pKey = app/*@START_MENU_TOKEN@*/.keys["p"]/*[[".keyboards.keys[\"p\"]",".keys[\"p\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
        pKey.tap()
        
        let dKey = app/*@START_MENU_TOKEN@*/.keys["d"]/*[[".keyboards.keys[\"d\"]",".keys[\"d\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
        dKey.tap()
        
        let aKey = app/*@START_MENU_TOKEN@*/.keys["a"]/*[[".keyboards.keys[\"a\"]",".keys[\"a\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
        aKey.tap()
        
        let tKey = app/*@START_MENU_TOKEN@*/.keys["t"]/*[[".keyboards.keys[\"t\"]",".keys[\"t\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
        tKey.tap()
        
        let eKey = app/*@START_MENU_TOKEN@*/.keys["e"]/*[[".keyboards.keys[\"e\"]",".keys[\"e\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
        eKey.tap()
        dKey.tap()
        app.textViews["DescriptionFieldForCreator"].tap()
        uKey.tap()
        pKey.tap()
        dKey.tap()
        aKey.tap()
        tKey.tap()
        eKey.tap()
        dKey.tap()
        app.staticTexts["Description:"].tap()
        app/*@START_MENU_TOKEN@*/.buttons["AddButton"]/*[[".buttons[\"UPDATE\"]",".buttons[\"AddButton\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        
        XCTAssertEqual(app.tables["TaskTable"].cells.count, 1)
        XCTAssertEqual(app.tables["TaskTable"].cells.staticTexts["CustomCellName"].label, "UpdatedTest")
        XCTAssertEqual(app.tables["TaskTable"].cells.staticTexts["CustomCellDescriptions"].label, "UpdatedTest")
    }
    
    func testDeleteTaskWithTap() {
        app.launchArguments = ["Test-empty-app", "Test-with-two-task"]
        app.launch()
        
        let cells = app.tables["TaskTable"].cells
        cells["Test:::Test:::withIndex0:0"].swipeLeft()
        
        cells.buttons["Delete"].tap()
        XCTAssertEqual(cells.count, 1)
    }
    
    func testAddEmptyTask() {
        app.launchArguments = ["Test-empty-app"]
        app.launch()

        app/*@START_MENU_TOKEN@*/.buttons["PlusButton"]/*[[".buttons[\"plus\"]",".buttons[\"PlusButton\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        app/*@START_MENU_TOKEN@*/.buttons["AddButton"]/*[[".buttons[\"ADD\"]",".buttons[\"AddButton\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        
        XCTAssertEqual(app.tables["TaskTable"].cells.count, 0)
    }
}
