//
//  Color.swift
//  SomeUIComponents
//
//  Created by Sergey Makeev on 02.11.2024.
//

import SwiftUI

public extension Color {
    public static func random() -> Color {
        let red = Double.random(in: 0...1)
        let green = Double.random(in: 0...1)
        let blue = Double.random(in: 0...1)
        return Color(red: red, green: green, blue: blue)
    }
}
