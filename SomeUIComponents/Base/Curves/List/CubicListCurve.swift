//
//  CubicListCurve.swift
//  SomeUIComponents
//
//  Created by Sergey Makeev on 09.11.2024.
//

import Foundation
import SwiftUICore

public struct SomeCubicCurveList : VectorArithmetic, SomeUIComponent {
       var values:[SomeCubicCurve]

       public var magnitudeSquared: Double {
           // dotProduct has no meaning on a list of cubic curves
           return 0.0
       }

       public mutating func scale(by rhs: Double) {
           values = values.map { $0 * rhs }
       }

       public static var zero: SomeCubicCurveList {
           return SomeCubicCurveList(values: [SomeCubicCurve.zero])
       }

       fileprivate static func padShorterList(_ shortList: inout [SomeCubicCurve], _ longList: [SomeCubicCurve]) {
           // Create a curve with all points set to the first/last point
           // Extend the shorter list with repeats of this point
           let point = shortList[0].point
           let curve = SomeCubicCurve(point: point, control1: point, control2: point)
           for _ in(shortList.count..<longList.count) {
               shortList.append(curve)
           }
       }

       fileprivate static func equalizeArrays(_ lhs: SomeCubicCurveList, _ rhs: SomeCubicCurveList) -> ([SomeCubicCurve], [SomeCubicCurve]) {
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

       public static func - (lhs: SomeCubicCurveList, rhs: SomeCubicCurveList) -> SomeCubicCurveList {
           // Ensure the shapes have the same number of curves
           let lists = equalizeArrays(lhs, rhs)
           let result = zip(lists.0, lists.1).map(-)
           return SomeCubicCurveList(values: result)
       }

       public static func -= (lhs: inout SomeCubicCurveList, rhs: SomeCubicCurveList) {
           lhs = lhs - rhs
       }

       public static func + (lhs: SomeCubicCurveList, rhs: SomeCubicCurveList) -> SomeCubicCurveList {
           // Ensure the shapes have the same number of curves
           let lists = equalizeArrays(lhs, rhs)
           let result = zip(lists.0, lists.1).map(+)
           return SomeCubicCurveList(values: result)
       }

       public static func += (lhs: inout SomeCubicCurveList, rhs: SomeCubicCurveList) {
           lhs = lhs + rhs
       }
}
