//
//  TaskListModel.swift
//  Taskerly
//
//  Created by Duc on 9/8/24.
//

import Foundation

// swiftlint:disable nesting
enum TaskList {
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

    enum FetchTasks {
        struct Request {
            var animated: Bool = true
            var status: TaskItem.Status?
        }

        struct Response {
            var animated: Bool = true
            var tab: TaskListView.Tab
            var tasks: [TaskItem]
        }

        struct ViewModel {
            var animated: Bool = true
            var tab: TaskListView.Tab
            var tasks: [TaskItem]
        }
    }

    enum DeleteTasks {
        struct Request {
            var task: TaskItem
        }

        struct Response {}

        struct ViewModel {}
    }

    enum MarkTask {
        struct Request {
            var task: TaskItem
            var status: TaskItem.Status
        }

        struct Response {}

        struct ViewModel {}
    }
}

// swiftlint:enable nesting
