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
            SomeRadioButton(text: "Default, automatic", isSelected: $isSelected)
            SomeRadioButton(text: "Left, system", isSelected: $isSelected, style:  SomeRadioSymbolStyle(type: .fill(onColor: .green, offColor: .gray)), textPosition: .left) { _ in
                print("DefaultPressed")
            }
            SomeRadioButton(text: "Left, filled", isSelected: $isSelected, style:  SomeRadioSymbolStyle(type: .dotted(onColor: .green, offColor: .red)), textPosition: .automatic)
            SomeRadioButton(text: "Left, filled", isSelected: $isSelected, style:  SomeRadioSymbolStyle(type: .checkmark(onColor: .blue, offColor: .orange)), textPosition: .right).disabled(true)
            
        }
    }
}

struct RadioButtonExampler_Previews: PreviewProvider {
    static var previews: some View {
        RadioButtonExampler()
    }
}
