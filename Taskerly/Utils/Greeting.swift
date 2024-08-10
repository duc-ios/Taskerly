//
//  Greeting.swift
//  Taskerly
//
//  Created by Duc on 9/8/24.
//

import Foundation

struct Greeting {
    func hello() -> String {
        let hour = Calendar.current.component(.hour, from: Date())
        switch hour {
        case 5..<12:
            return "Good Morning!"
        case 12..<17:
            return "Good Afternoon!"
        default:
            return "Good Evening!"
        }
    }
}
