//
//  UnequalSegmentsExampler.swift
//  SomeUIComponentsExample
//
//  Created by Sergey Makeev on 10.11.2024.
//

import SwiftUI
import SomeUIComponents

struct UnequalSegmentsView: View {
    @State private var changeShape = true

    let shape1 = SomeRandomCubicCurveList(segments: 8)
    let shape2 = SomeRandomCubicCurveList(segments: 12)

    var body: some View {
        VStack {
            Text("Shape Change - Unequal Segments")

            SomeCubicListShape(curves: changeShape ? shape1 : shape2)
                .stroke(changeShape ? Color.blue : .red, lineWidth: 3.0)
                .frame(width: 200, height: 200)
                .animation(.easeInOut(duration: 2))

            SomeCubicListShape(curves: changeShape ? shape1 : shape2)
                .fill(changeShape ? Color.green : .yellow)
                .frame(width: 200, height: 200)
                .animation(.easeInOut(duration: 2))

            Button("Change") {
                self.changeShape.toggle()
            }
            .buttonStyle(BlueButtonStyle())

            Spacer()
        }
    }
}

struct UnequalSegmentsView_Previews: PreviewProvider {
    static var previews: some View {
        UnequalSegmentsView()
    }
}
