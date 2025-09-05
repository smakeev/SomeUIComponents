//
//  RoundedRectExampler.swift
//  SomeUIComponentsExample
//
//  Created by Sergey Makeev on 02.11.2024.
//

import SwiftUI
import SomeUIComponents

struct RoundedRectExampler: View {
    @State var rounded: Bool = false

    var body: some View {
        VStack {
            SomeRooundedCornersShape(cornerRadiusLT: rounded ? 100 : 0,
                                     cornerRadiusRT: rounded ? 40 : 0,
                                     cornerRadiusLB: rounded ? 90 : 0,
                                     cornerRadiusRB: rounded ? 140 : 0
            )
            .fill().frame(width: 300, height: 300)
            Button("Animate") {
                withAnimation(.linear(duration: 1.0)) {
                    rounded.toggle()
                }
            }
        }
    }
}

struct RoundedRectExampler_Previews: PreviewProvider {
    static var previews: some View {
        RoundedRectExampler()
    }
}
