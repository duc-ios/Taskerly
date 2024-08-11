//
//  TaskDetailConfigurator.swift
//  Taskerly
//
//  Created by Duc on 10/8/24.
//  Created by Duc on 10/8/24.
//

import Foundation

extension TaskDetailView {
    func configured(task: TaskItem) -> TaskDetailView {
        var view = self
        let presenter = TaskDetailPresenter(view: view)
        let interactor = TaskDetailInteractor(presenter: presenter)
        view.interactor = interactor
        view.store.task = task
        return view
    }
}
