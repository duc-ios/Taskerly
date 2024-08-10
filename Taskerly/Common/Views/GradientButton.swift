//
//  GradientButton.swift
//  Taskerly
//
//  Created by Duc on 9/8/24.
//

import SwiftUI

struct LinearButton<T: View>: View {
    @ViewBuilder let label: () -> T
    var action: VoidCallback?
    var isDisabled: Bool = false

    var body: some View {
        Button(action: {
            Haptic.fire()
            action?()
        }, label: {
            label().padding()
        })
        .font(.caption.weight(.semibold))
        .foregroundStyle(Color.white)
        .background(Capsule().foregroundStyle(Color.gradient).opacity(isDisabled ? 0.5 : 1))
        .disabled(isDisabled)
    }
}

#Preview {
    LinearButton(label: { Text("Linear Button") })
}
