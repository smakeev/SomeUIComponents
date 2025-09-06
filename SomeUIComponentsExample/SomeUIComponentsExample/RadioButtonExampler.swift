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
            SomeRadioButton(text: "Left, system", isSelected: $isSelected, style:  SomeRadioSymbolStyle(color: .blue, type: SomeRadioSymbolStyleType.system), textPosition: .left) { _ in
                print("DefaultPressed")
            }
            SomeRadioButton(text: "Left, filled", isSelected: $isSelected, style:  SomeRadioSymbolStyle(color: .green, type: SomeRadioSymbolStyleType.dotted), textPosition: .left)
            SomeRadioButton(text: "Left, filled", isSelected: $isSelected, style:  SomeRadioSymbolStyle(color: .black, type: SomeRadioSymbolStyleType.checkmark), textPosition: .left)
            
        }
    }
}

struct RadioButtonExampler_Previews: PreviewProvider {
    static var previews: some View {
        RadioButtonExampler()
    }
}
