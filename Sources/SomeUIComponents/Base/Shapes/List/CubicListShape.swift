//
//  CubicListShape.swift
//  SomeUIComponents
//
//  Created by Sergey Makeev on 09.11.2024.
//

import SwiftUI

public struct SomeCubicListShape: Shape, SomeUIComponent {
    var curves:[SomeCubicCurve]

      public var animatableData: SomeCubicCurveList {
          get { SomeCubicCurveList(values: curves) }
          set { curves = newValue.values }
      }

    public init(curves: [SomeCubicCurve]) {
        self.curves = curves
    }

    public func path(in rect: CGRect) -> Path {
          func adjustPoint(p: CGPoint) -> CGPoint {
              return CGPoint(x: p.x * rect.width, y: p.y * rect.height)
          }

          var path = Path()
          path.move(to: adjustPoint(p: curves[0].point))
          for i in 1..<curves.count {
              path.addCurve(to: adjustPoint(p: curves[i].point),
                            control1: adjustPoint(p: curves[i].control1),
                            control2: adjustPoint(p: curves[i].control2))
          }
          path.closeSubpath()
          return path
      }
}
