//
//  ContentView.swift
//  SomeUIComponentsExample
//
//  Created by Sergey Makeev on 01.11.2024.
//

import SwiftUI
import SomeUIComponents
import Logging
import OSLog

let logger = Logger(label: "main")

public struct MyOSLogHandler: LogHandler {
    private let logger: os.Logger

    public var logLevel: Logging.Logger.Level = .debug
    public var metadata: Logging.Logger.Metadata = [:]

    public init(subsystem: String, category: String) {
        self.logger = os.Logger(subsystem: subsystem, category: category)
    }

    public subscript(metadataKey key: String) -> Logging.Logger.Metadata.Value? {
        get { metadata[key] }
        set { metadata[key] = newValue }
    }

    public func log(level: Logging.Logger.Level,
                    message: Logging.Logger.Message,
                    metadata: Logging.Logger.Metadata?,
                    source: String,
                    file: String,
                    function: String,
                    line: UInt) {
        switch level {
        case .trace: logger.debug("\(message, privacy: .public)")
        case .debug: logger.debug("\(message, privacy: .public)")
        case .info:  logger.info("\(message, privacy: .public)")
        case .notice: logger.notice("\(message, privacy: .public)")
        case .warning: logger.warning("\(message, privacy: .public)")
        case .error: logger.error("\(message, privacy: .public)")
        case .critical: logger.fault("\(message, privacy: .public)")
        }
    }
}

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
        ScrollView {
            VStack {
                PointsListExampler()
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
                    .frame(width: 200, height: 100)
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
                    .frame(width: 200, height: 100)
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
        }
        .padding()
        .onDisappear() {
            trickHandler.release()
        }
        .onAppear() {
            LoggingSystem.bootstrap { label in
                MyOSLogHandler(subsystem: "com.SomeUICOmponentsDemo.someprojects", category: label)
            }
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
