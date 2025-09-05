//
//  OnePointShape.swift
//  SomeUIComponents
//
//  Created by Sergey Makeev on 04.11.2024.
//

import SwiftUI

public struct SomeOnePointShape: Shape, SomeUIComponent {

    var point: CGPoint
    var isRelative = false

    public var animatableData: AnimatablePair<CGFloat, CGFloat> {
        get {AnimatablePair(point.x, point.y) }
        set { point = CGPoint(x: newValue.first, y: newValue.second) }
    }

    public init(absolute point: CGPoint) {
        self.point = point
    }

    public init(relative point: CGPoint) {
        self.point = point
        self.isRelative = true
    }

    public func path(in rect: CGRect) -> Path {
        Path { path in
            let pointToUse = isRelative ? CGPoint(x: point.x * rect.width, y: point.y * rect.height) : point
            path.addEllipse(in: CGRect(origin: pointToUse, size: CGSize(width: 1, height: 1)))
        }
    }
}


struct SomeOnePointShape_Previews: PreviewProvider {
    static var previews: some View {
        SomeOnePointShape(absolute: CGPoint(x: 150, y: 150)).stroke(lineWidth: 15)
        .frame(width: 300, height: 300)
    }
}
