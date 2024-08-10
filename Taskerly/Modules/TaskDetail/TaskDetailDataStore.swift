//
//  TaskDetailDataStore.swift
//  Taskerly
//
//  Created by Duc on 10/8/24.
//

import Foundation

final class TaskDetailDataStore: ObservableObject {
    @Published var isLoading = false
    @Published var errorMessage: String?
    @Published var displayError = false

    var task: TaskItem!
}
