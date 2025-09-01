//
//  Cartesian.swift
//  SomeUIComponents
//
//  Created by Sergey Makeev on 02.11.2024.
//

import Foundation

func SomeCartesian(length:Double, angle:Double) -> CGPoint {
    return CGPoint(x: length * cos(angle), y: length * sin(angle))
}
