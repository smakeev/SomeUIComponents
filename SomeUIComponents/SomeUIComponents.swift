// The Swift Programming Language
// https://docs.swift.org/swift-book

import SwiftUI
import Logging

internal protocol SomeUIComponent {}

public func isFromSomeUIComponents(_ element: Any) -> Bool {
    element is SomeUIComponent
}

// MARK: - Public Configuration API
internal  let logger: Logger = Logger(label: "com.UIComponents.someprojects")
