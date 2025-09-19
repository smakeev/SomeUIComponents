//
//  QuadCurve.swift
//  SomeUIComponents
//
//  Created by Sergey Makeev on 09.11.2024.
//

import Foundation
import SwiftUI

public struct SomeAnimatableQuadCurve : VectorArithmetic, Sendable, SomeUIComponent {
    var start: CGPoint
    var end: CGPoint
    var control: CGPoint

    var length: Double {
        return Double(((end.x - start.x) * (end.x - start.x)) +
                        ((end.y - start.y) * (end.y - start.y))).squareRoot()
    }

    public init(start: CGPoint, end: CGPoint, control: CGPoint) {
        self.start = start
        self.end = end
        self.control = control
    }

    public var magnitudeSquared: Double {
        return length * length
    }

    mutating public func scale(by rhs: Double) {
        self.start.x.scale(by: rhs)
        self.start.y.scale(by: rhs)
        self.end.x.scale(by: rhs)
        self.end.y.scale(by: rhs)
        self.control.x.scale(by: rhs)
        self.control.y.scale(by: rhs)
    }

    public static var zero: SomeAnimatableQuadCurve {
        return SomeAnimatableQuadCurve(start: CGPoint(x: 0.0, y: 0.0),
                                   end: CGPoint(x: 0.0, y: 0.0),
                                   control: CGPoint(x: 0.0, y: 0.0))
    }

    public static func - (lhs: SomeAnimatableQuadCurve, rhs: SomeAnimatableQuadCurve) -> SomeAnimatableQuadCurve {
        return SomeAnimatableQuadCurve(
            start: CGPoint(
                x: lhs.start.x - rhs.start.x,
                y: lhs.start.y - rhs.start.y),
            end: CGPoint(
                x: lhs.end.x - rhs.end.x,
                y: lhs.end.y - rhs.end.y),
            control: CGPoint(
                x: lhs.control.x - rhs.control.x,
                y: lhs.control.y - rhs.control.y))
    }

    public static func -= (lhs: inout SomeAnimatableQuadCurve, rhs: SomeAnimatableQuadCurve) {
        lhs = lhs - rhs
    }

    public static func + (lhs: SomeAnimatableQuadCurve, rhs: SomeAnimatableQuadCurve) -> SomeAnimatableQuadCurve {
        return SomeAnimatableQuadCurve(
            start: CGPoint(
                x: lhs.start.x + rhs.start.x,
                y: lhs.start.y + rhs.start.y),
            end: CGPoint(
                x: lhs.end.x + rhs.end.x,
                y: lhs.end.y + rhs.end.y),
            control: CGPoint(
                x: lhs.control.x + rhs.control.x,
                y: lhs.control.y + rhs.control.y))
    }

    public static func += (lhs: inout SomeAnimatableQuadCurve, rhs: SomeAnimatableQuadCurve) {
        lhs = lhs + rhs
    }
}
