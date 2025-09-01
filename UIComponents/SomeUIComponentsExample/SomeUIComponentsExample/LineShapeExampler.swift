//
//  LineShapeExampler.swift
//  SomeUIComponentsExample
//
//  Created by Sergey Makeev on 02.11.2024.
//

import SwiftUI
import SomeUIComponents

struct LineShapeExampler: View {
    @State var state: Bool = false
    @State private var lineParams = (k: CGFloat(-1), b: CGFloat(200))

    @State private var endPoint = CGPoint(x: 200, y: 300)
    @State private var startPoint = CGPointZero

    var body: some View {
        VStack {
            Spacer()
            SomeLineShape(k: lineParams.k, b: lineParams.b).stroke()
                .fill().frame(width: 300, height: 300)
            SomeLineShape(start: startPoint, end: endPoint).stroke()
                .fill().frame(width: 300, height: 300)

            Button("Change Line") {
                withAnimation(.linear(duration: 1.0)) {
                    if state {
                        lineParams = (k: CGFloat(-1), b: CGFloat(200))
                        endPoint = CGPoint(x: 200, y: 300)
                        startPoint = CGPointZero
                    } else {
                        lineParams = (k: CGFloat(-15), b: CGFloat(100))
                        endPoint = CGPoint(x: 0, y: 469)
                        startPoint = CGPoint(x: 500, y: 469)
                    }
                    state.toggle()
                }
            }
            .buttonStyle(BlueButtonStyle())
            
            Spacer()
        }
    }
}

struct LineShapeExampler_Previews: PreviewProvider {
    static var previews: some View {
        LineShapeExampler()
    }
}
