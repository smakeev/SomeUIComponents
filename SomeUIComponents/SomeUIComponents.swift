// The Swift Programming Language
// https://docs.swift.org/swift-book

import SwiftUICore
import OSLog

internal protocol SomeUIComponent {}

public func isFromSomeUIComponents(_ element: Any) -> Bool {
    element is SomeUIComponent
}

// MARK: - Public Configuration API
public enum SomeUIComponentsLogConfig {
    public static func setEnabled(_ enabled: Bool) {
        SomeUIComponentsLogger.setEnabled(enabled)
    }

    public static func bootstrap(subsystem: String, category: String) {
        SomeUIComponentsLogger.bootstrap(subsystem: subsystem, category: category)
    }

    public static func isEnabled(completion: @Sendable @escaping (Bool) -> Void) {
        Task { @Sendable in
            let enabled = await SomeUIComponentsLogger.isEnabled
            completion(enabled)
        }
    }
}

// MARK: - Internal Logger

internal enum Log {
    static func debug(_ message: String) {
        SomeUIComponentsLogger.log(message, level: .debug)
    }

    static func info(_ message: String) {
        SomeUIComponentsLogger.log(message, level: .info)
    }

    static func error(_ message: String) {
        SomeUIComponentsLogger.log(message, level: .error)
    }

    static func fault(_ message: String) {
        SomeUIComponentsLogger.log(message, level: .fault)
    }
}

private enum SomeUIComponentsLogger {
    private static let actor = LoggerActor()

    static func log(_ message: String, level: OSLogType = .debug) {
        Task {
            await actor.log(message, level: level)
        }
    }

    static func bootstrap(subsystem: String, category: String) {
        Task {
            await actor.bootstrap(subsystem: subsystem, category: category)
        }
    }

    static func setEnabled(_ enabled: Bool) {
        Task {
            await actor.setEnabled(enabled)
        }
    }

    static var isEnabled: Bool {
        get async {
            await actor.isEnabled
        }
    }
}

private actor LoggerActor {
    private var logger = Logger(subsystem: "com.someui.logger", category: "UI")
    private(set) var isEnabled: Bool = true

    func log(_ message: String, level: OSLogType) {
        guard isEnabled else { return }
        logger.log(level: level, "\(message, privacy: .public)")
    }

    func bootstrap(subsystem: String, category: String) {
        logger = Logger(subsystem: subsystem, category: category)
    }

    func setEnabled(_ enabled: Bool) {
        self.isEnabled = enabled
    }
}
