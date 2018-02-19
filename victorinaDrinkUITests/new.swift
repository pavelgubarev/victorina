//
//  new.swift
//  victorinaDrinkUITests
//
//  Created by Павел Губарев on 16/02/2018.
//  Copyright © 2018 Pavel Gubarev. All rights reserved.
//

import XCTest

class new: XCTestCase {
        
    override func setUp() {
        super.setUp()
        
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false
        // UI tests must launch the application that they test. Doing this in setup will make sure it happens for each test method.
        XCUIApplication().launch()

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
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
        tablesQuery/*@START_MENU_TOKEN@*/.staticTexts["С тёплой водой"]/*[[".cells.staticTexts[\"С тёплой водой\"]",".staticTexts[\"С тёплой водой\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        button.tap()
        tablesQuery/*@START_MENU_TOKEN@*/.staticTexts["Витамин B"]/*[[".cells.staticTexts[\"Витамин B\"]",".staticTexts[\"Витамин B\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        button.tap()
        tablesQuery/*@START_MENU_TOKEN@*/.staticTexts["Любой алкоголь"]/*[[".cells.staticTexts[\"Любой алкоголь\"]",".staticTexts[\"Любой алкоголь\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        button.tap()
        tablesQuery/*@START_MENU_TOKEN@*/.staticTexts["Хорошая закуска: восполняет запасы натрия"]/*[[".cells.staticTexts[\"Хорошая закуска: восполняет запасы натрия\"]",".staticTexts[\"Хорошая закуска: восполняет запасы натрия\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        button.tap()
        tablesQuery/*@START_MENU_TOKEN@*/.staticTexts["Ничем не поможет."]/*[[".cells.staticTexts[\"Ничем не поможет.\"]",".staticTexts[\"Ничем не поможет.\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        button.tap()
        tablesQuery/*@START_MENU_TOKEN@*/.staticTexts["Нигде не копятся."]/*[[".cells.staticTexts[\"Нигде не копятся.\"]",".staticTexts[\"Нигде не копятся.\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        button.tap()
        app.buttons["Пропустить"].tap()
        
        sleep(10)

    }
    
    
    
}
