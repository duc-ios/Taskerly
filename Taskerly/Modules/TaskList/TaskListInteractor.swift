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
    init(presenter: TaskListPresentationLogic,
         modelContext: ModelContext) {
        self.presenter = presenter
        self.modelContext = modelContext
    }

    private let presenter: TaskListPresentationLogic
    private let modelContext: ModelContext
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
            let descriptor: FetchDescriptor<TaskItem>
            if let status = request.status {
                descriptor = FetchDescriptor<TaskItem>(
                    predicate: #Predicate { $0.rawStatus == status.rawValue },
                    sortBy: [SortDescriptor(\.order), SortDescriptor(\.timestamp, order: .reverse)]
                )
            } else {
                descriptor = FetchDescriptor<TaskItem>(
                    sortBy: [SortDescriptor(\.order), SortDescriptor(\.timestamp, order: .reverse)]
                )
            }
            tasks = try modelContext.fetch(descriptor)
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
        modelContext.delete(request.task)
        tasks.removeAll(where: { $0.id == request.task.id })
        presenter.presentTasks(response: .init(
            tab: tab,
            tasks: tasks
        ))
    }

    func moveTasks(indices: IndexSet, newOffset: Int) {
        do {
            tasks.move(fromOffsets: indices, toOffset: newOffset)
            tasks.enumerated().forEach { $0.element.order = $0.offset }
            try modelContext.save()
        } catch {
            debugPrint("Move failed", error)
            presenter.presentError(response: .init(error: error))
        }
    }

    func markTask(request: TaskList.MarkTask.Request) {
        do {
            let task = request.task
            task.rawStatus = request.status.rawValue
            try modelContext.save()
            presenter.presentTasks(response: .init(tab: tab, tasks: tasks))
        } catch {
            debugPrint("Mark failed", error)
            presenter.presentError(response: .init(error: error))
        }
    }
}
