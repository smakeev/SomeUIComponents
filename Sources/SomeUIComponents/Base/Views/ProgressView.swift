//
//  ProgressView.swift
//  SomeUIComponents
//
//  Created by Sergey Makeev on 01.11.2024.
//

import SwiftUI

public struct SomeProgressView<Overlay: View, Style: ShapeStyle>: View, SomeUIComponent {
    var progressPath: Path
    var overlayView: Overlay
    var pathStyle: Style
    var lineWidth: CGFloat
    @Binding var from: CGFloat
    @Binding var to: CGFloat

    public init(progressPath: Path,
                overlayView: Overlay = EmptyView(),
                pathStyle: Style,
                lineWidth: CGFloat = 2.0,
                from: Binding<CGFloat>,
                to: Binding<CGFloat>) {
        self.progressPath = progressPath
        self.overlayView = overlayView
        self.pathStyle = pathStyle
        self.lineWidth = lineWidth
        self._from = from
        self._to = to
    }

    public init(progressPath: Path, pathStyle: Style,
                lineWidth: CGFloat = 2.0,
                from: Binding<CGFloat>,
                to: Binding<CGFloat>,
                @ViewBuilder overlayView: () -> Overlay) {
          self.progressPath = progressPath
          self.overlayView = overlayView()
          self.pathStyle = pathStyle
          self.lineWidth = lineWidth
          self._to = to
          self._from = from
      }

    public var body: some View {
        ZStack {
            overlayView
            progressPath
                .trim(from: from, to: to)
                .stroke(pathStyle, lineWidth: lineWidth)
                .fill(pathStyle)
        }
    }
}
