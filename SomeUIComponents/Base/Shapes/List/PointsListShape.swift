//
//  LineListShape.swift
//  SomeUIComponents
//
//  Created by Sergey Makeev on 09.11.2024.
//

import SwiftUI

public struct SomePointsListShape: Shape, SomeUIComponent {
    var points: [CGPoint] {
        didSet {
            print("!!!!!!!!! \(points)")
        }
    }

    public var animatableData: SomeAnimatablePointsListCurve {
        get { SomeAnimatablePointsListCurve(values: points) }
        set { points = newValue.values}
        
    }

    public init(points: [CGPoint]) {
        self.points = points
    }

    public func path(in rect: CGRect) -> Path {
        var path = Path()
        path.move(to: CGPoint(x: points[0].x * Double(rect.width), y: points[0].y * Double(rect.height)))
        for i in 1..<points.count {
            let pt = CGPoint(x: (points[i].x * Double(rect.width)), y: (points[i].y * Double(rect.height)))
            path.addLine(to: pt)
        }
        return path
    }
}
