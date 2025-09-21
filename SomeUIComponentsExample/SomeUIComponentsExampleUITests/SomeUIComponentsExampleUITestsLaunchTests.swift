//
//  SomeUIComponentsExampleUITestsLaunchTests.swift
//  SomeUIComponentsExampleUITests
//
//  Created by Sergey Makeev on 19.09.2025.
//

import XCTest

extension XCUIApplication {
    func launchForTesting() {
        if !launchArguments.contains("uitest") {
            launchArguments = ["uitest"]
            launch()
            Thread.sleep(forTimeInterval: 5)
        } else if state != .runningForeground {
            activate()
            Thread.sleep(forTimeInterval: 5)
        }
    }
}

//        for button in app.buttons.allElementsBoundByIndex {
//            print("!!!!! Button: \(button.label), ID: \(button.identifier)")
//        }

//final class SomeUIComponentsExampleUITestsLaunchTests: XCTestCase {
//
//    override class var runsForEachTargetApplicationUIConfiguration: Bool {
//        true
//    }
//
//    override func setUpWithError() throws {
//        continueAfterFailure = false
//    }
//
//    @MainActor
//    func testLaunch() throws {
//        let app = XCUIApplication()
//        app.launch()
//
//        // Insert steps here to perform after app launch but before taking a screenshot,
//        // such as logging into a test account or navigating somewhere in the app
//
//        let attachment = XCTAttachment(screenshot: app.screenshot())
//        attachment.name = "Launch Screen"
//        attachment.lifetime = .keepAlways
//        add(attachment)
//    }
//}
