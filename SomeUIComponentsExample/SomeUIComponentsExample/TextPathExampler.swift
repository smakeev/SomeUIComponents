//
//  TextPathExampler.swift
//  SomeUIComponentsExample
//
//  Created by Sergey Makeev on 01.11.2024.
//

import SwiftUI
import SomeUIComponents

struct TextPathExampler: View {

    @State private var textStateInitial = true
    @State private var shapeStateInitial = true
    static let pathText1 = SomeTextPath(string: "Hello, SwiftUI!", textStyle: .title)
    static let pathText2 = SomeTextPath(string: "Привет, СвифтUI!", textStyle: .title)
    static let path1 = Circle().path(in: CGRect(x: 0, y: 0, width: 100, height: 100))
    static let path2 = Rectangle().path(in: CGRect(x: 0, y: 0, width: 100, height: 100))

    let trickHandler = SomeTrickHandler()

    @State private var textPath: Path = Path { path in
        path.addPath(TextPathExampler.pathText1)
    }

    @State private var shapePath: Path = Path { path in
        path.addPath(TextPathExampler.path1)
    }

    var body: some View {
        VStack(spacing: 30) {
            SomeCenteredPathView(path: textPath, expectedLineWidth: 12) { path in
                path.stroke(LinearGradient(
                    gradient: Gradient(colors: [.black, .yellow]),
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing), lineWidth: 12)
                .fill(LinearGradient(
                    gradient: Gradient(colors: [.white, .green]),
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing))
            }.background(Color.red)
            SomeCenteredPathView(path: shapePath,
                                 expectedLineWidth: 12) { path in
                path.stroke(LinearGradient(
                    gradient: Gradient(colors: [.black, .yellow]),
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing), lineWidth: 12)
                .fill(LinearGradient(
                    gradient: Gradient(colors: [.white, .green]),
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing))
            }.background(Color.red)

            // Shapes

            SomeShape(path: textPath, key: "TaxtPath")
                .storeIn(handler: trickHandler)
                .stroke(LinearGradient(
                    gradient: Gradient(colors: [.black, .yellow]),
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing), lineWidth: 12)
                .fill(LinearGradient(
                    gradient: Gradient(colors: [.white, .green]),
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing))
                .frame(width: 400, height: 100)
                .background(Color.red)
                .onTapGesture {
                             withAnimation(.easeInOut(duration: 1.0)) {
                                 self.textPath = Path { path in
                                     let toUse = self.textStateInitial ? TextPathExampler.pathText2 :
                                         TextPathExampler.pathText1
                                     path.addPath(toUse)
                                     self.textStateInitial.toggle()
                                 }
                             }
                         }
            SomeShape(path: shapePath, key: "ShapePath")
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
                             withAnimation(.easeInOut(duration: 2.0)) {
                                 self.shapePath = Path { path in
                                     let toUse = self.shapeStateInitial ? TextPathExampler.path1 :
                                         TextPathExampler.path2
                                     path.addPath(toUse)
                                     self.shapeStateInitial.toggle()
                                 }
                             }
                         }
        }.onDisappear() {
            trickHandler.release()
        }
    }
}

struct TextPathExampler_Previews: PreviewProvider {
    static var previews: some View {
        TextPathExampler()
    }
}
