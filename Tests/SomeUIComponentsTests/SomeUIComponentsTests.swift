import Testing
@testable import SomeUIComponents
import SwiftUI

@MainActor
final class TestBindable<Value>: ObservableObject {
    @Published var value: Value
    init(_ initial: Value) { value = initial }

    var binding: Binding<Value> {
        Binding(get: { self.value }, set: { self.value = $0 })
    }
}
