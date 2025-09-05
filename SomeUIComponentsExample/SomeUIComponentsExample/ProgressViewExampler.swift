//
//  ProgressViewExampler.swift
//  SomeUIComponentsExample
//
//  Created by Sergey Makeev on 01.11.2024.
//

import SwiftUI
import SomeUIComponents

struct ProgressViewExampler: View {
    @State private var trimFrom: CGFloat = 0.0
    @State private var trimTo: CGFloat = 1

    var body: some View {
        VStack {
            SomeProgressView(progressPath: SomeTextPath(string: "Hello, SwiftUI!", textStyle: .title),
                             overlayView: SomeTextPath(string: "Hello, SwiftUI!", textStyle: .title).stroke(Color.black, lineWidth: 2),
                             pathStyle: LinearGradient(
                                gradient: Gradient(colors: [.blue, .green]),
                                startPoint: .topLeading,
                                endPoint: .bottomTrailing),
                             lineWidth: 5,
                             from: $trimFrom,
                             to: $trimTo
            ).background(Color.green)

            SomeProgressView(progressPath: SomeTextPath(string: "Hello, SwiftUI!", textStyle: .title),
                             pathStyle: LinearGradient(
                                gradient: Gradient(colors: [.red, .green]),
                                startPoint: .topLeading,
                                endPoint: .bottomTrailing),
                             lineWidth: 5,
                             from: $trimFrom,
                             to: $trimTo
            ) {
                TextPathExampler()
            }.background(Color.blue)

        }
    }
}

struct ProgressViewExampler_Previews: PreviewProvider {
    static var previews: some View {
        ProgressViewExampler()
    }
}
