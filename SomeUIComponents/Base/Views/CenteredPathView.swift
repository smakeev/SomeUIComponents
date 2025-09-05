//
//  CenteredPathView.swift
//  SomeUIComponents
//
//  Created by Sergey Makeev on 01.11.2024.
//

import SwiftUI


public struct SomeCenteredPathView<Content: View>: View, SomeUIComponent {
    var path: Path
    var renderer: (Path) -> Content
    var lineWidth: CGFloat = 0

    public init(path: Path, expectedLineWidth: CGFloat? = nil,  @ViewBuilder renderer: @escaping (Path) -> Content) {
        self.path = path
        self.renderer = renderer
        lineWidth = expectedLineWidth ?? 0
    }

    public var body: some View {
        let pathBounds = path.boundingRect
        let frameSize = CGSize(width: pathBounds.width + lineWidth * 2, height: pathBounds.height + lineWidth * 2)
        return GeometryReader { geometry in
            let pathBounds = path.boundingRect
            let scale = min(geometry.size.width / pathBounds.width, geometry.size.height / pathBounds.height)
            let scaledPath = path
                .applying(CGAffineTransform(scaleX: scale, y: scale))
            let offsetX = (geometry.size.width - scaledPath.boundingRect.width) / 2
            let offsetY = (geometry.size.height - scaledPath.boundingRect.height) / 2

            renderer(scaledPath).offset(x: offsetX, y: offsetY)
        }.frame(width: frameSize.width, height: frameSize.height)
    }
}
