//
//  SuitChangeExampler.swift
//  SomeUIComponentsExample
//
//  Created by Sergey Makeev on 09.11.2024.
//

import SwiftUI
import SomeUIComponents

struct SuitChangeExampler: View {
    @State private var changeCurve = true
    
    var body: some View {
        VStack(spacing:30) {
            Text("Shape change with Animatable Cubic Curve")
            
            Spacer()
                .frame(height:20)
            
            HStack(spacing:30) {
                ZStack {
                    ForEach(0..<max(SomeSuit.club.count, SomeSuit.spade.count)) { i in
                        SomeCubicCurveShape(curve: changeCurve ? SomeSuit.club[(i % SomeSuit.club.count)] : SomeSuit.spade[(i % SomeSuit.spade.count)])
                            .stroke(changeCurve ? Color(.black) : .blue, lineWidth: 4.0)
                    }
                }
                .frame(width: 150, height: 150)
                .animation(.linear(duration: 1))
                
                ZStack {
                    ForEach(0..<max(SomeSuit.heart.count, SomeSuit.diamond.count)) { i in
                        SomeCubicCurveShape(curve: changeCurve ? SomeSuit.heart[(i % SomeSuit.heart.count)] : SomeSuit.diamond[(i % SomeSuit.diamond.count)])
                            .stroke(changeCurve ? Color(.red) : .orange, lineWidth: 4.0)
                    }
                }
                .frame(width: 150, height: 150)
                .animation(.linear(duration: 1))
                
            }
            
            Spacer()
                .frame(height:20)
                        
            Button("Change") {
                self.changeCurve.toggle()
            }
            .buttonStyle(BlueButtonStyle())
            
            Spacer()
        }
    }
}

struct SuitChangeView2: View {
    @State private var changeCurve = true
    
    var body: some View {
        VStack(spacing:50) {
            Text("Shape change with Animatable Cubic Curve")
            
            ScrollView(.horizontal) {
                HStack(spacing:40) {
                    ZStack {
                        ForEach(0..<max(SomeSuit.club.count, SomeSuit.heart.count)) { i in
                            SomeCubicCurveShape(curve: changeCurve ?
                                                SomeSuit.club[(i % SomeSuit.club.count)] :
                                                    SomeSuit.heart[(i % SomeSuit.heart.count)])
                            .stroke(changeCurve ? Color(.black) : .red, lineWidth: 4.0)
                        }
                    }
                    .frame(width: 200, height: 200)
                    .animation(.linear(duration: 1))
                    
                    ZStack {
                        ForEach(0..<max(SomeSuit.heart.count, SomeSuit.spade.count)) { i in
                            SomeCubicCurveShape(curve: changeCurve ?
                                                SomeSuit.heart[(i % SomeSuit.heart.count)] :
                                                    SomeSuit.spade[(i % SomeSuit.spade.count)])
                            .stroke(changeCurve ? Color(.red) : .black, lineWidth: 4.0)
                        }
                    }
                    .frame(width: 200, height: 200)
                    .animation(.linear(duration: 1))
                    
                    ZStack {
                        ForEach(0..<max(SomeSuit.diamond.count, SomeSuit.spade.count)) { i in
                            SomeCubicCurveShape(curve: changeCurve ?
                                                SomeSuit.spade[(i % SomeSuit.spade.count)] :
                                                    SomeSuit.diamond[(i % SomeSuit.diamond.count)])
                            .stroke(changeCurve ? Color(.black) : .red, lineWidth: 4.0)
                        }
                    }
                    .frame(width: 200, height: 200)
                    .animation(.linear(duration: 1))
                    
                    ZStack {
                        ForEach(0..<max(SomeSuit.club.count, SomeSuit.diamond.count)) { i in
                            SomeCubicCurveShape(curve: changeCurve ?
                                                SomeSuit.diamond[(i % SomeSuit.diamond.count)] :
                                                    SomeSuit.club[(i % SomeSuit.club.count)])
                            .stroke(changeCurve ? Color(.red) : .black, lineWidth: 4.0)
                        }
                    }
                    .frame(width: 200, height: 200)
                    .animation(.linear(duration: 1))
                }
            }
            Button("Change") {
                self.changeCurve.toggle()
            }
            .buttonStyle(BlueButtonStyle())
            
            Spacer()
        }
    }
}

struct SuitChangeExampler_Previews: PreviewProvider {
    static var previews: some View {
        //SuitChangeExampler()
        SuitChangeView2()
    }
}
