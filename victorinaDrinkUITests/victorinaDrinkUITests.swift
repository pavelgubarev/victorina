//
//  victorinaDrinkUITests.swift
//  victorinaDrinkUITests
//
//  Created by Павел Губарев on 16/02/2018.
//  Copyright © 2018 Pavel Gubarev. All rights reserved.
//

import XCTest

class victorinaDrinkUITests: XCTestCase {
        
    override func setUp() {
        super.setUp()
        
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = true
        // UI tests must launch the application that they test. Doing this in setup will make sure it happens for each test method.
        XCUIApplication().launch()

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
      //  super.tearDown()
    }
    
    func flow2Levels() {
        
    }
    
    func testExample() {
        
        let app = XCUIApplication()
        app.buttons["Начать"].tap()
        
        let tablesQuery = app.tables
        tablesQuery/*@START_MENU_TOKEN@*/.staticTexts["Лучшая закуска – фрукты, виноград или квашеная капуста."]/*[[".cells.staticTexts[\"Лучшая закуска – фрукты, виноград или квашеная капуста.\"]",".staticTexts[\"Лучшая закуска – фрукты, виноград или квашеная капуста.\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        
        let button = app.buttons["Дальше"]
        button.tap()
        tablesQuery/*@START_MENU_TOKEN@*/.staticTexts["Без разницы: главное не смешивать"]/*[[".cells.staticTexts[\"Без разницы: главное не смешивать\"]",".staticTexts[\"Без разницы: главное не смешивать\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        button.tap()
        tablesQuery/*@START_MENU_TOKEN@*/.staticTexts["Только на следующий день"]/*[[".cells.staticTexts[\"Только на следующий день\"]",".staticTexts[\"Только на следующий день\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        button.tap()
        tablesQuery/*@START_MENU_TOKEN@*/.staticTexts["Лимонный сок"]/*[[".cells.staticTexts[\"Лимонный сок\"]",".staticTexts[\"Лимонный сок\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        button.tap()
        tablesQuery/*@START_MENU_TOKEN@*/.staticTexts["Надо отнести его в тёплое место и только потом можно ему дать водки"]/*[[".cells.staticTexts[\"Надо отнести его в тёплое место и только потом можно ему дать водки\"]",".staticTexts[\"Надо отнести его в тёплое место и только потом можно ему дать водки\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        button.tap()
        tablesQuery/*@START_MENU_TOKEN@*/.staticTexts["Водка"]/*[[".cells.staticTexts[\"Водка\"]",".staticTexts[\"Водка\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        app.children(matching: .window).element(boundBy: 0).children(matching: .other).element(boundBy: 11).children(matching: .other).element.children(matching: .other).element(boundBy: 0).tap()
        button.tap()
        tablesQuery/*@START_MENU_TOKEN@*/.staticTexts["Лучше пить реже, хоть и больше"]/*[[".cells.staticTexts[\"Лучше пить реже, хоть и больше\"]",".staticTexts[\"Лучше пить реже, хоть и больше\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        button.tap()
        
        let button2 = app.buttons["Следующий уровень"]
        button2.tap()
        tablesQuery/*@START_MENU_TOKEN@*/.staticTexts["Выпить много жидкости и принять мочегонные"]/*[[".cells.staticTexts[\"Выпить много жидкости и принять мочегонные\"]",".staticTexts[\"Выпить много жидкости и принять мочегонные\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        button.tap()
        tablesQuery/*@START_MENU_TOKEN@*/.staticTexts["Валерьянка"]/*[[".cells.staticTexts[\"Валерьянка\"]",".staticTexts[\"Валерьянка\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        button.tap()
        tablesQuery/*@START_MENU_TOKEN@*/.staticTexts["Зимой"]/*[[".cells.staticTexts[\"Зимой\"]",".staticTexts[\"Зимой\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        button.tap()
        tablesQuery/*@START_MENU_TOKEN@*/.staticTexts["Мешает перерабатывать алкоголь из-за того крадёт витамин B"]/*[[".cells.staticTexts[\"Мешает перерабатывать алкоголь из-за того крадёт витамин B\"]",".staticTexts[\"Мешает перерабатывать алкоголь из-за того крадёт витамин B\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        button.tap()
        tablesQuery/*@START_MENU_TOKEN@*/.staticTexts["Пьяная женщина"]/*[[".cells.staticTexts[\"Пьяная женщина\"]",".staticTexts[\"Пьяная женщина\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        button.tap()
        tablesQuery/*@START_MENU_TOKEN@*/.staticTexts["Истощают ресурсы организма и провоцируют на опасное поведение"]/*[[".cells.staticTexts[\"Истощают ресурсы организма и провоцируют на опасное поведение\"]",".staticTexts[\"Истощают ресурсы организма и провоцируют на опасное поведение\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        button.tap()
        tablesQuery/*@START_MENU_TOKEN@*/.staticTexts["Боли в правом подреберье"]/*[[".cells.staticTexts[\"Боли в правом подреберье\"]",".staticTexts[\"Боли в правом подреберье\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        button.tap()
        button2.tap()
        tablesQuery/*@START_MENU_TOKEN@*/.staticTexts["Квашеной капустой"]/*[[".cells.staticTexts[\"Квашеной капустой\"]",".staticTexts[\"Квашеной капустой\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        button.tap()

       
    }
    
    func new() {
        
        
    }
    
}
