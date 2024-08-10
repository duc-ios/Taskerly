//
//  TaskDetailInteractor.swift
//  Taskerly
//
//  Created by Duc on 10/8/24.
//

import SwiftUI

protocol TaskDetailBusinessLogic {
    func showLoading(isLoading: Bool)
    func showError(request: TaskDetail.ShowError.Request)
}

class TaskDetailInteractor {
    init(presenter: TaskDetailPresentationLogic) {
        self.presenter = presenter
    }

    private let presenter: TaskDetailPresentationLogic
}

extension TaskDetailInteractor: TaskDetailBusinessLogic {
    func showLoading(isLoading: Bool) {
        presenter.presentIsLoading(isLoading: isLoading)
    }

    func showError(request: TaskDetail.ShowError.Request) {
        presenter.presentError(response: .init(error: request.error))
    }
}
