//
//  UserSettings.swift
//  Taskerly
//
//  Created by Duc on 11/8/24.
//

import SwiftUI

enum UserSettings {
    @AppStorage("isOnboarded") static var isOnboarded: Bool = false
}
