//
//  TaskListInteractor.swift
//  Taskerly
//
//  Created by Duc on 9/8/24.
//

import SwiftData
import SwiftUI

protocol TaskListBusinessLogic {
    func showLoading(isLoading: Bool)
    func showError(request: TaskList.ShowError.Request)
    func getGreeting(request: TaskList.GetGreeting.Request)
    func fetchTasks(request: TaskList.FetchTasks.Request)
    func deleteTask(request: TaskList.DeleteTasks.Request)
    func moveTasks(indices: IndexSet, newOffset: Int)
    func markTask(request: TaskList.MarkTask.Request)
}

class TaskListInteractor {
    init(presenter: TaskListPresentationLogic, database: TaskItemDB? = nil) {
        self.presenter = presenter
        self.repository = LocalTaskRepository(database: database)
    }

    private let presenter: TaskListPresentationLogic
    private let repository: TaskRepository

    private var tab: TaskListView.Tab = .pending
    private var tasks: [TaskItem] = []
}

extension TaskListInteractor: TaskListBusinessLogic {
    func showLoading(isLoading: Bool) {
        presenter.presentIsLoading(isLoading: isLoading)
    }

    func showError(request: TaskList.ShowError.Request) {
        presenter.presentError(response: .init(error: request.error))
    }

    func getGreeting(request: TaskList.GetGreeting.Request) {
        let greetingText = Greeting().text(date: request.date)
        presenter.presentGreeting(response: .init(greetingText: greetingText))
    }

    func fetchTasks(request: TaskList.FetchTasks.Request) {
        switch request.status {
        case .none:
            tab = .all
        case .pending:
            tab = .pending
        case .completed:
            tab = .completed
        }
        do {
            tasks = try repository.fetch(status: request.status)
            presenter.presentTasks(response: .init(
                animated: request.animated,
                tab: tab,
                tasks: tasks
            ))
        } catch {
            debugPrint("Fetch Failed", error)
            presenter.presentError(response: .init(error: error))
        }
    }

    func deleteTask(request: TaskList.DeleteTasks.Request) {
        do {
            try repository.delete(task: request.task)
            tasks.removeAll(where: { $0.id == request.task.id })
            presenter.presentTasks(response: .init(
                tab: tab,
                tasks: tasks
            ))
        } catch {
            debugPrint("Delete Failed", error)
            presenter.presentError(response: .init(error: error))
        }
    }

    func moveTasks(indices: IndexSet, newOffset: Int) {
        do {
            tasks.move(fromOffsets: indices, toOffset: newOffset)
            try repository.updateOrder(tasks: tasks)
        } catch {
            debugPrint("Move failed", error)
            presenter.presentError(response: .init(error: error))
        }
    }

    func markTask(request: TaskList.MarkTask.Request) {
        do {
            try repository.mark(task: request.task, status: request.status)
            if request.status == .pending && tab == .completed
                || request.status == .completed && tab == .pending {
                tasks.removeAll(where: { $0.id == request.task.id })
            }
            presenter.presentTasks(response: .init(tab: tab, tasks: tasks))
        } catch {
            debugPrint("Mark failed", error)
            presenter.presentError(response: .init(error: error))
        }
    }
}
