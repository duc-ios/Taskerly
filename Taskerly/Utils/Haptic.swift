//
//  Haptic.swift
//  Taskerly
//
//  Created by Duc on 10/8/24.
//

import UIKit

struct Haptic {
    static func fire() {
        let generator = UINotificationFeedbackGenerator()
        generator.prepare()
        generator.notificationOccurred(.success)
    }
}
