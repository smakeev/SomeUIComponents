//
//  RadioGroup.swift
//  SomeUIComponents
//
//  Created by Sergey Makeev on 06.09.2025.
//

import SwiftUI

// MARK: - Selection Style

public enum SomeRadioGroupSelectionStyle: SomeUIComponent {
    case single
    case multiple(max: Int)
    case all

    public var maxCount: Int? {
        switch self {
        case .single: return 1
        case .multiple(let max): return max
        case .all: return nil
        }
    }
}

// MARK: - Title Alignment

public enum SomeRadioGroupTitleAlignment: SomeUIComponent {
    case leading
    case center
    case trailing
    case automatic

    public static func defaultForLayoutDirection(_ layoutDirection: LayoutDirection) -> Self {
        switch layoutDirection {
        case .leftToRight: return .leading
        case .rightToLeft: return .trailing
        @unknown default: return .leading
        }
    }
}

// MARK: - SomeRadioGroup

private final class GroupSelectionState: ObservableObject {
    var selectionStack: [Bool] = []
    var selectionQueue: [Int] = []
    var lastReportedSelection: [Int] = []
}

public struct SomeRadioGroup<BorderShape: Shape>: View, SomeUIComponent {
    public enum ContentAlignment {
          case topLeading, topCenter, topTrailing
          case centerLeading, center, centerTrailing
          case bottomLeading, bottomCenter, bottomTrailing

          var horizontal: HorizontalAlignment {
              switch self {
              case .topLeading, .centerLeading, .bottomLeading: return .leading
              case .topCenter, .center, .bottomCenter: return .center
              case .topTrailing, .centerTrailing, .bottomTrailing: return .trailing
              }
          }

          var vertical: VerticalAlignment {
              switch self {
              case .topLeading, .topCenter, .topTrailing: return .top
              case .centerLeading, .center, .centerTrailing: return .center
              case .bottomLeading, .bottomCenter, .bottomTrailing: return .bottom
              }
          }

          var swiftUIAlignment: Alignment {
              switch self {
              case .topLeading: return .topLeading
              case .topCenter: return .top
              case .topTrailing: return .topTrailing
              case .centerLeading: return .leading
              case .center: return .center
              case .centerTrailing: return .trailing
              case .bottomLeading: return .bottomLeading
              case .bottomCenter: return .bottom
              case .bottomTrailing: return .bottomTrailing
              }
          }
      }
    public var contentAlignment: ContentAlignment
    public let selectionStyle: SomeRadioGroupSelectionStyle
    public let borderColor: Color
    public let borderWidth: CGFloat
    public let borderShape: BorderShape
    public let titleView: AnyView
    public let titleAlignment: SomeRadioGroupTitleAlignment
    public let buttonStyleOverride: SomeRadioSymbolStyle?
    public let buttons: [SomeRadioButton]
    public let onChange: (([Int]) -> Void)?
    public let minSelectCount: Int
    public var canChangeSelection: ((Int, Bool) -> Bool)?
    public let spacer: Bool
    public let spacing: CGFloat

    public var needsAlignment: Bool
    @State private var maxLabelWidth: CGFloat = 0

    @Environment(\.isEnabled) private var isEnabled

    @StateObject private var state = GroupSelectionState()

    public init(
        selectionStyle: SomeRadioGroupSelectionStyle = .single,
        minSelectCount: Int = 0,
        borderColor: Color = .gray,
        borderWidth: CGFloat = 1,
        borderShape: BorderShape = Rectangle(),
        titleView: some View,
        titleAlignment: SomeRadioGroupTitleAlignment = .automatic,
        contentAlignment: ContentAlignment = .topLeading,
        spacer: Bool = false,
        spacing: CGFloat = 8,
        needsAlignment: Bool = false,
        buttonStyleOverride: SomeRadioSymbolStyle? = nil,
        buttons: [SomeRadioButton],
        onChange: (([Int]) -> Void)? = nil
    ) {
        self.selectionStyle = selectionStyle
        self.minSelectCount = minSelectCount
        self.borderColor = borderColor
        self.borderWidth = borderWidth
        self.borderShape = borderShape
        self.titleView = AnyView(titleView)
        self.titleAlignment = titleAlignment
        self.buttonStyleOverride = buttonStyleOverride
        self.buttons = buttons
        self.onChange = onChange
        self.needsAlignment = needsAlignment
        self.spacer = spacer
        self.spacing = spacing
        self.contentAlignment = contentAlignment
        let initialStack = buttons.map { $0.isSelected }
        let initialQueue = initialStack.enumerated()
               .compactMap { $0.element ? $0.offset : nil }
        let state = GroupSelectionState()
        state.selectionStack = initialStack
        state.selectionQueue = initialQueue
        _state = StateObject(wrappedValue: state)
        logger.info("Init selectionQueue: \(state.selectionQueue), selectionStack: \(state.selectionStack)")
    }

    fileprivate func adjustSelectedCount() {
        var selectedCount = state.selectionQueue.count
        if selectedCount < minSelectCount {
            for (index, isSelected) in state.selectionStack.enumerated() {
                guard selectedCount < minSelectCount else { break }
                if !isSelected {
                    guard buttons[index].isDisabled == false else { continue }
                    buttons[index]._internalToggleClosure?()
                    selectedCount += 1
                }
            }
        }
        guard selectedCount >= minSelectCount else { fatalError("RadioGroup minimum selection count not reached: \(minSelectCount)") }
        if let max = selectionStyle.maxCount, selectedCount > max {
            logger.info("RadioGroup more than MAX: \(max) selected")
            for (index, isSelected) in state.selectionStack.enumerated() {
                guard selectedCount > max else { break }
                if isSelected {
                    guard buttons[index].isDisabled == false else { continue }
                    buttons[index]._internalToggleClosure?()
                    selectedCount -= 1
                }
            }
            guard selectedCount <= max else {
                fatalError("RadioGroup more than MAX: \(max) selected")
            }
        }
    }

