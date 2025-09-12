//
//  RadioButton.swift
//  SomeUIComponents
//
//  Created by Sergey Makeev on 06.09.2025.
//

import SwiftUI

/// Describes the symbol images used for ON and OFF states of a radio button.
public struct SomeRadioSymbolStyle: SomeUIComponent {
    public let onSymbol: String
    public let offSymbol: String
    public let onColor: Color
    public let offColor: Color
    public let styleType: SomeRadioSymbolStyleType
    public let toggleStyle: AnyToggleStyle?

    public init(type: SomeRadioSymbolStyleType = .minimal(onColor: .green, offColor: .gray)) {
        self.styleType = type
        let symbols = styleType.style()
        self.onSymbol = symbols.onSymbol
        self.offSymbol = symbols.offSymbol
        self.toggleStyle = symbols.toggleStyle
        self.onColor = symbols.onColor ?? .green
        self.offColor = symbols.offColor ?? .gray
    }

    @ViewBuilder
    @MainActor
    public func view(isSelected: Binding<Bool>, toggleGuard: ((Bool) -> Bool)? = nil) -> AnyView {
        guard !onSymbol.isEmpty, !offSymbol.isEmpty else {
            let controlledBinding = Binding<Bool>(
                        get: { isSelected.wrappedValue },
                        set: { newValue in
                            if toggleGuard?(newValue) ?? true {
                                isSelected.wrappedValue = newValue
                            }
                        }
                    )
            return AnyView(Toggle("", isOn: controlledBinding)
                .labelsHidden()
                .toggleStyle(toggleStyle ?? .default))
        }
        return AnyView(Image(systemName: isSelected.wrappedValue ? onSymbol : offSymbol)
            .symbolEffect(.bounce, value: isSelected.wrappedValue)
            .foregroundColor( isSelected.wrappedValue ? onColor : offColor))
    }
}

public struct AnyToggleStyle: ToggleStyle {
    private let _makeBody: (Configuration) -> AnyView

    public init<S: ToggleStyle>(_ style: S) {
        self._makeBody = { AnyView(style.makeBody(configuration: $0)) }
    }

    public func makeBody(configuration: Configuration) -> some View {
        _makeBody(configuration)
    }

    public static var `default`: AnyToggleStyle {
        AnyToggleStyle(SwitchToggleStyle())
    }
}

/// Preset symbol styles using SF Symbols.
public enum SomeRadioSymbolStyleType: SomeUIComponent {
    case fill(onColor: Color, offColor: Color)
    case minimal(onColor: Color, offColor: Color)
    case dotted(onColor: Color, offColor: Color)
    case checkmark(onColor: Color, offColor: Color)
    case dot(onColor: Color, offColor: Color)
    case smallDot(onColor: Color, offColor: Color)
    case square(onColor: Color, offColor: Color)
    case target(onColor: Color, offColor: Color)
    case xmark(onColor: Color, offColor: Color)
    case chevron(onColor: Color, offColor: Color)
    case custom(onSymbol: String, offSymbol: String, onColor: Color, offColor: Color)
    case toggle(style: AnyToggleStyle)
    static public var toggle: SomeRadioSymbolStyleType {
        .toggle(style: MainActor.assumeIsolated { .default } )
    }

    public func style() -> (onSymbol: String, offSymbol: String, onColor: Color?, offColor: Color?, toggleStyle: AnyToggleStyle?) {
        switch self {
        case .fill(let onColor, let offColor):
            return (onSymbol: "circle.fill", offSymbol: "circle", onColor: onColor, offColor: offColor, toggleStyle: nil)
        case .minimal(let onColor, let offColor):
            return (onSymbol: "inset.filled.circle", offSymbol: "circle",  onColor: onColor, offColor: offColor, toggleStyle: nil)
        case .dotted(let onColor, let offColor):
            return (onSymbol: "circle.dotted.circle.fill", offSymbol: "circle.fill", onColor: onColor, offColor: offColor, toggleStyle: nil)
        case .checkmark(let onColor, let offColor):
            return (onSymbol: "checkmark.circle.fill", offSymbol: "circle", onColor: onColor, offColor: offColor, toggleStyle: nil)
        case .dot(let onColor, let offColor):
            return (onSymbol: "record.circle", offSymbol: "circle", onColor: onColor, offColor: offColor, toggleStyle: nil)
        case .smallDot(let onColor, let offColor):
            return (onSymbol: "smallcircle.filled.circle", offSymbol: "circle", onColor: onColor, offColor: offColor, toggleStyle: nil)
        case .square(let onColor, let offColor):
            return (onSymbol: "stop.circle", offSymbol: "circle", onColor: onColor, offColor: offColor, toggleStyle: nil)
        case .target(let onColor, let offColor):
            return (onSymbol: "target", offSymbol: "circle", onColor: onColor, offColor: offColor, toggleStyle: nil)
        case .chevron(let onColor, let offColor):
            return (onSymbol: "chevron.compact.down", offSymbol: "chevron.compact.up", onColor: onColor, offColor: offColor, toggleStyle: nil)
        case .xmark(let onColor, let offColor):
            return (onSymbol: "xmark", offSymbol: "circle", onColor: onColor, offColor: offColor, toggleStyle: nil)
        case .custom(let onSymbol, let offSymbol, let onColor, let offColor):
            return (onSymbol: onSymbol, offSymbol: offSymbol, onColor: onColor, offColor: offColor, toggleStyle: nil)
        case .toggle(let style):
            return (onSymbol: "", offSymbol: "", onColor: nil, offColor: nil, toggleStyle: style)
        }
    }
}

