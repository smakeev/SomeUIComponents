//
//  LineCurve.swift
//  SomeUIComponents
//
//  Created by Sergey Makeev on 09.11.2024.
//

import Foundation
import SwiftUI

public struct SomeAnimatableLineSegment : VectorArithmetic, Sendable, SomeUIComponent {
    var startPoint: CGPoint
    var endPoint: CGPoint

    var length: Double {
        return Double(((endPoint.x - startPoint.x) * (endPoint.x - startPoint.x)) +
                        ((endPoint.y - startPoint.y) * (endPoint.y - startPoint.y))).squareRoot()
    }

    public var magnitudeSquared: Double {
        return length * length
    }

    mutating public func scale(by rhs: Double) {
        self.startPoint.x.scale(by: rhs)
        self.startPoint.y.scale(by: rhs)
        self.endPoint.x.scale(by: rhs)
        self.endPoint.y.scale(by: rhs)
    }

    public static var zero: SomeAnimatableLineSegment {
        return SomeAnimatableLineSegment(startPoint: CGPoint(x: 0.0, y: 0.0),
                                 endPoint: CGPoint(x: 0.0, y: 0.0))
    }

    public static func - (lhs: SomeAnimatableLineSegment, rhs: SomeAnimatableLineSegment) -> SomeAnimatableLineSegment {
        return SomeAnimatableLineSegment(
            startPoint: CGPoint(x: lhs.startPoint.x - rhs.startPoint.x,
                                y: lhs.startPoint.y - rhs.startPoint.y),
            endPoint: CGPoint(x: lhs.endPoint.x - rhs.endPoint.x,
                              y: lhs.endPoint.y - rhs.endPoint.y))
    }

    public static func -= (lhs: inout SomeAnimatableLineSegment, rhs: SomeAnimatableLineSegment) {
        lhs = lhs - rhs
    }

    public static func + (lhs: SomeAnimatableLineSegment, rhs: SomeAnimatableLineSegment) -> SomeAnimatableLineSegment {
        return SomeAnimatableLineSegment(
            startPoint: CGPoint(x: lhs.startPoint.x + rhs.startPoint.x,
                                y: lhs.startPoint.y + rhs.startPoint.y),
            endPoint: CGPoint(x: lhs.endPoint.x + rhs.endPoint.x,
                              y: lhs.endPoint.y + rhs.endPoint.y))
    }

    public static func += (lhs: inout SomeAnimatableLineSegment, rhs: SomeAnimatableLineSegment) {
        lhs = lhs + rhs
    }
}
