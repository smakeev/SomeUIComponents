//
//  LineListExampler.swift
//  SomeUIComponentsExample
//
//  Created by Sergey Makeev on 09.11.2024.
//

import SwiftUI
import SomeUIComponents

struct PointsListExampler: View {

    @State private var changeShape = true

    let line1 = [CGPoint(x: 0, y: 1), CGPoint(x: 0.2, y: 0.2), CGPoint(x: 0.3, y: 1), CGPoint(x: 0.4, y: 0.8), CGPoint(x: 0.5, y: 0.1), CGPoint(x: 0.6, y: 0.7), CGPoint(x: 0.7, y: 0.1), CGPoint(x:0.8, y: 0.5), CGPoint(x: 0.9, y: 0.2), CGPoint(x: 1, y: 0.8)]
    let line2 = [CGPoint(x: 0, y:0.3), CGPoint(x: 0.2, y: 0.9), CGPoint(x: 0.4, y: 0.9), CGPoint(x: 0.6, y: 0.8), CGPoint(x:0.8, y: 0.7), CGPoint(x: 1, y: 0.3)]

    var body: some View {
        VStack {
            Text("Animated Lines")
            SomePointsListShape(points: changeShape ? line1 : line2)
                .stroke(changeShape ? Color.blue : .red, lineWidth: 4.0)
                .frame(width: 350, height: 420)
                .animation(.easeInOut(duration: 2))

            Button("Change") {
                self.changeShape.toggle()
            }
            .buttonStyle(BlueButtonStyle())
            
            Spacer()
        }
    }

}

struct LineListExampler_Previews: PreviewProvider {
    static var previews: some View {
        PointsListExampler()
    }
}
