//
//  ContentView.swift
//  SomeUIComponentsExample
//
//  Created by Sergey Makeev on 01.11.2024.
//

import SwiftUI
import SomeUIComponents

struct ContentView: View {

    let trickHandler = SomeTrickHandler()
    @State private var shapeStateInitial = true
    @State private var shapePath: Path = Path { path in
        path.addPath(TextPathExampler.path1)
    }

    @State private var textStateInitial = true
    @State private var textPath: Path = Path { path in
        path.addPath(TextPathExampler.pathText1)
    }

    var body: some View {
        VStack {
            //PointsListExampler()
            RadioGroupExampler()
            SomeShape(path: textPath, key: "TextPathMain")
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
                .onTapGesture {
                             withAnimation(.easeInOut(duration: 2.0)) {
                                 self.textStateInitial.toggle()
                                 self.textPath = Path { path in
                                     let toUse = self.textStateInitial ? TextPathExampler.pathText1 :
                                         TextPathExampler.pathText2
                                     path.addPath(toUse)
                                 }
                             }
                         }
            SomeShape(path: shapePath, key: "ShapePathMain")
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
                .onTapGesture {
                             withAnimation(.easeInOut(duration: 2.0)) {
                                 self.shapeStateInitial.toggle()
                                 self.shapePath = Path { path in
                                     let toUse = self.shapeStateInitial ? TextPathExampler.path1 :
                                         TextPathExampler.path2
                                     path.addPath(toUse)
                                 }
                             }
                         }
        }
        .padding()
        .onDisappear() {
            trickHandler.release()
        }
    }
}

struct BlueButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .font(.system(size: 24, weight:.bold, design: .rounded))
            .foregroundColor(.white)
            .padding(.horizontal)
            .padding(5)
            .background(Color.blue)
            .cornerRadius(10)
            .shadow(color:.black, radius:3, x:3.0, y:3.0)
            .opacity(configuration.isPressed ? 0.6 : 1.0)
            .scaleEffect(configuration.isPressed ? 0.95 : 1.0)
    }
}

#Preview {
    ContentView()
}
