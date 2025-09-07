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
            buttonStyleOverride: SomeRadioSymbolStyle(color: .green, type: .dot),
            buttons: selections.indices.map { i in
                SomeRadioButton(text: "Option \(i+1)", isSelected: $selections[i], isDisabled: i == 2 ? .constant(true) : .constant(false))
            })
            .onSelectionChangeAttempt { index, newState in
                print("!!! Check for change availability")
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
