//
//  CreateTaskModel.swift
//  Taskerly
//
//  Created by Duc on 10/8/24.
//

import Foundation

// swiftlint:disable nesting
enum CreateTask {
    enum ShowError {
        struct Request {
            var error: Error
        }

        struct Response {
            var error: Error
        }

        struct ViewModel {
            var message: String
        }
    }

    enum ShowTask {
        struct Request {
            var task: TaskItem?
        }

        struct Response {
            var task: TaskItem
        }

        struct ViewModel {
            var title: String
            var buttonTitle: String
            var formFields: CreateTaskFormField
            var task: TaskItem
        }
    }

    enum ValidateFormFields {
        struct Request {
            var formFields: CreateTaskFormField
        }

        struct Response {
            var isValid: Bool
        }

        struct ViewModel {
            var isButtonDisabled: Bool
        }
    }

    enum CreateTask {
        struct Request {
            var task: TaskItem?
            var name: String
            var date: Date
            var desc: String
            var category: String
            var customCategory: String
            var priority: TaskItem.Priority
            var reminder: TaskItem.Reminder
        }

        struct Response {}

        struct ViewModel {}
    }
}

// swiftlint:enable nesting
