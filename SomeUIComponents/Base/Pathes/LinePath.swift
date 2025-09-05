//
//  LinePath.swift
//  SomeUIComponents
//
//  Created by Sergey Makeev on 02.11.2024.
//

import SwiftUI
import CoreText

public func SomeLinePath(start: CGPoint, end: CGPoint, in rect: CGRect) -> Path {
    Path { path in
        // Ensure the start and end points are within the rect bounds
        let clampedStart = CGPoint(
            x: max(rect.minX, min(start.x, rect.maxX)),
            y: max(rect.minY, min(start.y, rect.maxY))
        )
        let clampedEnd = CGPoint(
            x: max(rect.minX, min(end.x, rect.maxX)),
            y: max(rect.minY, min(end.y, rect.maxY))
        )

        // Move to the start point
        path.move(to: clampedStart)

        // Add a line to the end point
        path.addLine(to: clampedEnd)
    }
}

// y = k*x + b
public func SomeLinePath(k: Double, b: Double, in rect: CGRect) -> Path {
    Path { path in
        // Calculate intersection points with the rectangle
        var points: [CGPoint] = []

        // Check intersection with left edge (x = rect.minX)
        let yAtMinX = k * rect.minX + b
        if yAtMinX >= rect.minY && yAtMinX <= rect.maxY {
            points.append(CGPoint(x: rect.minX, y: yAtMinX))
        }

        // Check intersection with right edge (x = rect.maxX)
        let yAtMaxX = k * rect.maxX + b
        if yAtMaxX >= rect.minY && yAtMaxX <= rect.maxY {
            points.append(CGPoint(x: rect.maxX, y: yAtMaxX))
        }

        // Check intersection with top edge (y = rect.minY)
        if k != 0 { // Avoid division by zero
            let xAtMinY = (rect.minY - b) / k
            if xAtMinY >= rect.minX && xAtMinY <= rect.maxX {
                points.append(CGPoint(x: xAtMinY, y: rect.minY))
            }
        }

        // Check intersection with bottom edge (y = rect.maxY)
        if k != 0 { // Avoid division by zero
            let xAtMaxY = (rect.maxY - b) / k
            if xAtMaxY >= rect.minX && xAtMaxY <= rect.maxX {
                points.append(CGPoint(x: xAtMaxY, y: rect.maxY))
            }
        }

        // Ensure we have exactly two points to define the line segment
        if points.count >= 2 {
            path.move(to: points[0])
            path.addLine(to: points[1])
        }
    }
}
