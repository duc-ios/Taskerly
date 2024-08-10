//
//  CreateTaskConfigurator.swift
//  Taskerly
//
//  Created by Duc on 10/8/24.
//  Created by Duc on 10/8/24.
//

import SwiftData

extension CreateTaskView {
    func configured(
        modelContext: ModelContext,
        task: TaskItem? = nil
    ) -> CreateTaskView {
        var view = self
        let presenter = CreateTaskPresenter(view: view)
        let interactor = CreateTaskInteractor(
            presenter: presenter,
            modelContext: modelContext
        )
        view.interactor = interactor
        interactor.showTask(request: .init(task: task))
        interactor.validateFormFields(request: .init(formFields: view.store.formFields))
        return view
    }
}
