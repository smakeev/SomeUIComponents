//
//  SomeUIComponentsExampleUITests.swift
//  SomeUIComponentsExampleUITests
//
//  Created by Sergey Makeev on 19.09.2025.
//

import XCTest

final class SomeUIComponentsExampleUITests: XCTestCase {

    override func setUpWithError() throws {
        continueAfterFailure = false
        let app = XCUIApplication()
        app.launchForTesting()
        let defaults = UserDefaults(suiteName: "UITestsDefaults")
        defaults?.removeObject(forKey: "logs")
        UserDefaults.standard.synchronize()
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testNavigateToRadioButtonScreen() throws {
            let app = XCUIApplication()

            // open RadioButton Exampler
            let radioButtonCell = app.buttons["RadioButtonNavigationItem"]

            XCTAssertTrue(radioButtonCell.waitForExistence(timeout: 5.0), "Radio button cell not found")

            radioButtonCell.tap()

            // Test of Radio button tap
            let radioButtonScreen = app.staticTexts["RadioButtonScreen"]
            XCTAssertTrue(radioButtonScreen.waitForExistence(timeout: 2.0), "Radio button screen did not appear")
            let radioButton = app.otherElements["RadioButton_1"]
            XCTAssertTrue(radioButton.waitForExistence(timeout: 2.0), "RadioButton not found")
            XCTAssertEqual(radioButton.value as? String, "not selected")

            radioButton.tap()
            XCTAssertEqual(radioButton.value as? String, "selected")

            // Test of disabled
            let radioButtonDisabled = app.otherElements["RadioButton_Disabled"]
            XCTAssertTrue(radioButtonDisabled.waitForExistence(timeout: 2.0), "RadioButton not found")
            XCTAssertEqual(radioButtonDisabled.value as? String, "not selected")
           // XCTAssertFalse(radioButtonDisabled.isHittable) @TODO:
            let radioButton3 = app.otherElements["RadioButton_3"]
            XCTAssertTrue(radioButton3.waitForExistence(timeout: 2.0), "RadioButton_3 not found")
            XCTAssertEqual(radioButton3.label, "RadioButton_3")
            XCTAssertEqual(radioButton3.value as? String, "not selected")

            radioButton3.tap()
            sleep(1)
            let logs = UserDefaults(suiteName: "UITestsDefaults")?.stringArray(forKey: "logs") ?? []
            print("!!!!!! \(logs)")
//            XCTAssertTrue(logs.contains(where: { $0.contains("onChange of RadioButton_3: Selected") }),
//                          "RadioButton_3 onChange log not found") //@TODO:
        }

//    @MainActor
//    func testLaunchPerformance() throws {
//        // This measures how long it takes to launch your application.
//        measure(metrics: [XCTApplicationLaunchMetric()]) {
//            XCUIApplication().launch()
//        }
//    }
}
