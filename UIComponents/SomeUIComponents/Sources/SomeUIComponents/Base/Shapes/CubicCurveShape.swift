//
//  CubicCurveShape.swift
//  SomeUIComponents
//
//  Created by Sergey Makeev on 09.11.2024.
//


import SwiftUI

public struct SomeCubicCurveShape: Shape, SomeUIComponent {

    var startPoint: CGPoint
    var endPoint: CGPoint
    var controlPoint1: CGPoint
    var controlPoint2: CGPoint

    private var animatableSegment: SomeAnimatableCubicCurve

    public
    var animatableData: SomeAnimatableCubicCurve {
        get { SomeAnimatableCubicCurve(
            start: startPoint, end: endPoint, control1: controlPoint1, control2: controlPoint2) }
        set {
            startPoint = newValue.start
            endPoint = newValue.end
            controlPoint1 = newValue.control1
            controlPoint2 = newValue.control2
        }
    }

    public init(startPoint: CGPoint, endPoint: CGPoint, controlPoint1: CGPoint, controlPoint2: CGPoint) {
        self.startPoint = startPoint
        self.endPoint = endPoint
        self.controlPoint1 = controlPoint1
        self.controlPoint2 = controlPoint2
        self.animatableSegment = SomeAnimatableCubicCurve(
            start: startPoint,
            end: endPoint,
            control1: controlPoint1,
            control2: controlPoint2)
    }

    public init(curve: SomeAnimatableCubicCurve) {
        self.init(startPoint: curve.start,
                  endPoint: curve.end,
                  controlPoint1: curve.control1,
                  controlPoint2: curve.control2)
    }

    public func path(in rect: CGRect) -> Path {
        let start = CGPoint(x: startPoint.x * rect.width,
                            y: startPoint.y * rect.height)
        let end = CGPoint(x: rect.width * endPoint.x,
                          y: rect.height * endPoint.y)
        let control1 = CGPoint(x: rect.width * controlPoint1.x,
                               y: rect.height * controlPoint1.y)
        let control2 = CGPoint(x: rect.width * controlPoint2.x,
                               y: rect.height * controlPoint2.y)

        var path = Path()
        path.move(to: start)
        path.addCurve(to: end, control1: control1, control2: control2)
        return path
    }
}

struct SomeCubicCurveShape_Previews: PreviewProvider {
    static var previews: some View {
        SomeCubicCurveShape(startPoint: CGPoint(x: 0, y: 0), endPoint: CGPoint(x:1, y: 1), controlPoint1: CGPoint(x:0.5, y: 0.5), controlPoint2: CGPoint(x: 0.8, y: 0.45))
        .frame(width: 300, height: 300)
    }
}
