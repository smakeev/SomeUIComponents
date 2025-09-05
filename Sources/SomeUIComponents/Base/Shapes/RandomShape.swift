//
//  RandomShape.swift
//  SomeUIComponents
//
//  Created by Sergey Makeev on 02.11.2024.
//

import SwiftUI

public struct SomeRandomShape: Shape, SomeUIComponent {

    private var SidesDouble: Double

    public var animatableData: Double {
        get { return SidesDouble }
        set { SidesDouble = newValue }
    }

    public enum RandomType : Sendable{
        case straight
        case regular
        case irregular
        case quadratic
        case cubic
        case cubic2
    }

    var type: RandomType
    var numberOfPoints: Int

    public init(numberOfPoints: Int, type: RandomType) {
        self.numberOfPoints = numberOfPoints
        self.type = type
        self.SidesDouble = Double(numberOfPoints)
    }

    public func path(in rect: CGRect) -> Path {
        switch type {
        case .straight:
            return straightPath(in: rect)
        case .regular:
            return regularPath(in: rect)
        case .irregular:
            return irregularPath(in: rect)
        case .quadratic:
            return quadraticPath(in: rect)
        case .cubic:
            return cubicPath(in: rect)
        case .cubic2:
            return cubic2Path(in: rect)
        }
        
    }

    private func cubic2Path(in rect: CGRect) -> Path {
        let sides = numberOfPoints
        let c = CGPoint(x: rect.width/2.0, y: rect.height/2.0)
              let r = Double(min(rect.width,rect.height)) / 2.0
              let segments = CreateRandomShape3(
                  sides: sides,
                  radius: r,
                  center: c)
              var path = Path()
              path.move(to: segments[0].point)
              for i in 1..<segments.count {
                  path.addCurve(to: segments[i].point,
                                control1: segments[i].control1,
                                control2: segments[i].control2)
              }
              path.closeSubpath()
              return path
    }
    
    private func cubicPath(in rect: CGRect) -> Path {
        let sides = numberOfPoints
        let c = CGPoint(x: rect.width/2.0, y: rect.height/2.0)
        let r = Double(min(rect.width,rect.height)) / 2.0
        let segments = CreateRandomShape2(
            sides: sides,
            radius: r,
            center: c)
        var path = Path()
        path.move(to: segments[0].point)
        for i in 1..<segments.count {
            path.addCurve(to: segments[i].point,
                          control1: segments[i].control1,
                          control2: segments[i].control2)
        }
        path.closeSubpath()
        return path
    }
    private func quadraticPath(in rect: CGRect) -> Path {
        let sides = numberOfPoints
        let c = CGPoint(x: rect.width/2.0, y: rect.height/2.0)
                let r = Double(min(rect.width,rect.height)) / 2.0
                let segments = CreateRandomShape(
                    sides: sides,
                    radius: r,
                    center: c)

                var path = Path()
                for (n, seg) in segments.enumerated() {
                    n == 0 ? path.move(to: seg.point) : path.addQuadCurve(to: seg.point, control: seg.control)
                }
        path.closeSubpath()
        return path
    }

    private func irregularPath(in rect: CGRect) -> Path {
        let sides = numberOfPoints
        let c = CGPoint(x: rect.width/2.0, y: rect.height/2.0)
             let r = Double(min(rect.width,rect.height)) / 2.0
             let vertices = CreateRandomPolygon(
                 sides: sides,
                 radius: r,
                 center: c)
             var path = Path()
             for (n, pt) in vertices.enumerated() {
                 n == 0 ? path.move(to: pt) : path.addLine(to: pt)
             }
             path.closeSubpath()
             return path
    }

    private func regularPath(in rect: CGRect) -> Path {
        let sides = Double(Int.random(in: 1...numberOfPoints))
        let c = CGPoint(x: rect.width / 2.0, y: rect.height / 2.0)
        // radius of a circle that will fit in the rect
        let r = Double(min(rect.width,rect.height)) / 2.0
        let offsetAngle = (Double.pi / Double(sides)) + Double.pi / 2.0
        var vertices:[CGPoint] = []

        let endAngle: Int = Double(sides) > Double(Int(sides)) ? Int(sides) + 1 : Int(sides)
        for i in 0..<endAngle{
            // Calculate the angle in Radians
            let angle = (2.0 * Double.pi * Double(i) / Double(sides)) + offsetAngle
            let pt = SomeCartesian(length: r, angle: angle)
            // move the point to the center of the rect and add to vertices
            vertices.append(CGPoint(x: pt.x + c.x, y: pt.y + c.y))
        }

        var path = Path()
        for (n, pt) in vertices.enumerated() {
            n == 0 ? path.move(to: pt) : path.addLine(to: pt)
        }
        path.closeSubpath()
        return path
    }

