//
//  TaskItemDB.swift
//  Taskerly
//
//  Created by Duc on 10/8/24.
//

import Foundation
import SwiftData

final class TaskItemDB: SwiftDatabase {
    typealias Model = TaskItem

    let container: ModelContainer

    /// Use an in-memory store to store non-persistent data when unit testing
    ///
    init(useInMemoryStore: Bool = false) {
        let configuration = ModelConfiguration(for: TaskItem.self, isStoredInMemoryOnly: useInMemoryStore)
        do {
            container = try ModelContainer(for: TaskItem.self, configurations: configuration)
        } catch {
            do {
                try FileManager.default.removeItem(at: configuration.url)
                container = try ModelContainer(for: TaskItem.self, configurations: configuration)
            } catch {
                fatalError("Failed to init database")
            }
        }
    }
}
