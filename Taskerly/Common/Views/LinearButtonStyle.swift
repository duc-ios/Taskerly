//
//  LinearButtonStyle.swift
//  Taskerly
//
//  Created by Duc on 9/8/24.
//

import SwiftUI

struct LinearButtonStyle: ButtonStyle {
    @Environment(\.isEnabled) var isEnabled

    func makeBody(configuration: Configuration) -> some View {
        configuration
            .label
            .padding()
            .font(.caption.weight(.semibold))
            .foregroundStyle(Color.white)
            .background(Capsule().foregroundStyle(Color.gradient).opacity(isEnabled ? 1 : 0.5))
            .sensoryFeedback(.success, trigger: configuration.isPressed)
    }
}

#Preview {
    Button(action: {}, label: { Text("Linear Button") })
        .buttonStyle(LinearButtonStyle())
}
