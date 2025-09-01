//
//  LineShape.swift
//  SomeUIComponents
//
//  Created by Sergey Makeev on 02.11.2024.
//

import SwiftUI

public struct SomeLineShape: Shape, SomeUIComponent {

    var start: CGPoint
    var end: CGPoint
    var formula: Bool = false

    private var animatableSegment: SomeAnimatableLineSegment

    public var animatableData: SomeAnimatableLineSegment {
        get { SomeAnimatableLineSegment(startPoint: start, endPoint: end) }
        set {
            start = newValue.startPoint
            end = newValue.endPoint
        }
    }

    public init(start: CGPoint, end: CGPoint) {
        self.start = start
        self.end = end
        self.animatableSegment = SomeAnimatableLineSegment(startPoint: start, endPoint: end)
    }

    public init(k: CGFloat, b: CGFloat) {
        self.start = CGPoint(x: k, y: b)
        self.end = CGPointZero
        formula = true
        self.animatableSegment = SomeAnimatableLineSegment(startPoint: start, endPoint: end)
    }

    public func path(in rect: CGRect) -> Path {
        if formula { return SomeLinePath(k: start.x, b: start.y, in: rect)  }
        return SomeLinePath(start: start, end: end, in: rect)
    }
}

struct SomeLineShape_Previews: PreviewProvider {
    static var previews: some View {
        SomeLineShape(k: -1, b: 100).stroke()
        .fill().frame(width: 300, height: 300)
    }
}
