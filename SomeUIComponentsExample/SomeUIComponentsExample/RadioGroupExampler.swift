//
//  RadioGroupExampler.swift
//  SomeUIComponentsExample
//
//  Created by Sergey Makeev on 06.09.2025.
//

import SwiftUI
import SomeUIComponents

struct RadioGroupExampler: View {
    @State private var selections: [Bool] = [false, false, false, false, false, false]

    var body: some View {
        SomeRadioGroup(
            selectionStyle: .multiple(max: 1),
            minSelectCount: 1,
            titleView: Text("Radio Group"),
            buttonStyleOverride: SomeRadioSymbolStyle(color: .black, type: .checkmark),
            buttons: selections.indices.map { i in
                SomeRadioButton(text: "Option \(i+1)", isSelected: $selections[i])
            }) .padding()
    }
}

struct RadioGroupExampler_Previews: PreviewProvider {
    static var previews: some View {
        RadioGroupExampler()
    }
}
