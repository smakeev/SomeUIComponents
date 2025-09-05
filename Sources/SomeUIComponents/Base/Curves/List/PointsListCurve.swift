//
//  LineListCurve.swift
//  SomeUIComponents
//
//  Created by Sergey Makeev on 09.11.2024.
//

import Foundation
import SwiftUICore

public struct SomeAnimatablePointsListCurve : VectorArithmetic, SomeUIComponent {
    var values:[CGPoint]

    public var magnitudeSquared: Double {
        return 0.0
    }

    public mutating func scale(by rhs: Double) {
        values = values.map{ CGPoint(x: $0.x * rhs, y: $0.y * rhs) }
    }

    public static var zero: SomeAnimatablePointsListCurve {
        return SomeAnimatablePointsListCurve(values: [CGPoint.zero])
    }

    public static func - (lhs: SomeAnimatablePointsListCurve, rhs: SomeAnimatablePointsListCurve) -> SomeAnimatablePointsListCurve {
        let lists = equalizeArrays(lhs, rhs)
        let result = zip(lists.0, lists.1).map { p1, p2 in
            CGPoint(x: p1.x - p2.x, y: p1.y - p2.y)
        }
        return SomeAnimatablePointsListCurve(values: result)
    }

    public static func -= (lhs: inout SomeAnimatablePointsListCurve, rhs: SomeAnimatablePointsListCurve) {
        lhs = lhs - rhs
    }

    public static func + (lhs: SomeAnimatablePointsListCurve, rhs: SomeAnimatablePointsListCurve) -> SomeAnimatablePointsListCurve {
        let lists = equalizeArrays(lhs, rhs)
        let result = zip(lists.0, lists.1).map { p1, p2 in
            CGPoint(x: p1.x + p2.x, y: p1.y + p2.y)
        }
        return SomeAnimatablePointsListCurve(values: result)
    }

    public static func += (lhs: inout SomeAnimatablePointsListCurve, rhs: SomeAnimatablePointsListCurve) {
        lhs = lhs + rhs
    }

    fileprivate static func padShorterList(_ shortList: inout [CGPoint], _ longList: [CGPoint]) {
        // Create a curve with all points set to the first/last point
        // Extend the shorter list with repeats of this point

        if let point = shortList.last {
            for i in(shortList.count..<longList.count) {
                shortList.append(point)
            }
        }
    }

    fileprivate static func equalizeArrays(_ lhs: SomeAnimatablePointsListCurve, _ rhs: SomeAnimatablePointsListCurve) -> ([CGPoint], [CGPoint]) {
        var leftValues = lhs.values
        var rightValues = rhs.values
        if leftValues.count < rightValues.count {
            padShorterList(&leftValues, rightValues)
        }
        else if rightValues.count < leftValues.count {
            padShorterList(&rightValues, leftValues)
        }
        return (leftValues, rightValues)
    }
}
