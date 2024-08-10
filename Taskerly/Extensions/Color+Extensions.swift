//
//  Color+Extensions.swift
//  Taskerly
//
//  Created by Duc on 9/8/24.
//

import SwiftUI

extension Color {
    static let gradientPink = Color(hex: 0x9C2CF3)
    static let gradientPurple = Color(hex: 0x3A49F9)
    static let text = Color(hex: 0x2E3A59)
    static let background = Color(hex: 0xF2F5FF)
    static let background2 = Color(hex: 0xEFECFE)

    static let gradient = Gradient(colors: [.gradientPink, .gradientPurple])
}

extension Color {
    init(hex: UInt, alpha: Double = 1) {
        self.init(
            .sRGB,
            red: Double((hex >> 16) & 0xff) / 255,
            green: Double((hex >> 08) & 0xff) / 255,
            blue: Double((hex >> 00) & 0xff) / 255,
            opacity: alpha
        )
    }
}
