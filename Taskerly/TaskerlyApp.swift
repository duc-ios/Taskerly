//
//  TaskerlyApp.swift
//  Taskerly
//
//  Created by Duc on 9/8/24.
//

import SwiftData
import SwiftUI

@main
struct TaskerlyApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate

    var body: some Scene {
        WindowGroup {
            AppView()
        }
    }
}

class AppDelegate: NSObject, UIApplicationDelegate {
    func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]? = nil) -> Bool {
        NotificationsManager.shared.setup()
        return true
    }
}
