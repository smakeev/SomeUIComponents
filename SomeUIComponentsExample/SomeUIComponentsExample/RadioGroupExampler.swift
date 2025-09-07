//
//  RadioGroupExampler.swift
//  SomeUIComponentsExample
//
//  Created by Sergey Makeev on 06.09.2025.
//

import SwiftUI
import SomeUIComponents

struct RadioGroupExampler: View {
    @State private var selections: [Bool] = [true, true, true, true, true, false]

    var body: some View {
        SomeRadioGroup(
            selectionStyle: .all,//.multiple(max: 3),
            minSelectCount: 2,
            titleView: Text("Radio Group"),
            buttonStyleOverride: SomeRadioSymbolStyle(color: .black, type: .checkmark),
            buttons: selections.indices.map { i in
                SomeRadioButton(text: "Option \(i+1)", isSelected: $selections[i])
            })
            .onSelectionChangeAttempt
 { index, newState in
                guard index != 5 else { return false }
                return true
            }
            .padding()
    }
}

struct RadioGroupExampler_Previews: PreviewProvider {
    static var previews: some View {
        RadioGroupExampler()
    }
}
