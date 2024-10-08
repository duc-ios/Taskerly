//
//  TaskListPresenter.swift
//  Taskerly
//
//  Created by Duc on 9/8/24.
//

import Foundation

protocol TaskListPresentationLogic {
    func presentIsLoading(isLoading: Bool)
    func presentError(response: TaskList.ShowError.Response)
    func presentGreeting(response: TaskList.GetGreeting.Response)
    func presentTasks(response: TaskList.FetchTasks.Response)
}

class TaskListPresenter {
    init(view: any TaskListDisplayLogic) {
        self.view = view
    }

    private let view: TaskListDisplayLogic
}

extension TaskListPresenter: TaskListPresentationLogic {
    func presentIsLoading(isLoading: Bool) {
        view.displayLoading(isLoading: isLoading)
    }

    func presentError(response: TaskList.ShowError.Response) {
        view.displayError(viewModel: .init(error: .error(response.error)))
    }

    func presentGreeting(response: TaskList.GetGreeting.Response) {
        view.displayGreeting(viewModel: .init(greetingText: response.greetingText))
    }

    func presentTasks(response: TaskList.FetchTasks.Response) {
        view.displayTasks(viewModel: .init(
            animated: response.animated,
            tab: response.tab,
            tasks: response.tasks
        ))
    }
}
