//
//  RoundedCornersShape.swift
//  SomeUIComponents
//
//  Created by Sergey Makeev on 02.11.2024.
//

import SwiftUI

public struct SomeRooundedCornersShape: Shape, SomeUIComponent {
    public init(cornerRadiusLT: CGFloat = 0,
                cornerRadiusRT: CGFloat = 0,
                cornerRadiusLB: CGFloat = 0,
                cornerRadiusRB: CGFloat = 0) {

        self.cornerRadiusLT = cornerRadiusLT
        self.cornerRadiusRT = cornerRadiusRT
        self.cornerRadiusLB = cornerRadiusLB
        self.cornerRadiusRB = cornerRadiusRB
    }

    var cornerRadiusLT: CGFloat
    var cornerRadiusRT: CGFloat
    var cornerRadiusLB: CGFloat
    var cornerRadiusRB: CGFloat

    public var animatableData: AnimatablePair<CGFloat, AnimatablePair<CGFloat, AnimatablePair<CGFloat, CGFloat>>> {
              get { AnimatablePair(cornerRadiusLT, AnimatablePair(cornerRadiusRT, AnimatablePair(cornerRadiusLB, cornerRadiusRB))) }
              set {
                  cornerRadiusLT = newValue.first
                  cornerRadiusRT = newValue.second.first
                  cornerRadiusLB = newValue.second.second.first
                  cornerRadiusRB = newValue.second.second.second
              }
          }

    public func path(in rect: CGRect) -> Path {
        Path { path in
                   // Top right corner
                   path.move(to: CGPoint(x: rect.minX + cornerRadiusLT, y: rect.minY))
                   path.addLine(to: CGPoint(x: rect.maxX - cornerRadiusRT, y: rect.minY))
                   path.addLine(to: CGPoint(x: rect.maxX, y: rect.minY + cornerRadiusRT))
                   path.addArc(center: CGPoint(x: rect.maxX - cornerRadiusRT, y: rect.minY + cornerRadiusRT),
                               radius: cornerRadiusRT,
                               startAngle: Angle(degrees: 270),
                               endAngle: Angle(degrees: 0),
                               clockwise: false)

                   // Bottom right corner
                   path.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY - cornerRadiusRB))
                   path.addLine(to: CGPoint(x: rect.maxX - cornerRadiusRB, y: rect.maxY))
                   path.addArc(center: CGPoint(x: rect.maxX - cornerRadiusRB, y: rect.maxY - cornerRadiusRB),
                               radius: cornerRadiusRB,
                               startAngle: Angle(degrees: 0),
                               endAngle: Angle(degrees: 90),
                               clockwise: false)

                   // Bottom left corner
                   path.addLine(to: CGPoint(x: rect.minX + cornerRadiusLB, y: rect.maxY))
                   path.addLine(to: CGPoint(x: rect.minX, y: rect.maxY - cornerRadiusLB))
                   path.addArc(center: CGPoint(x: rect.minX + cornerRadiusLB, y: rect.maxY - cornerRadiusLB),
                               radius: cornerRadiusLB,
                               startAngle: Angle(degrees: 90),
                               endAngle: Angle(degrees: 180),
                               clockwise: false)

                   // top left corner
                   path.addLine(to: CGPoint(x: rect.minX, y: rect.minY + cornerRadiusLT))
                   path.addLine(to: CGPoint(x: rect.minX + cornerRadiusLT, y: rect.minY))
                   path.addArc(center: CGPoint(x: rect.minX + cornerRadiusLT, y: rect.minY + cornerRadiusLT),
                               radius: cornerRadiusLT,
                               startAngle: Angle(degrees: 180),
                               endAngle: Angle(degrees: 270),
                               clockwise: false)
               }
    }
}

struct SomeRooundedCornersShape_Previews: PreviewProvider {
    static var previews: some View {
        @State var animated: Bool = false
        SomeRooundedCornersShape(cornerRadiusLT: 10,
                                 cornerRadiusRT: 40,
                                 cornerRadiusLB: 90,
                                 cornerRadiusRB: 180)
        .fill().frame(width: 300, height: 300)
    }
}