public enum SomeRadioTextPosition: SomeUIComponent {
    case left
    case right
    case automatic

    func resolved(_ direction: LayoutDirection) -> SomeRadioTextPosition {
        switch self {
        case .automatic:
            return direction == .leftToRight ? .left : .right
        default:
            return self
        }
    }
}

public struct SomeRadioButton: View, SomeUIComponent {
    @Binding public var isSelected: Bool
    @Binding public var isDisabled: Bool

    let selectionBinding: Binding<Bool>
    public var style: SomeRadioSymbolStyle
    public var textPosition: SomeRadioTextPosition
    public var onChange: ((Bool) -> Void)?
    public var spacing: CGFloat?
    public var spacer: Bool

    private let label: AnyView

    @State private var ownLabelWidth: CGFloat = 0
    private var alignmentMaxWidth: CGFloat? = nil

    var _internalOnSelectionChange: ((Bool) -> Void)? = nil
    var _internalToggleClosure: (() -> Void)?
    var _internalToggleDelegateClosure: ((Bool) -> Bool)? = nil

    public init(
        isSelected: Binding<Bool>,
        isDisabled: Binding<Bool> = .constant(false),
        style: SomeRadioSymbolStyle = SomeRadioSymbolStyle(),
        textPosition: SomeRadioTextPosition = .automatic,
        spacer: Bool = false,
        spacing: CGFloat? = nil,
        label: AnyView,
        onChange: ((Bool) -> Void)? = nil
    ) {
        self._isSelected = isSelected
        self._isDisabled = isDisabled
        self.selectionBinding = isSelected
        self.style = style
        self.textPosition = textPosition
        self.onChange = onChange
        self.label = label
        self.spacing = spacing
        self.spacer = spacer
        _internalToggleClosure = {
            isSelected.wrappedValue.toggle()
        }
    }

    public var body: some View {
        HStack(spacing: spacing) {
            let resolved = textPosition.resolved(layoutDirection)

            if resolved == .left {
                label
                    .background (
                        GeometryReader { geometry in
                            Color.clear
                                .onAppear { ownLabelWidth = geometry.size.width }
                                .onChange(of: geometry.size.width) { ownLabelWidth = $0 }
                                .preference(key: WidthPreferenceKey.self,
                                            value: geometry.size.width)
                        }
                )
                if spacer { Spacer(minLength: 0) } else { EmptyView() }
                let offset: CGFloat = {
                    guard let maxWidth = alignmentMaxWidth else { return 0 }
                    return max(0, maxWidth - ownLabelWidth)
                }()
                style.view(isSelected: $isSelected, toggleGuard: _internalToggleDelegateClosure)
                    .padding(.leading, offset)
            } else {
                style.view(isSelected: $isSelected, toggleGuard: _internalToggleDelegateClosure)
                if spacer { Spacer(minLength: 0) } else { EmptyView() }
                label
            }
        }
        .contentShape(Rectangle())
        .onTapGesture {
            guard isEnabled, !isDisabled else { return }
            if _internalToggleDelegateClosure?(!isSelected) ?? true {
                isSelected.toggle()
            }
        }.onChange(of: isSelected) { newValue in
            logger.debug("RadioButton ON CHANGE to value: \(newValue)")
            onChange?(newValue)
            _internalOnSelectionChange?(newValue)
        }
        .overlay {
            if !isEnabled || isDisabled {
                Color.white.opacity(0.6)
            }
        }
    }

    func internalAlignmentSetter(_ offset: CGFloat?) -> SomeRadioButton {
        var copy = self
        copy.alignmentMaxWidth = offset
        return copy
    }

    /// Used by the group to set internal callback
    func internalSelectionObserver(_ callback: @escaping (Bool) -> Void) -> SomeRadioButton {
        var copy = self
        copy._internalOnSelectionChange = callback
        return copy
    }

    /// Used by group to control the state change
    func internalToggleControlDelegate(_ callback: @escaping (Bool) -> Bool) -> SomeRadioButton {
        var copy = self
        copy._internalToggleDelegateClosure = callback
        return copy
    }

    @Environment(\.layoutDirection) private var layoutDirection
    @Environment(\.isEnabled) private var isEnabled
}

struct WidthPreferenceKey: PreferenceKey {
    nonisolated(unsafe) static var defaultValue: CGFloat = 0
    nonisolated(unsafe) static func reduce(value: inout CGFloat, nextValue: () -> CGFloat) {
        value = max(value, nextValue())
    }
}
