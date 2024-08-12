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
    init(presenter: CreateTaskPresentationLogic, database: TaskItemDB? = nil) {
        self.presenter = presenter
        self.repository = LocalTaskRepository(database: database)
    }

    private let presenter: CreateTaskPresentationLogic
    private let repository: TaskRepository
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
        let isValid = !formFields.name.isBlank
            && !formFields.category.isBlank
            && (formFields.category != "Custom" || !formFields.customCategory.isBlank)
        presenter.presentValidateFormFields(respose: .init(isValid: isValid))
    }

    func createTask(request: CreateTask.CreateTask.Request) {
        do {
            let task: TaskItem
            if let taskToUpdate = request.task {
                task = try repository.update(task: taskToUpdate, formFields: request.formFields)
            } else {
                task = try repository.createTask(with: request.formFields)
            }
            if request.formFields.reminder != .none {
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
            logger.debug("Create error \(error)")
            presenter.presentError(response: .init(error: error))
        }
    }
}