    /// Add a callback to check if new value can be set by index
    /// @param - 1st - index of the element
    /// @param - 2nd - New state
    /// @return - true = can be changed, false - can't be changed
    public func onSelectionChangeAttempt(_ delegateCallback: @escaping (Int, Bool) -> Bool) -> Self {
        var copy = self
        copy.canChangeSelection = delegateCallback
        return copy
    }

    @ViewBuilder
    private func spacerIfNeeded(_ place: VerticalAlignment) -> some View {
        if spacer {
            Spacer(minLength: 12)
        } else {
            if contentAlignment.vertical == .top {
                EmptyView()
            } else if contentAlignment.vertical == .center &&
                        (place == .top || place == .bottom) {
                Spacer(minLength: 12)
            } else if contentAlignment.vertical == .bottom && place == .top {
                Spacer(minLength: 12)
            }
            EmptyView()
        }
    }

    public var body: some View {
        let zippedButtons = Array(buttons.enumerated())

        return 
        ZStack(alignment: .topLeading) {
                borderShape
                    .stroke(borderColor, lineWidth: borderWidth)

            VStack(alignment: contentAlignment.horizontal, spacing: spacing) {
                spacerIfNeeded(.top)

                    ForEach(zippedButtons, id: \.offset) { index, button in
                        button
                            .withOverriddenStyle(buttonStyleOverride)
                            .internalSelectionObserver { newValue in
                                updateSelection(index: index, isSelected: newValue)
                            }
                            .internalToggleControlDelegate {
                                (canChangeSelection?(index, $0) ?? true)
                                && ($0 || state.selectionQueue.count > minSelectCount)
                            }
                            .internalAlignmentSetter(needsAlignment ? maxLabelWidth : nil)
                            .environment(\.isEnabled, isEnabled)
                        spacerIfNeeded(.center)
                    }
                    spacerIfNeeded(.bottom)
                }
                .frame(maxWidth: .infinity, alignment: contentAlignment.swiftUIAlignment)
                .padding()
                .onPreferenceChange(WidthPreferenceKey.self) { value in
                    if needsAlignment {
                        maxLabelWidth = value
                    }
                }
                .padding(.horizontal, 12)

                titleView
                    .lineLimit(1)
                    .truncationMode(.tail)
                    .padding(.horizontal, 6)
                    .background(Color(UIColor.systemBackground))
                    .frame(maxWidth: .infinity, alignment: titleFrameAlignment)
                    .offset(y: -10)
            }
        .onAppear() {
            if let max = selectionStyle.maxCount, minSelectCount > max ||
                minSelectCount > buttons.count {
                logger.critical("Radio Group inconsistency: max: \(String(describing: max)), min: \(minSelectCount), buttons.count: \(buttons.count)")
                fatalError("Radio Group inconsistency: \(max)/\(minSelectCount)/\(buttons.count)")
            }
            adjustSelectedCount()
        }
    }

    private var titleFrameAlignment: Alignment {
        switch titleAlignment {
        case .leading:
            return .leading
        case .center:
            return .center
        case .trailing:
            return .trailing
        case .automatic:
            let uiDir = UIView.userInterfaceLayoutDirection(
                for: UIView.appearance().semanticContentAttribute
            )
            let layoutDir: LayoutDirection = (uiDir == .rightToLeft) ? .rightToLeft : .leftToRight

            let resolved = SomeRadioGroupTitleAlignment
                .defaultForLayoutDirection(layoutDir)

            switch resolved {
            case .leading: return .leading
            case .center: return .center
            case .trailing: return .trailing
            case .automatic: return .leading // fallback, though should never happen
            }
        }
    }

    private func updateSelection(index: Int, isSelected: Bool) {
        guard state.selectionStack.indices.contains(index) else { return }
        logger.info("Update selection — index: \(index), isSelected: \(isSelected)")
        // Handle selection
        if isSelected {
            // Skip if already in the correct state
            if state.selectionStack[index] { return }

            // Apply max selection logic
            if let max = selectionStyle.maxCount, state.selectionQueue.count == max {
                // Remove the oldest selected index
                if let oldest = state.selectionQueue.first(where: {
                    buttons[$0].isDisabled == false
                }) {
                    logger.info("Switch off selection of \(oldest) button.")
                    buttons[oldest]._internalToggleClosure?()
                    state.selectionQueue.filter { $0 != oldest }
                } else {
                    // We can't switch off anything, so return the latest change back
                    logger.info("Attempt to change selection beyond max count while deselecting of previous is imposible.")
                    buttons[index]._internalToggleClosure?()
                    return
                }
            }

            state.selectionStack[index] = true
            if !state.selectionQueue.contains(index) {
                state.selectionQueue.append(index)
            }
        } else {
            // Handle deselection
            state.selectionStack[index] = false
            state.selectionQueue.removeAll { $0 == index }
        }

        logger.info("Update state — queue: \(state.selectionQueue), stack: \(state.selectionStack)")
        if isSelected == false, minSelectCount > state.selectionQueue.count {
            buttons[index]._internalToggleClosure?()
        } else {
            if state.lastReportedSelection != state.selectionQueue {
                onChange?(state.selectionQueue)
                state.lastReportedSelection = state.selectionQueue
            }
        }
    }
}

extension SomeRadioButton {
    /// Returns a copy of the radio button with the given style applied,
    /// overriding the current style if the override is provided.
    func withOverriddenStyle(_ override: SomeRadioSymbolStyle?) -> SomeRadioButton {
        guard let override = override else { return self }

        var copy = self
        copy.style = override
        return copy
    }
}
