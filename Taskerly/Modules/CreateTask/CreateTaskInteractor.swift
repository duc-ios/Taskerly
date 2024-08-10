//
//  CreateTaskInteractor.swift
//  Taskerly
//
//  Created by Duc on 10/8/24.
//

import SwiftData
import SwiftUI

protocol CreateTaskBusinessLogic {
    func showLoading(isLoading: Bool)
    func showError(request: CreateTask.ShowError.Request)
    func showTask(request: CreateTask.ShowTask.Request)
    func validateFormFields(request: CreateTask.ValidateFormFields.Request)
    func createTask(request: CreateTask.CreateTask.Request)
}

class CreateTaskInteractor {
    init(presenter: CreateTaskPresentationLogic,
         modelContext: ModelContext) {
        self.presenter = presenter
        self.modelContext = modelContext
    }

    private let presenter: CreateTaskPresentationLogic
    private let modelContext: ModelContext
}

extension CreateTaskInteractor: CreateTaskBusinessLogic {
    func showLoading(isLoading: Bool) {
        presenter.presentIsLoading(isLoading: isLoading)
    }

    func showError(request: CreateTask.ShowError.Request) {
        presenter.presentError(response: .init(error: request.error))
    }

    func showTask(request: CreateTask.ShowTask.Request) {
        if let task = request.task {
            presenter.presentTask(response: .init(task: task))
        }
    }

    func validateFormFields(request: CreateTask.ValidateFormFields.Request) {
        let formFields = request.formFields
        let isValid = !formFields.name.isEmpty
            && !formFields.desc.isEmpty
            && !formFields.category.isEmpty
            && (formFields.category != "Custom" || !formFields.customCategory.isEmpty)
        presenter.presentValidateFormFields(respose: .init(isValid: isValid))
    }

    func createTask(request: CreateTask.CreateTask.Request) {
        do {
            var category = TaskCategory(rawValue: request.category) ?? .personal
            if request.category == "Custom" {
                category = .custom(request.customCategory)
            }
            var task: TaskItem
            // swiftlint:disable:next identifier_name
            if let _task = request.task {
                task = _task
                task.timestamp = request.date
                task.name = request.name.isEmpty ? "Task" : request.name
                task.desc = request.desc
                task.rawCategory = category.rawValue
                task.rawPriority = request.priority.rawValue
                task.rawReminder = request.reminder.rawValue
                try modelContext.save()
            } else {
                task = TaskItem(
                    timestamp: request.date,
                    name: request.name.isEmpty ? "Task" : request.name,
                    desc: request.desc,
                    category: category,
                    priority: request.priority,
                    status: .pending,
                    reminder: request.reminder,
                    order: 0
                )
                modelContext.insert(task)
            }
            if request.reminder != .none {
                let content = UNMutableNotificationContent()
                content.title = task.name
                content.subtitle = task.desc
                content.sound = UNNotificationSound.default
                var dateComponents = Calendar.current.dateComponents(
                    [.year, .month, .day, .hour, .minute],
                    from: task.timestamp
                )
                switch task.reminder {
                case .fiveMinutes:
                    dateComponents.minute! -= 5
                case .tenMinutes:
                    dateComponents.minute! -= 10
                case .oneHour:
                    dateComponents.hour! -= 1
                case .oneDay:
                    dateComponents.day! -= 1
                default:
                    break
                }
                let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: false)
                let request = UNNotificationRequest(
                    identifier: task.id,
                    content: content, trigger: trigger
                )
                UNUserNotificationCenter.current().removePendingNotificationRequests(withIdentifiers: [task.id])
                UNUserNotificationCenter.current().add(request)
            }
            presenter.presentCreatedTask(response: .init())
        } catch {
            debugPrint("Create error", error)
            presenter.presentError(response: .init(error: error))
        }
    }
}
