//
//  CreateTaskPresenter.swift
//  Taskerly
//
//  Created by Duc on 10/8/24.
//

import UIKit

protocol CreateTaskPresentationLogic {
    func presentIsLoading(isLoading: Bool)
    func presentError(response: CreateTask.ShowError.Response)
    func presentTask(response: CreateTask.ShowTask.Response)
    func presentValidateFormFields(respose: CreateTask.ValidateFormFields.Response)
    func presentCreatedTask(response: CreateTask.CreateTask.Response)
}

class CreateTaskPresenter {
    init(view: any CreateTaskDisplayLogic) {
        self.view = view
    }

    private let view: CreateTaskDisplayLogic
}

extension CreateTaskPresenter: CreateTaskPresentationLogic {
    func presentIsLoading(isLoading: Bool) {
        view.displayLoading(isLoading: isLoading)
    }

    func presentError(response: CreateTask.ShowError.Response) {
        view.displayError(viewModel: .init(error: .error(response.error)))
    }

    func presentTask(response: CreateTask.ShowTask.Response) {
        let task = response.task
        var formFields = CreateTaskFormField()
        formFields.name = task.name
        formFields.date = task.timestamp
        formFields.desc = task.desc
        switch task.category {
        case .personal:
            formFields.category = task.category.toString()
            formFields.customCategory = ""
        case .work:
            formFields.category = task.category.toString()
            formFields.customCategory = ""
        case .custom(let string):
            formFields.category = "Custom"
            formFields.customCategory = string
        }
        formFields.priority = task.priority
        formFields.reminder = task.reminder
        view.displayTask(viewModel: .init(
            title: "Edit Task",
            buttonTitle: "Save",
            formFields: formFields,
            task: task
        ))
    }

    func presentValidateFormFields(respose: CreateTask.ValidateFormFields.Response) {
        view.displayCreateButton(viewModel: .init(isButtonDisabled: !respose.isValid))
    }

    func presentCreatedTask(response: CreateTask.CreateTask.Response) {
        view.displayCreatedTask(viewModel: .init())
    }
}
