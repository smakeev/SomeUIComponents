//
//  RadioButtonExampler.swift
//  SomeUIComponentsExample
//
//  Created by Sergey Makeev on 06.09.2025.
//

import SwiftUI
import SomeUIComponents

struct RadioButtonExampler: View {
    @State var isSelected: Bool = false

    var body: some View {
        VStack {
            SomeRadioButton(isSelected: $isSelected, label: AnyView(Text("Default style")))
            SomeRadioButton(isSelected: $isSelected, style:  SomeRadioSymbolStyle(type: .fill(onColor: .green, offColor: .gray)), textPosition: .left,
                            label: AnyView(Text("Left, system"))) { _ in
                print("DefaultPressed")
            }
            SomeRadioButton(isSelected: $isSelected, style:  SomeRadioSymbolStyle(type: .dotted(onColor: .green, offColor: .red)), textPosition: .automatic, label: AnyView(Text("Left, filled")))
            SomeRadioButton(isSelected: $isSelected, style:  SomeRadioSymbolStyle(type: .checkmark(onColor: .blue, offColor: .orange)), textPosition: .right, label: AnyView(Text("Left, filled"))).disabled(true)
        }
    }
}

struct RadioButtonExampler_Previews: PreviewProvider {
    static var previews: some View {
        RadioButtonExampler()
    }
}
