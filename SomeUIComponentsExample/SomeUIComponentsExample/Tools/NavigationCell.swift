//
//  NavigationCell.swift
//  SomeUIComponentsDemo
//
//  Created by Sergey Makeev on 19.09.2025.
//

import SwiftUI

struct NavigationCell: View {
    @GestureState private var isPressed = false
    let text: String
    let accessibilityLabel: String
    let action: () -> Void


    var body: some View {
        Button(action: action) {
            HStack {
                Text(text)
                Spacer()
                Image(systemName: "arrow.right.circle.fill")
                    .foregroundColor(isPressed ? .blue :.gray)
            }
            .padding()
            .contentShape(Rectangle())
            .scaleEffect(isPressed ? 0.97 : 1.0)
            .offset(y: isPressed ? 1.5 : 0)
            .animation(.spring(response: 0.3, dampingFraction: 0.6), value: isPressed)
        }
        .accessibilityIdentifier(accessibilityLabel)
        .simultaneousGesture(
            DragGesture(minimumDistance: 0)
                .updating($isPressed) { _, state, _ in
                    state = true
                }
        )
        .buttonStyle(.plain)
        .listRowBackground(Color.clear)
    }
}
