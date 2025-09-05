//
//  RegularPolygonExampler.swift
//  SomeUIComponentsExample
//
//  Created by Sergey Makeev on 02.11.2024.
//

import SwiftUI
import SomeUIComponents

struct RegularPolygonExampler: View {

    @State private var sides = [3, 4, 5, 6, 7, 8]
    @State private var colors = [Color.red, Color.orange, Color.yellow, Color.green, Color.blue, Color.purple]

    var body: some View {
          VStack {
              Group() {
                  SomeRegularPolygonShape(sides: sides[0])
                      .stroke(colors[0], lineWidth: 10)
                                .onTapGesture{
                                    withAnimation(.linear(duration: 1)) {
                                        self.sides[0] = ((self.sides[0] - 2) % 8) + 3
                                        self.colors[0] = Color.random()
                                    }
                                }
                  SomeRegularPolygonShape(sides: sides[1])
                      .stroke(colors[1], lineWidth: 10)
                                .onTapGesture{
                                    withAnimation(.linear(duration: 1)) {
                                        self.sides[1] = ((self.sides[1] - 2) % 8) + 3
                                        self.colors[1] = Color.random()
                                    }
                                }
                  SomeRegularPolygonShape(sides: sides[2])
                      .stroke(colors[2], lineWidth: 10)
                                .onTapGesture{
                                    withAnimation(.linear(duration: 1)) {
                                        self.sides[2] = ((self.sides[2] - 2) % 8) + 3
                                        self.colors[2] = Color.random()
                                    }
                                }
                  SomeRegularPolygonShape(sides: sides[3])
                      .stroke(colors[3], lineWidth: 10)
                                .onTapGesture{
                                    withAnimation(.linear(duration: 1)) {
                                        self.sides[3] = ((self.sides[3] - 2) % 8) + 3
                                        self.colors[3] = Color.random()
                                    }
                                }
                  SomeRegularPolygonShape(sides: sides[4])
                      .stroke(colors[4], lineWidth: 10)
                                .onTapGesture{
                                    withAnimation(.linear(duration: 1)) {
                                        self.sides[4] = ((self.sides[4] - 2) % 8) + 3
                                        self.colors[4] = Color.random()
                                    }
                                }
                  SomeRegularPolygonShape(sides: sides[5])
                      .stroke(colors[5], lineWidth: 10)
                                .onTapGesture{
                                    withAnimation(.linear(duration: 1)) {
                                        self.sides[5] = ((self.sides[5] - 2) % 8) + 3
                                        self.colors[5] = Color.random()
                                    }
                                }
              }
              .padding(5)
              .frame(width: 100, height: 100)

              Spacer()
          }
      }
}

struct RegularPolygonExampler_Previews: PreviewProvider {
    static var previews: some View {
        RegularPolygonExampler()
    }
}
