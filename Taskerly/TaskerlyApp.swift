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

    private let sharedModelContainer: ModelContainer = {
        let schema = Schema([
            TaskItem.self
        ])
        let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: false)
        func setup() -> ModelContainer {
            do {
                let container = try ModelContainer(
                    for: schema,
                    configurations: modelConfiguration)
                debugPrint(modelConfiguration.url)
                return container
            } catch {
                debugPrint("Could not create ModelContainer: \(error)")
                try? FileManager.default.removeItem(at: modelConfiguration.url)
                return setup()
            }
        }
        return setup()
    }()

    var body: some Scene {
        WindowGroup {
            AppView()
                .modelContainer(sharedModelContainer)
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
