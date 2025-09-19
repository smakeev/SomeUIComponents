//
//  CubicCurve.swift
//  SomeUIComponents
//
//  Created by Sergey Makeev on 09.11.2024.
//

import Foundation
import SwiftUI

public struct SomeCubicCurve:  VectorArithmetic, Sendable, SomeUIComponent {
     var point: CGPoint
     var control1: CGPoint
     var control2: CGPoint

     public var magnitudeSquared: Double {
         return 0.0
     }

     public mutating func scale(by rhs: Double) {
         self.point.x.scale(by: rhs)
         self.point.y.scale(by: rhs)
         self.control1.x.scale(by: rhs)
         self.control1.y.scale(by: rhs)
         self.control2.x.scale(by: rhs)
         self.control2.y.scale(by: rhs)
     }

     public static var zero: SomeCubicCurve {
         return SomeCubicCurve(point: CGPoint(x: 0.0, y: 0.0),
                           control1: CGPoint(x: 0.0, y: 0.0),
                           control2: CGPoint(x: 0.0, y: 0.0))
     }

     public static func - (lhs: SomeCubicCurve, rhs: SomeCubicCurve) -> SomeCubicCurve {
         return SomeCubicCurve(
             point: CGPoint(
                 x: lhs.point.x - rhs.point.x,
                 y: lhs.point.y - rhs.point.y),
             control1: CGPoint(
                 x: lhs.control1.x - rhs.control1.x,
                 y: lhs.control1.y - rhs.control1.y),
             control2: CGPoint(
                 x: lhs.control2.x - rhs.control2.x,
                 y: lhs.control2.y - rhs.control2.y))
     }

     public static func -= (lhs: inout SomeCubicCurve, rhs: SomeCubicCurve) {
         lhs = lhs - rhs
     }

     public static func + (lhs: SomeCubicCurve, rhs: SomeCubicCurve) -> SomeCubicCurve {
         return SomeCubicCurve(
             point: CGPoint(
                 x: lhs.point.x + rhs.point.x,
                 y: lhs.point.y + rhs.point.y),
             control1: CGPoint(
                 x: lhs.control1.x + rhs.control1.x,
                 y: lhs.control1.y + rhs.control1.y),
             control2: CGPoint(
                 x: lhs.control2.x + rhs.control2.x,
                 y: lhs.control2.y + rhs.control2.y))
     }

     public static func += (lhs: inout SomeCubicCurve, rhs: SomeCubicCurve) {
         lhs = lhs + rhs
     }

     public static func * (lhs: SomeCubicCurve, rhs: Double) -> SomeCubicCurve {
         return SomeCubicCurve(
             point: CGPoint(
                 x: lhs.point.x * CGFloat(rhs),
                 y: lhs.point.y * CGFloat(rhs)),
             control1: CGPoint(
                 x: lhs.control1.x * CGFloat(rhs),
                 y: lhs.control1.y * CGFloat(rhs)),
             control2: CGPoint(
                 x: lhs.control2.x * CGFloat(rhs),
                 y: lhs.control2.y * CGFloat(rhs)))
     }
}

public struct SomeAnimatableCubicCurve: VectorArithmetic, Sendable, SomeUIComponent {
    var start: CGPoint
    var end: CGPoint
    var control1: CGPoint
    var control2: CGPoint

    var length: Double {
        return Double(((end.x - start.x) * (end.x - start.x)) +
                        ((end.y - start.y) * (end.y - start.y))).squareRoot()
    }

    public var magnitudeSquared: Double {
        return length * length
    }

    public init(start: CGPoint, end: CGPoint, control1: CGPoint, control2: CGPoint) {
        self.start = start
        self.end = end
        self.control1 = control1
        self.control2 = control2
    }

    public
    mutating func scale(by rhs: Double) {
        self.start.x.scale(by: rhs)
        self.start.y.scale(by: rhs)
        self.end.x.scale(by: rhs)
        self.end.y.scale(by: rhs)
        self.control1.x.scale(by: rhs)
        self.control1.y.scale(by: rhs)
        self.control2.x.scale(by: rhs)
        self.control2.y.scale(by: rhs)
    }

    public
    static var zero: SomeAnimatableCubicCurve {
        return SomeAnimatableCubicCurve(start: CGPoint(x: 0.0, y: 0.0),
                                    end: CGPoint(x: 0.0, y: 0.0),
                                    control1: CGPoint(x: 0.0, y: 0.0),
                                    control2: CGPoint(x: 0.0, y: 0.0))
    }

    public
    static func - (lhs: SomeAnimatableCubicCurve, rhs: SomeAnimatableCubicCurve) -> SomeAnimatableCubicCurve {
        return SomeAnimatableCubicCurve(
            start: CGPoint(
                x: lhs.start.x - rhs.start.x,
                y: lhs.start.y - rhs.start.y),
            end: CGPoint(
                x: lhs.end.x - rhs.end.x,
                y: lhs.end.y - rhs.end.y),
            control1: CGPoint(
                x: lhs.control1.x - rhs.control1.x,
                y: lhs.control1.y - rhs.control1.y),
            control2: CGPoint(
                x: lhs.control2.x - rhs.control2.x,
                y: lhs.control2.y - rhs.control2.y))
    }

    public
    static func -= (lhs: inout SomeAnimatableCubicCurve, rhs: SomeAnimatableCubicCurve) {
        lhs = lhs - rhs
    }

    public
    static func + (lhs: SomeAnimatableCubicCurve, rhs: SomeAnimatableCubicCurve) -> SomeAnimatableCubicCurve {
        return SomeAnimatableCubicCurve(
            start: CGPoint(
                x: lhs.start.x + rhs.start.x,
                y: lhs.start.y + rhs.start.y),
            end: CGPoint(
                x: lhs.end.x + rhs.end.x,
                y: lhs.end.y + rhs.end.y),
            control1: CGPoint(
                x: lhs.control1.x + rhs.control1.x,
                y: lhs.control1.y + rhs.control1.y),
            control2: CGPoint(
                x: lhs.control2.x + rhs.control2.x,
                y: lhs.control2.y + rhs.control2.y))
    }

    public
    static func += (lhs: inout SomeAnimatableCubicCurve, rhs: SomeAnimatableCubicCurve) {
        lhs = lhs + rhs
    }
}
