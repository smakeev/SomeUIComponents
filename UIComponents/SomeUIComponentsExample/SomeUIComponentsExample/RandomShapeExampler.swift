//
//  RandomShapeExampler.swift
//  SomeUIComponentsExample
//
//  Created by Sergey Makeev on 02.11.2024.
//

import SwiftUI
import SomeUIComponents

struct RandomShapeExampler: View {
    
    @State private var sides = 3

    var body: some View {
        VStack() {
            SomeRandomShape(numberOfPoints: sides, type: .regular)
                .stroke(Color.red, lineWidth: 10)
                .onTapGesture{
                    withAnimation(.linear) {
                        sides += 1
                    }
                }
        }
        .padding(5)
        .frame(width: 100, height: 100)
        
        Spacer()
    }
}

struct RandomShapeExamplerExampler_Previews: PreviewProvider {
    static var previews: some View {
        RandomShapeExampler()
    }
}
