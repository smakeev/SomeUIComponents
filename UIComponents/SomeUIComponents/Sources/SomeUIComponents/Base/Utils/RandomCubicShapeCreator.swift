//
//  RandomCubicShapeCreator.swift
//  SomeUIComponents
//
//  Created by Sergey Makeev on 09.11.2024.
//

import Foundation

public func SomeRandomCubicCurveList(segments: Int) -> [SomeCubicCurve] {
    var curves:[SomeCubicCurve] = []

    let r = 0.5
    let c = CGPoint(x: 0.5, y: 0.5)
    let sectorAngle = 2.0 * Double.pi / Double(segments)
    var previousSectorIn = true
    for i in 0..<segments {
        let segmentAngle = sectorAngle * Double.random(in: 0.7...1.3)
        let angle = (sectorAngle * Double(i-0)) + segmentAngle
        let radius = r * Double.random(in: 0.45...0.85)
        let pt = SomeCartesian(length: radius, angle: angle)

        let ctlAngle1 = angle - (segmentAngle * 0.75)
        let ctlDistance1 = previousSectorIn ? radius*1.45 : radius*0.55
        let ctl1 = SomeCartesian(length: ctlDistance1, angle: ctlAngle1)

        let ctlAngle2 = angle - (segmentAngle * 0.25)
        let ctlDistance2 = radius * Double.random(in: 0.55...1.45)
        previousSectorIn = ctlDistance2 < radius
        let ctl2 = SomeCartesian(length: ctlDistance2, angle: ctlAngle2)

        let curve = SomeCubicCurve (
            point: CGPoint(x: pt.x + c.x, y: pt.y + c.y),
            control1: CGPoint(x: ctl1.x + c.x, y: ctl1.y + c.y),
            control2: CGPoint(x: ctl2.x + c.x, y: ctl2.y + c.y))
        curves.append(curve)
    }
    curves.append(curves[0])

    return curves
}