    private func straightPath(in rect: CGRect) -> Path {
        let size = min(rect.width, rect.height)
        let xOffset = (rect.width > rect.height) ? (rect.width - rect.height) / 2.0 : 0.0
        let yOffset = (rect.height > rect.width) ? (rect.height - rect.width) / 2.0 : 0.0

        func offsetPoint(p: CGPoint) -> CGPoint {
            return CGPoint(x: p.x + xOffset, y: p.y + yOffset)
        }

        var path = Path()

        let x1 = Double.random(in: 1.0...Double(size))
        let y1 = Double.random(in: 1.0...Double(size))
        path.move(to: offsetPoint(p: (CGPoint(x: x1, y: y1))))

        for _ in 0...numberOfPoints {
            let x = Double.random(in: 0.0...Double(size))
            let y = Double.random(in: 0.0...Double(size))
            path.addLine(to: offsetPoint(p: (CGPoint(x: x, y: y))))
        }
        path.closeSubpath()

        return path
    }
}

extension SomeRandomShape {

    fileprivate struct CubicSegment {
        let point: CGPoint
        let control1: CGPoint
        let control2: CGPoint
    }

    fileprivate struct Segment {
        public let point: CGPoint
        public let control: CGPoint

        public init(point: CGPoint, control: CGPoint) {
            self.point = point
            self.control = control
        }
    }

    fileprivate func CreateRandomShape(sides:Int, radius r: Double, center c: CGPoint) -> [Segment] {
        var segments:[Segment] = []

        let segmentAngle = 2.0 * Double.pi / Double(sides)
        for i in 0..<sides {
            let angle = segmentAngle * Double(i)
            let radius = r * Double.random(in: 0.7...1.0)
            let pt = SomeCartesian(length: radius, angle: angle)

            let ctlAngle = angle - (segmentAngle * Double.random(in: 0.3...0.8))
            let distance = i%2==0 ? radius*0.3 : radius*1.2
            let ctl = SomeCartesian(length: distance, angle: ctlAngle)
            let s:Segment = Segment(point: CGPoint(x: pt.x + c.x, y: pt.y + c.y),
                                    control: CGPoint(x: ctl.x + c.x, y: ctl.y + c.y))
            segments.append(s)
        }
        segments.append(segments[0])
        return segments
    }

    fileprivate func CreateRandomShape2(sides:Int, radius r: Double, center c: CGPoint) -> [CubicSegment] {
        var segments:[CubicSegment] = []

        let segmentAngle = 2.0 * Double.pi / Double(sides)
        for i in 0..<sides {
            let angle = segmentAngle * Double(i)
            let radius = i%2==0 ? r * Double.random(in: 0.45...0.55) : r * Double.random(in: 0.75...0.8)
            let pt = SomeCartesian(length: radius, angle: angle)

            let ctlAngle = angle - (segmentAngle * Double.random(in: 0.75...0.85))
            let distance = radius * Double.random(in: 0.5...1.2)
            let ctl = SomeCartesian(length: distance, angle: ctlAngle)

            let ctlAngle2 = angle - (segmentAngle * Double.random(in: 0.15...0.35))
            let distance2 = radius * Double.random(in: 0.5...1.2)
            let ctl2 = SomeCartesian(length: distance2, angle: ctlAngle2)

            let s:CubicSegment = CubicSegment(point: CGPoint(x: pt.x + c.x, y: pt.y + c.y),
                                              control1: CGPoint(x: ctl.x + c.x, y: ctl.y + c.y),
                                              control2: CGPoint(x: ctl2.x + c.x, y: ctl2.y + c.y))
            segments.append(s)
        }
        segments.append(segments[0])
        return segments
    }

    fileprivate func CreateRandomShape3(sides:Int, radius r: Double, center c: CGPoint) -> [CubicSegment] {
        var segments:[CubicSegment] = []

        let sectorAngle = 2.0 * Double.pi / Double(sides)
        var previousSectorIn = true
        for i in 0..<sides {
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

            let s:CubicSegment = CubicSegment(point: CGPoint(x: pt.x + c.x, y: pt.y + c.y),
                                              control1: CGPoint(x: ctl1.x + c.x, y: ctl1.y + c.y),
                                              control2: CGPoint(x: ctl2.x + c.x, y: ctl2.y + c.y))
            segments.append(s)
        }
        segments.append(segments[0])
        return segments
    }

    fileprivate func CreateRandomPolygon(sides:Int,
                                         radius r: Double,
                                         center c: CGPoint) -> [CGPoint] {
        var vertices:[CGPoint] = []
        for i in 0..<sides {
            let angle = (2.0 * Double.pi * Double(i)/Double(sides))
            let radius = Double.random(in: r/3.0...r)
            let pt = SomeCartesian(length: radius, angle: angle)
            // Move the point relative to the center of the rect and add to vertices
            vertices.append(CGPoint(x: pt.x + c.x, y: pt.y + c.y))
        }
        vertices.append(vertices[0])
        return vertices
    }
}

struct SomeRandomShape_Previews: PreviewProvider {
    static var previews: some View {
        @State var animated: Bool = false
        SomeRandomShape(numberOfPoints: 10, type: .regular)
        .fill().frame(width: 300, height: 300)
    }
}
