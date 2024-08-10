//
//  CreateTaskDataStore.swift
//  Taskerly
//
//  Created by Duc on 10/8/24.
//

import Foundation

final class CreateTaskDataStore: ObservableObject {
    var task: TaskItem?

    @Published var isLoading = false
    @Published var errorMessage: String?
    @Published var displayError = false

    @Published var formFields = CreateTaskFormField()
    @Published var title = "Create a Task"
    @Published var buttonTitle = "Create Task"
    @Published var isButtonDisabled = true
}

struct CreateTaskFormField: Equatable {
    var name = ""
    var date = Date()
    var desc = ""
    var category = "Personal"
    var customCategory = ""
    var priority = TaskItem.Priority.none
    var reminder = TaskItem.Reminder.none
}
