//
//  CubicCurveExampler.swift
//  SomeUIComponentsExample
//
//  Created by Sergey Makeev on 09.11.2024.
//

import SwiftUI
import SomeUIComponents

struct CubicCurveExampler: View {
    @State private var changeCurve = true
        
    let segment1 = SomeAnimatableCubicCurve(
            start: CGPoint(x: 0.8, y: 0.0),
            end: CGPoint(x: 0.2, y: 1.0),
            control1: CGPoint(x: 0.1, y: 0.25),
            control2: CGPoint(x: 0.9, y: 0.75)
        )
    let segment2 = SomeAnimatableCubicCurve(
            start: CGPoint(x: 0.2, y: 0.9),
            end: CGPoint(x: 0.9, y: 0.7),
            control1: CGPoint(x: 1.0, y: 1.0),
            control2: CGPoint(x: 0.0, y: 0.0)
        )
        
        var body: some View {
            VStack(spacing:30) {
                Text("Animatable Cubic Curve")
                
                SomeCubicCurveShape(curve: changeCurve ? segment1 : segment2)
                    .stroke(changeCurve ? Color(.purple) : .orange, lineWidth: 4.0)
                    .frame(width: 250, height: 250)
                    .animation(.linear(duration: 1))
                
                Button("Change") {
                    changeCurve.toggle()
                }
                .buttonStyle(BlueButtonStyle())
                
                Spacer()
            }
        }
   
}

struct curves {
    static let segments = createSegments()
    static func createSegments() -> [SomeAnimatableCubicCurve] {
        var segs = [SomeAnimatableCubicCurve]()
        for i in (0...5) {
            let seg = SomeAnimatableCubicCurve(
                start: CGPoint(x: 0.0 + (0.2 * Double(i)), y: 0.0 + (0.2 * Double(i))),
                end: CGPoint(x: 1.0 - (0.2 * Double(i)), y: 1.0 - (0.2 * Double(i))),
                control1: CGPoint(x: 0.0, y: 0.0 + (0.2 * Double(i))),
                control2: CGPoint(x: 1.0, y: 1.0 - (0.2 * Double(i))))
            segs.append(seg)
        }
        for i in (0...5) {
            let seg = SomeAnimatableCubicCurve(
                start: CGPoint(x: 1.0, y: 1.0 - (0.2 * Double(i))),
                end: CGPoint(x: 0.0, y: 0.0 + (0.2 * Double(i))),
                control1: CGPoint(x: 1.0 - (0.2 * Double(i)), y: 1.0 - (0.2 * Double(i))),
                control2: CGPoint(x: 1.0 - (0.2 * Double(i)), y: 0.0 + (0.2 * Double(i))))
            segs.append(seg)
        }
        return segs
    }
}

struct CurveView2: View {
    @State private var index = 0
    @State private var counter = 0
    
    let timer = Timer.publish(every: 1,
                              on: .main,
                              in: .common)
        .autoconnect()
    let colors:[Color] = [.red, .orange, .yellow, .green, .blue, .purple]
    let segments = curves.segments
    
    var body: some View {
        VStack(spacing:30) {
            Text("Animatable Cubic Curve")
            
            SomeCubicCurveShape(curve: segments[index])
                .stroke(colors[index % colors.count], lineWidth: 4.0)
                .frame(width: 250, height: 300)
                .animation(.linear(duration: 1))
                .onReceive(timer) { time in
                    if self.counter == (segments.count * 3) {
                        self.timer.upstream.connect().cancel()
                    } else {
                        self.index = (self.index + 1) % segments.count
                    }
                    
                    self.counter += 1
                }
            
            Spacer()
        }
    }
}

struct CubicCurveExampler_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            CurveView2()
            CubicCurveExampler()
        }
    }
}
