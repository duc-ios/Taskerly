//
//  TaskDetailModel.swift
//  Taskerly
//
//  Created by Duc on 10/8/24.
//

import Foundation

// swiftlint:disable nesting
enum TaskDetail {
    enum ShowError {
        struct Request {
            var error: Error
        }

        struct Response {
            var error: Error
        }

        struct ViewModel {
            var error: AppError
        }
    }
}
// swiftlint:enable nesting
