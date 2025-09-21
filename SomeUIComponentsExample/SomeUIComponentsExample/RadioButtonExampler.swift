//
//  RadioButtonExampler.swift
//  SomeUIComponentsExample
//
//  Created by Sergey Makeev on 06.09.2025.
//

import SwiftUI
import SomeUIComponents

struct RadioButtonExampler: View {
    @State var isSelected:  Bool = false
    @State var isSelected1: Bool = false
    @State var isSelected2: Bool = false
    @State var isSelected3: Bool = false
    var body: some View {
        VStack {
            if UIApplication.isRunningUITests() {
                Text("Radio Button Demo")
                    .accessibilityIdentifier("RadioButtonScreen")
            }

            SomeRadioButton(isSelected: $isSelected, label: AnyView(Text("Default style")))
                .accessibilityElement()
                .accessibilityLabel("RadioButton_1")
                .accessibilityValue(isSelected ? "selected" : "not selected")
            SomeRadioButton(isSelected: $isSelected1, style:  SomeRadioSymbolStyle(type: .fill(onColor: .green, offColor: .gray)), textPosition: .left,
                            label: AnyView(Text("Left, system"))) { _ in
                logger.error("Disabled Pressed")
            }
                .disabled(true)
                .accessibilityElement()
                .accessibilityLabel("RadioButton_Disabled")
                .accessibilityValue(isSelected1 ? "selected" : "not selected")
            SomeRadioButton(isSelected: $isSelected2, style:  SomeRadioSymbolStyle(type: .dotted(onColor: .green, offColor: .red)), textPosition: .automatic, label: AnyView(Text("Left, filled"))) { newValue in
                logger.info("onChange of RadioButton_3: \(newValue ? "Selected" : "Not selected")")
            }
                .accessibilityElement()
                .accessibilityLabel("RadioButton_3")
                .accessibilityValue(isSelected1 ? "selected" : "not selected")
            SomeRadioButton(isSelected: $isSelected3, style:  SomeRadioSymbolStyle(type: .checkmark(onColor: .blue, offColor: .orange)), textPosition: .right, label: AnyView(Text("Right, filled")))
                .accessibilityElement()
                .accessibilityLabel("RadioButton_4")
                .accessibilityValue(isSelected1 ? "selected" : "not selected")
        }
    }
}

struct RadioButtonExampler_Previews: PreviewProvider {
    static var previews: some View {
        RadioButtonExampler()
    }
}
