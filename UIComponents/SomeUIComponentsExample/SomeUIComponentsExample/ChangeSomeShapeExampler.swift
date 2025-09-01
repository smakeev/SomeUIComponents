//
//  ChangeSomeShapeExampler.swift
//  SomeUIComponentsExample
//
//  Created by Sergey Makeev on 02.11.2024.
//

import SwiftUI
import SomeUIComponents

struct ChangeSomeShapeExampler: View {

    @State private var open: Bool = false
    static let pathText1 = SomeTextPath(string: "Hello, SwiftUI!", textStyle: .title)
    static let pathText2 = SomeTextPath(string: "Привет, СвифтUI!", textStyle: .title)
    let trickHandler = SomeTrickHandler()
    var body: some View {
        VStack {
            if self.open {
                VStack {
                    SomeCenteredPathView(path: ChangeSomeShapeExampler.pathText1, expectedLineWidth: 12) { path in
                        path.stroke(LinearGradient(
                            gradient: Gradient(colors: [.black, .yellow]),
                            startPoint: .topLeading,
                            endPoint: .bottomTrailing), lineWidth: 12)
                        .fill(LinearGradient(
                            gradient: Gradient(colors: [.white, .green]),
                            startPoint: .topLeading,
                            endPoint: .bottomTrailing))
                    }.background(Color.red)
                    SomeShape(path: Rectangle().path(in: CGRect(x: 0, y: 0, width: 100, height: 100)), key: "ChangeShapeExampler-Shape")
                        .storeIn(handler: trickHandler)
                        .stroke(LinearGradient(
                            gradient: Gradient(colors: [.black, .yellow]),
                            startPoint: .topLeading,
                            endPoint: .bottomTrailing), lineWidth: 12)
                        .fill(LinearGradient(
                            gradient: Gradient(colors: [.white, .green]),
                            startPoint: .topLeading,
                            endPoint: .bottomTrailing))
                        .frame(width: 200, height: 200)
                        .background(Color.red)
                        .onTapGesture {
                            withAnimation(.easeInOut(duration: 1.0)) {
                                self.open.toggle()
                            }
                        }
                }
            } else {
                VStack {
                    SomeCenteredPathView(path: ChangeSomeShapeExampler.pathText2, expectedLineWidth: 12) { path in
                        path.stroke(LinearGradient(
                            gradient: Gradient(colors: [.black, .yellow]),
                            startPoint: .topLeading,
                            endPoint: .bottomTrailing), lineWidth: 12)
                        .fill(LinearGradient(
                            gradient: Gradient(colors: [.white, .green]),
                            startPoint: .topLeading,
                            endPoint: .bottomTrailing))
                    }.background(Color.red)
                    SomeShape(path: Circle().path(in: CGRect(x: 0, y: 0, width: 100, height: 100)), key: "ChangeShapeExampler-Text")
                        .stroke(LinearGradient(
                            gradient: Gradient(colors: [.black, .yellow]),
                            startPoint: .topLeading,
                            endPoint: .bottomTrailing), lineWidth: 12)
                        .fill(LinearGradient(
                            gradient: Gradient(colors: [.white, .green]),
                            startPoint: .topLeading,
                            endPoint: .bottomTrailing))
                        .frame(width: 200, height: 200)
                        .background(Color.red)
                        .onTapGesture {
                            withAnimation(.easeInOut(duration: 1.0)) {
                                self.open.toggle()
                            }
                        }
                }
            }
        }.frame(width: 200, height: 200)
            .animation(.linear(duration: 2))
            .onTapGesture {
                self.open.toggle()
            }.onDisappear() {
                trickHandler.release()
            }
    }
}

struct ChangeSomeShapeExampler_Previews: PreviewProvider {
    static var previews: some View {
        ChangeSomeShapeExampler()
    }
}
