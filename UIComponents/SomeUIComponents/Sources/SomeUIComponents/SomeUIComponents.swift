// The Swift Programming Language
// https://docs.swift.org/swift-book

import SwiftUICore

internal protocol SomeUIComponent {}

public func isFromSomeUIComponents(_ element: Any) -> Bool {
    element is SomeUIComponent
}
