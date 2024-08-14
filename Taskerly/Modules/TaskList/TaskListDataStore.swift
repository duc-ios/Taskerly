//
//  TaskListDataStore.swift
//  Taskerly
//
//  Created by Duc on 9/8/24.
//

import Foundation

final class TaskListDataStore: ObservableObject {
    @Published var isLoading = false
    @Published var error: AppError?
    @Published var displayError = false

    @Published var tasks: [TaskItem] = []
    @Published var tab: TaskListView.Tab = .pending
    @Published var greeting: String = ""
}
