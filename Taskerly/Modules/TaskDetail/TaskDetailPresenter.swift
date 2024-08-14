//
//  TaskDetailPresenter.swift
//  Taskerly
//
//  Created by Duc on 10/8/24.
//

import UIKit

protocol TaskDetailPresentationLogic {
    func presentIsLoading(isLoading: Bool)
    func presentError(response: TaskDetail.ShowError.Response)
}

class TaskDetailPresenter {
    init(view: any TaskDetailDisplayLogic) {
        self.view = view
    }

    private let view: TaskDetailDisplayLogic
}

extension TaskDetailPresenter: TaskDetailPresentationLogic {
    func presentIsLoading(isLoading: Bool) {
        view.displayLoading(isLoading: isLoading)
    }

    func presentError(response: TaskDetail.ShowError.Response) {
        view.displayError(viewModel: .init(error: .error(response.error)))
    }
}
