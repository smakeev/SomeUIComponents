//
//  RadioGroupExampler.swift
//  SomeUIComponentsExample
//
//  Created by Sergey Makeev on 06.09.2025.
//

import SwiftUI
import SomeUIComponents

struct ColoredToggleStyle: ToggleStyle {
    var onColor: Color
    var offColor: Color
    var thumbColor: Color = .white

    func makeBody(configuration: Configuration) -> some View {
        HStack {
            configuration.label

            RoundedRectangle(cornerRadius: 16)
                .fill(configuration.isOn ? onColor : offColor)
                .frame(width: 50, height: 30)
                .overlay(
                    Circle()
                        .fill(thumbColor)
                        .padding(3)
                        .offset(x: configuration.isOn ? 10 : -10)
                        .animation(.easeInOut(duration: 0.2), value: configuration.isOn)
                )
                .onTapGesture {
                    configuration.isOn.toggle()
                }
        }
    }
}

struct RadioGroupExampler: View {
    @State private var selections: [Bool] = [true, true, true, true, true, true]

    var body: some View {
        SomeRadioGroup(
            selectionStyle: .multiple(max: 3),
            minSelectCount: 2,
            titleView: Text("Radio Group"),
            needsAlignment: true,
            buttonStyleOverride: SomeRadioSymbolStyle(type: .toggle(style: AnyToggleStyle(ColoredToggleStyle(onColor: .red, offColor: .gray)))),
            buttons: selections.indices.map { i in
                SomeRadioButton(isSelected: $selections[i], isDisabled: i == 1 ? .constant(true) : .constant(false), spacer: false, spacing: 8, label: AnyView(Text("Option \(i+1) + \(Int.random(in: 0..<100000))")))
            }) { newValue in
                logger.debug("New selections: \(newValue)")
            }
            .onSelectionChangeAttempt { index, newState in
                logger.debug("Check for change availability")
                guard index != 5 else { return false }
                return true
            }
            .padding()
            .disabled(false)
    }
}

struct RadioGroupExampler_Previews: PreviewProvider {
    static var previews: some View {
        RadioGroupExampler()
    }
}
