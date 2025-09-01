//
//  Suit.swift
//  SomeUIComponents
//
//  Created by Sergey Makeev on 09.11.2024.
//

import Foundation
import SwiftUICore

public struct SomeSuit : SomeUIComponent {
    public static let spade = [
        SomeAnimatableCubicCurve(start: CGPoint(x: 0.50, y: 0.00), end: CGPoint(x: 0.85, y: 0.40), control1: CGPoint(x: 0.60, y: 0.30), control2: CGPoint(x: 0.60, y: 0.30)),
        SomeAnimatableCubicCurve(start: CGPoint(x: 0.85, y: 0.40), end: CGPoint(x: 0.55, y: 0.65), control1: CGPoint(x: 1.15, y: 0.50), control2: CGPoint(x: 0.95, y: 1.20)),
        SomeAnimatableCubicCurve(start: CGPoint(x: 0.55, y: 0.65), end: CGPoint(x: 0.70, y: 0.90), control1: CGPoint(x: 0.55, y: 0.80), control2: CGPoint(x: 0.55, y: 0.80)),
        SomeAnimatableCubicCurve(start: CGPoint(x: 0.70, y: 0.90), end: CGPoint(x: 0.70, y: 1.00), control1: CGPoint(x: 0.80, y: 0.98), control2: CGPoint(x: 0.80, y: 0.98)),
        SomeAnimatableCubicCurve(start: CGPoint(x: 0.70, y: 1.00), end: CGPoint(x: 0.30, y: 1.00), control1: CGPoint(x: 0.70, y: 1.00), control2: CGPoint(x: 0.70, y: 1.00)),
        SomeAnimatableCubicCurve(start: CGPoint(x: 0.30, y: 1.00), end: CGPoint(x: 0.30, y: 0.90), control1: CGPoint(x: 0.20, y: 0.98), control2: CGPoint(x: 0.20, y: 0.98)),
        SomeAnimatableCubicCurve(start: CGPoint(x: 0.30, y: 0.90), end: CGPoint(x: 0.45, y: 0.65), control1: CGPoint(x: 0.45, y: 0.80), control2: CGPoint(x: 0.45, y: 0.80)),
        SomeAnimatableCubicCurve(start: CGPoint(x: 0.45, y: 0.65), end: CGPoint(x: 0.15, y: 0.40), control1: CGPoint(x: 0.05, y: 1.20), control2: CGPoint(x: -0.15, y: 0.50)),
        SomeAnimatableCubicCurve(start: CGPoint(x: 0.15, y: 0.40), end: CGPoint(x: 0.50, y: 0.00), control1: CGPoint(x: 0.40, y: 0.30), control2: CGPoint(x: 0.40, y: 0.30))
    ]

    public static let club = [
        SomeAnimatableCubicCurve(start: CGPoint(x: 0.30, y: 0.30), end: CGPoint(x: 0.70, y: 0.30), control1: CGPoint(x: 0.0, y: -0.1), control2: CGPoint(x: 1.0, y: -0.1)),
        SomeAnimatableCubicCurve(start: CGPoint(x: 0.70, y: 0.30), end: CGPoint(x: 0.55, y: 0.45), control1: CGPoint(x: 0.70, y: 0.30), control2: CGPoint(x: 0.70, y: 0.30)),
        SomeAnimatableCubicCurve(start: CGPoint(x: 0.55, y: 0.45), end: CGPoint(x: 0.55, y: 0.70), control1: CGPoint(x: 1.15, y: 0.0), control2: CGPoint(x: 1.15, y: 1.20)),
        SomeAnimatableCubicCurve(start: CGPoint(x: 0.55, y: 0.70), end: CGPoint(x: 0.70, y: 1.0), control1: CGPoint(x: 0.55, y: 0.70), control2: CGPoint(x: 0.55, y: 0.70)),
        SomeAnimatableCubicCurve(start: CGPoint(x: 0.70, y: 1.0), end: CGPoint(x: 0.30, y: 1.0), control1: CGPoint(x: 0.70, y: 1.0), control2: CGPoint(x: 0.70, y: 1.0)),
        SomeAnimatableCubicCurve(start: CGPoint(x: 0.30, y: 1.0), end: CGPoint(x: 0.45, y: 0.70), control1: CGPoint(x: 0.30, y: 1.0), control2: CGPoint(x: 0.30, y: 1.0)),
        SomeAnimatableCubicCurve(start: CGPoint(x: 0.45, y: 0.70), end: CGPoint(x: 0.45, y: 0.45), control1: CGPoint(x: -0.15, y: 1.2), control2: CGPoint(x: -0.15, y: 0.0)),
        SomeAnimatableCubicCurve(start: CGPoint(x: 0.45, y: 0.45), end: CGPoint(x: 0.3, y: 0.3), control1: CGPoint(x: 0.45, y: 0.45), control2: CGPoint(x: 0.45, y: 0.45))
    ]

    public static let diamond = [
        SomeAnimatableCubicCurve(start: CGPoint(x: 0.5, y: 0.0), end: CGPoint(x: 1.0, y: 0.5), control1: CGPoint(x: 0.7, y: 0.3), control2: CGPoint(x: 0.7, y: 0.3)),
        SomeAnimatableCubicCurve(start: CGPoint(x: 1.0, y: 0.5), end: CGPoint(x: 0.5, y: 1.0), control1: CGPoint(x: 0.7, y: 0.7), control2: CGPoint(x: 0.7, y: 0.7)),
        SomeAnimatableCubicCurve(start: CGPoint(x: 0.5, y: 1.0), end: CGPoint(x: 0.0, y: 0.5), control1: CGPoint(x: 0.3, y: 0.7), control2: CGPoint(x: 0.3, y: 0.7)),
        SomeAnimatableCubicCurve(start: CGPoint(x: 0.0, y: 0.5), end: CGPoint(x: 0.5, y: 0.0), control1: CGPoint(x: 0.3, y: 0.3), control2: CGPoint(x: 0.3, y: 0.3))
    ]

    public static let heart = [
        SomeAnimatableCubicCurve(start: CGPoint(x: 0.5, y: 0.25), end: CGPoint(x: 1.0, y: 0.25), control1: CGPoint(x: 0.5, y: -0.1), control2: CGPoint(x: 1.0, y: 0.0)),
        SomeAnimatableCubicCurve(start: CGPoint(x: 1.0, y: 0.25), end: CGPoint(x: 0.5, y: 1.0), control1: CGPoint(x: 1.0, y: 0.6), control2: CGPoint(x: 0.5, y: 0.8)),
        SomeAnimatableCubicCurve(start: CGPoint(x: 0.5, y: 1.0), end: CGPoint(x: 0.0, y: 0.25), control1: CGPoint(x: 0.5, y: 0.8), control2: CGPoint(x: 0.0, y: 0.6)),
        SomeAnimatableCubicCurve(start: CGPoint(x: 0.0, y: 0.25), end: CGPoint(x: 0.5, y: 0.25), control1: CGPoint(x: 0.0, y: 0.0), control2: CGPoint(x: 0.5, y: -0.1))
    ]
}
