//
//  QuadCurveShape.swift
//  SomeUIComponents
//
//  Created by Sergey Makeev on 04.11.2024.
//

import SwiftUI

public struct SomeQuadCurveShape: Shape, SomeUIComponent {

    var startPoint: CGPoint
    var endPoint: CGPoint
    var controlPoint: CGPoint

    private var animatableSegment: SomeAnimatableQuadCurve

    public var animatableData: SomeAnimatableQuadCurve {
        get { SomeAnimatableQuadCurve(
            start: startPoint, end: endPoint, control: controlPoint) }
        set {
            startPoint = newValue.start
            endPoint = newValue.end
            controlPoint = newValue.control
        }
    }

    public init(startPoint: CGPoint, endPoint: CGPoint, controlPoint: CGPoint, relative: Bool = true) {
        self.startPoint = startPoint
        self.endPoint = endPoint
        self.controlPoint = controlPoint
        self.animatableSegment = SomeAnimatableQuadCurve(
            start: startPoint,
            end: endPoint,
            control: controlPoint)
    }

    public init(curve: SomeAnimatableQuadCurve, relative: Bool = true) {
        self.init(startPoint: curve.start, endPoint: curve.end, controlPoint: curve.control, relative: relative)
    }

    public func path(in rect: CGRect) -> Path {
        let start = CGPoint(x: startPoint.x * rect.width,
                            y: startPoint.y * rect.height)
        let end = CGPoint(x: endPoint.x * rect.width,
                          y: endPoint.y * rect.height)
        let control = CGPoint(x: controlPoint.x * rect.width,
                              y: controlPoint.y * rect.height)
        var path = Path()
        path.move(to: start)
        path.addQuadCurve(to: end, control: control)
        return path
    }
}

struct SomeQuadCurveShape_Previews: PreviewProvider {
    static var previews: some View {
        SomeQuadCurveShape(startPoint: CGPoint(x: 0.2, y: 0.8), endPoint: CGPoint(x: 0, y: 1), controlPoint: CGPoint(x: 0.5, y: 0.2)).stroke(lineWidth: 15)
        .frame(width: 300, height: 300)
    }
}
