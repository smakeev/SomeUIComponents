//
//  AppRouter.swift
//  SomeUIComponentsDemo
//
//  Created by Sergey Makeev on 19.09.2025.
//

import SwiftUI

enum AppDestination: Hashable {
    case radioButtonTests, radioGroupTests
    static let destinations: [NavigationElement] = [
        NavigationElement(text: "RadioButton Tests", accessibilityIdentifier: "RadioButtonNavigationItem", destination: .radioButtonTests, content: { RadioButtonExampler() }),
        NavigationElement(text: "RadioButton Group", accessibilityIdentifier: "RadioGroupNavigationItem", destination: .radioGroupTests, content: { RadioGroupExampler() }),
    ]
}

@Observable
final class AppRouter {
    var path: [AppDestination] = [] {
        didSet {
            logger.info("📍 Navigation path changed: \(self.path)")
        }
    }
}

struct NavigationElement: Identifiable {
    let id = UUID()

    let text: String
//#if UITESTS
    let accessibilityIdentifier: String
//#endif
    let destination: AppDestination
    let content: () -> AnyView

    init(
        text: String,
        accessibilityIdentifier: String = "",
        destination: AppDestination,
        @ViewBuilder content: @escaping () -> some View
    ) {
        self.text = text
//#if UITESTS
        self.accessibilityIdentifier = accessibilityIdentifier
//#endif
        self.destination = destination
        self.content = { AnyView(content()) }
    }
}


