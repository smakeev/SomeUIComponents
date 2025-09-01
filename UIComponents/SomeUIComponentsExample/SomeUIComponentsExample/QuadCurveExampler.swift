//
//  QuadCurveExampler.swift
//  SomeUIComponentsExample
//
//  Created by Sergey Makeev on 04.11.2024.
//

import SwiftUI
import SomeUIComponents

struct QuadCurveExampler: View {

    @State private var changeCurve = true
    let quadCurve1 = SomeAnimatableQuadCurve(
            start: CGPoint(x: 0.2, y: 0.8),
            end: CGPoint(x: 0.8, y: 0.9),
            control: CGPoint(x: 0.5, y: 0.2))

        let quadCurve2 = SomeAnimatableQuadCurve(
            start: CGPoint(x: 0.1, y: 0.2),
            end: CGPoint(x: 0.9, y: 0.2),
            control: CGPoint(x: 0.6, y: 1.2))
    var body: some View {
        VStack {
            VStack(spacing:50) {
                       Text("Animatable Quadratic Curve")

                SomeQuadCurveShape(curve: changeCurve ? quadCurve1 : quadCurve2)
                                .stroke(changeCurve ? Color(.red) : .purple, lineWidth: 4.0)
                                .frame(width: 450, height: 250)
                                .animation(.linear(duration: 1))
                       Button("Change Curve") {
                           changeCurve.toggle()
                       }
                       .buttonStyle(BlueButtonStyle())

                       Spacer()
                   }
        }
    }
}

struct DiamondView: View {
    @State private var index = 0

    let colors:[Color] = [.red, .orange, .yellow, .green]
    let diamond = [
        SomeAnimatableQuadCurve(start: CGPoint(x: 0.5, y: 0.0), end: CGPoint(x: 1.0, y: 0.5), control: CGPoint(x: 0.6, y: 0.4)),
        SomeAnimatableQuadCurve(start: CGPoint(x: 1.0, y: 0.5), end: CGPoint(x: 0.5, y: 1.0), control: CGPoint(x: 0.6, y: 0.6)),
        SomeAnimatableQuadCurve(start: CGPoint(x: 0.5, y: 1.0), end: CGPoint(x: 0.0, y: 0.5), control: CGPoint(x: 0.4, y: 0.6)),
        SomeAnimatableQuadCurve(start: CGPoint(x: 0.0, y: 0.5), end: CGPoint(x: 0.5, y: 0.0), control: CGPoint(x: 0.4, y: 0.4))
    ]

    var body: some View {
        VStack(spacing:50) {
            Text("Animatable Diamond Shape")

            ZStack {
                ForEach(0..<diamond.count) { i in
                    SomeQuadCurveShape(curve: diamond[(i+index)%diamond.count])
                        .stroke(colors[index], lineWidth: 8.0)
                }
            }
            .frame(width: 300, height: 300)
            .animation(.linear(duration: 1))

            Button("Change") {
                self.index = (self.index + 1) % diamond.count
            }
            .buttonStyle(BlueButtonStyle())

            Spacer()
        }
    }
}

struct ShapeChangeView: View {
    @State private var shapeIndex = 0
    @State private var colorIndex = 0
    @State private var index1 = 0
    @State private var index2 = 0

    let colors:[Color] = [.red, .orange, .yellow, .green, .blue, .purple]
    let shapes = [[
        SomeAnimatableQuadCurve(start: CGPoint(x: 0.5, y: 0.0), end: CGPoint(x: 1.0, y: 0.5), control: CGPoint(x: 0.6, y: 0.4)),
        SomeAnimatableQuadCurve(start: CGPoint(x: 1.0, y: 0.5), end: CGPoint(x: 0.5, y: 1.0), control: CGPoint(x: 0.6, y: 0.6)),
        SomeAnimatableQuadCurve(start: CGPoint(x: 0.5, y: 1.0), end: CGPoint(x: 0.0, y: 0.5), control: CGPoint(x: 0.4, y: 0.6)),
        SomeAnimatableQuadCurve(start: CGPoint(x: 0.0, y: 0.5), end: CGPoint(x: 0.5, y: 0.0), control: CGPoint(x: 0.4, y: 0.4))
    ],
    [
        SomeAnimatableQuadCurve(start: CGPoint(x: 0.5, y: 0.0), end: CGPoint(x: 1.0, y: 0.5), control: CGPoint(x: 0.75, y: 0.25)),
        SomeAnimatableQuadCurve(start: CGPoint(x: 1.0, y: 0.5), end: CGPoint(x: 0.5, y: 1.0), control: CGPoint(x: 0.75, y: 0.75)),
        SomeAnimatableQuadCurve(start: CGPoint(x: 0.5, y: 1.0), end: CGPoint(x: 0.0, y: 0.5), control: CGPoint(x: 0.25, y: 0.75)),
        SomeAnimatableQuadCurve(start: CGPoint(x: 0.0, y: 0.5), end: CGPoint(x: 0.5, y: 0.0), control: CGPoint(x: 0.25, y: 0.25))
    ],
    [
        SomeAnimatableQuadCurve(start: CGPoint(x: 0.5, y: 0.0), end: CGPoint(x: 1.0, y: 0.5), control: CGPoint(x: 1.0, y: 0.0)),
        SomeAnimatableQuadCurve(start: CGPoint(x: 1.0, y: 0.5), end: CGPoint(x: 0.5, y: 1.0), control: CGPoint(x: 1.0, y: 1.0)),
        SomeAnimatableQuadCurve(start: CGPoint(x: 0.5, y: 1.0), end: CGPoint(x: 0.0, y: 0.5), control: CGPoint(x: 0.0, y: 1.0)),
        SomeAnimatableQuadCurve(start: CGPoint(x: 0.0, y: 0.5), end: CGPoint(x: 0.5, y: 0.0), control: CGPoint(x: 0.0, y: 0.0))
    ]]

    var body: some View {
        VStack(spacing:120) {
            Text("Animatable Quadratic Curve")

            HStack(spacing:50) {
                ZStack {
                    ForEach(0..<4) { i in
                        SomeQuadCurveShape(curve: shapes[shapeIndex][i])
                            .stroke(colors[colorIndex], lineWidth: 6.0)
                    }
                }
                .frame(width: 250, height: 250)
                .animation(.linear(duration: 1))

                ZStack {
                    ForEach(0..<4) { i in
                        SomeQuadCurveShape(curve: shapes[shapeIndex][(i+index1)%4])
                            .stroke(colors[colorIndex], lineWidth: 6.0)
                    }
                }
                .frame(width: 250, height: 250)
                .animation(.linear(duration: 1))

                ZStack {
                    ForEach(0..<4) { i in
                        SomeQuadCurveShape(curve: shapes[shapeIndex][(i+index2)%4])
                            .stroke(colors[colorIndex], lineWidth: 6.0)
                    }
                }
                .frame(width: 250, height: 250)
                .animation(.linear(duration: 1))
            }

            Button("Change") {
                self.shapeIndex = (self.shapeIndex + 1) % self.shapes.count
                self.colorIndex = (self.colorIndex + 1) % self.colors.count
                self.index1 = (self.index1 + 1) % 4
                self.index2 = (self.index2 + 2) % 4
            }
            .buttonStyle(BlueButtonStyle())

            Spacer()
        }
    }
}

struct QuadCurveExampler_Previews: PreviewProvider {
    static var previews: some View {
        //QuadCurveExampler()
        //DiamondView()
        ShapeChangeView()
    }
}
