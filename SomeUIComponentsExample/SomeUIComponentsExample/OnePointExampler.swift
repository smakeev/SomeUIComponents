//
//  OnePointExampler.swift
//  SomeUIComponentsExample
//
//  Created by Sergey Makeev on 04.11.2024.
//

import SwiftUI
import SomeUIComponents

struct OnePointExampler: View {

    @State private var position: CGPoint = CGPoint(x: 0.5, y: 0.5)

    var body: some View {
        VStack {
            SomeOnePointShape(relative: position).stroke(lineWidth: 15)
                .frame(width: 300, height: 300)
            Spacer()
            Button("Change Position") {
                withAnimation(.easeInOut(duration: 1)) {
                    position = CGPoint(x: CGFloat.random(in: 0...1), y: CGFloat.random(in: 0...1))
                }
            }.buttonStyle(BlueButtonStyle())
            Spacer()
        }
    }
}

struct OnePointExampler_Previews: PreviewProvider {
    static var previews: some View {
        OnePointExampler()
    }
}
