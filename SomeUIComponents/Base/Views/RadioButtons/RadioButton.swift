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
    public let color: Color
    public let styleType: SomeRadioSymbolStyleType

    public init(color: Color = .gray, type: SomeRadioSymbolStyleType = .system) {
        self.color = color
        self.styleType = type
        let symbols = styleType.style()
        self.onSymbol = symbols.onSymbol
        self.offSymbol = symbols.offSymbol
    }

    @ViewBuilder
    public func view(isSelected: Bool) -> some View {
        Image(systemName: isSelected ? onSymbol : offSymbol)
            .foregroundColor(color)
    }
}

/// Preset symbol styles using SF Symbols.
public enum SomeRadioSymbolStyleType: SomeUIComponent {
    case system
    case minimal
    case dotted
    case checkmark
    case custom(String, String)

    public func style(with color: Color = .gray) -> (onSymbol: String, offSymbol: String) {
        switch self {
        case .system:
            return (onSymbol: "record.circle.fill", offSymbol: "circle.fill")
        case .minimal:
            return (onSymbol: "circle.fill", offSymbol: "circle")
        case .dotted:
            return (onSymbol: "circle.dotted.circle.fill", offSymbol: "circle.fill")
        case .checkmark:
            return (onSymbol: "checkmark.circle.fill", offSymbol: "circle")
        case .custom(let onSymbol, let offSymbol):
            return (onSymbol: onSymbol, offSymbol: offSymbol)
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
    public let text: String
    @Binding public var isSelected: Bool
    let selectionBinding: Binding<Bool>
    public var style: SomeRadioSymbolStyle
    public var textPosition: SomeRadioTextPosition
    public var onChange: ((Bool) -> Void)?

    var _internalOnSelectionChange: ((Bool) -> Void)? = nil
    var _internalToggleClosure: (() -> Void)?
    var _internalToggleDelegateClosure: ((Bool) -> Bool)? = nil

    public init(
        text: String,
        isSelected: Binding<Bool>,
        style: SomeRadioSymbolStyle = SomeRadioSymbolStyle(),
        textPosition: SomeRadioTextPosition = .automatic,
        onChange: ((Bool) -> Void)? = nil
    ) {
        self.text = text
        self._isSelected = isSelected
        self.selectionBinding = isSelected
        self.style = style
        self.textPosition = textPosition
        self.onChange = onChange
        _internalToggleClosure = {
            isSelected.wrappedValue.toggle()
        }
    }

    public var body: some View {
        HStack {
            let resolved = textPosition.resolved(layoutDirection)

            if resolved == .left {
                Text(text)
                style.view(isSelected: isSelected)
            } else {
                style.view(isSelected: isSelected)
                Text(text)
            }
        }
        .contentShape(Rectangle())
        .onTapGesture {
            if _internalToggleDelegateClosure?(!isSelected) ?? true {
                isSelected.toggle()
            }
        }.onChange(of: isSelected) { newValue in
            print("\(text) ON CHANGE")
            onChange?(newValue)
            _internalOnSelectionChange?(newValue)
        }
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
}
