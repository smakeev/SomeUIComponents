//
//  RegularPolygonShape.swift
//  SomeUIComponents
//
//  Created by Sergey Makeev on 02.11.2024.
//

import SwiftUI

public struct SomeRegularPolygonShape: Shape, SomeUIComponent {
    var sides:Int

    private var SidesDouble: Double

    public var animatableData: Double {
        get { return SidesDouble }
        set { SidesDouble = newValue }
    }

    public init(sides: Int) {
         self.sides = sides
         self.SidesDouble = Double(sides)
     }

    public func path(in rect: CGRect) -> Path {
        // centre of the containing rect
        let c = CGPoint(x: rect.width / 2.0, y: rect.height / 2.0)
        // radius of a circle that will fit in the rect
        let r = Double(min(rect.width,rect.height)) / 2.0
        let offsetAngle = (Double.pi / Double(SidesDouble)) + Double.pi / 2.0
        var vertices:[CGPoint] = []

        let endAngle: Int = Double(SidesDouble) > Double(Int(SidesDouble)) ? Int(SidesDouble) + 1 : Int(SidesDouble)
        for i in 0..<endAngle{
            // Calculate the angle in Radians
            let angle = (2.0 * Double.pi * Double(i) / Double(SidesDouble)) + offsetAngle
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
}

struct SomeRegularPolygonShape_Previews: PreviewProvider {
    static var previews: some View {
        @State var animated: Bool = false
        SomeRegularPolygonShape(sides: 5)
        .fill().frame(width: 300, height: 300)
    }
}
