//
//  Shape.swift
//  SomeUIComponents
//
//  Created by Sergey Makeev on 02.11.2024.
//

import SwiftUI

public class SomeTrickHandler: SomeUIComponent {
    fileprivate var tricks: [String] = []

    public init() {}

    public func release() {
        for trick in tricks {
            SomeTrick.release(key: trick)
        }
        tricks = []
    }
}

public protocol SomeTrickHandlerUser {
    func storeIn(handler: SomeTrickHandler) -> Self
}

class SomeTrickItem {
    var toggled = true
    var path: Path? = nil
}

class SomeTrick {
    static func initialize(key: String) {
        if items[key] == nil {
            items[key] = SomeTrickItem()
        }
    }

    static func release(key: String) {
        items[key] = nil
    }

    nonisolated(unsafe) static var items: [String : SomeTrickItem] = [:]
}

extension SomeShape: SomeTrickHandlerUser {
    public func storeIn(handler: SomeTrickHandler) -> SomeShape {
        handler.tricks.append(key)
        return self
    }
    

}

public struct SomeShape: Shape, SomeUIComponent {
    var path: Path

    var progress: Double = 0
    var changingPath = false
    var key: String

    public var animatableData: Double {
        get {
            return progress
        }
        set {
            progress = newValue
        }
    }

    public init(path: Path, key: String) {
        self.key = key
        SomeTrick.initialize(key: key)
        if SomeTrick.items[key]?.path == nil {
            SomeTrick.items[key]?.path = path
        } else if SomeTrick.items[key]?.path! != path {
            changingPath = true
            if SomeTrick.items[key]!.toggled {
                self.progress = 1
            } else {
                self.progress = 0
            }
            SomeTrick.items[key]!.toggled.toggle()
        }
        self.path = path
    }

    private func centered(_ path: Path, in rect: CGRect) -> Path {
        let xOffset = (rect.size.width - path.boundingRect.width) / 2
        let yOffset = (rect.size.height - path.boundingRect.height) / 2

        var centeredPath = path
        centeredPath = centeredPath.applying(CGAffineTransform(translationX: xOffset, y: yOffset))

        return centeredPath
    }

    public func path(in rect: CGRect) -> Path {
        guard let toggled = SomeTrick.items[key]?.toggled else { return path }
        guard changingPath else { return centered(SomeTrick.items[key]?.path ?? path, in: rect)}
        var result = path.trim(from: 0, to: toggled ? 1 - progress : progress).path(in: rect)
        if changingPath {
            if (!toggled && progress == 1) ||
                (toggled && progress == 0) {
                SomeTrick.items[key]?.path = path
            } else if let trickedPath = SomeTrick.items[key]?.path {
                let currentPathToBeRemoved = trickedPath.trim(from: toggled ? 1 - progress : progress, to:  toggled ? progress : 1 - progress).path(in: rect)
                result.addPath(currentPathToBeRemoved)
            }
        }

        return centered(result, in: rect)
    }
}
