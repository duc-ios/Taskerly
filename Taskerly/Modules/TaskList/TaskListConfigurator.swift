//
//  TaskListConfigurator.swift
//  Taskerly
//
//  Created by Duc on 9/8/24.
//  Created by Duc on 9/8/24.
//

import Foundation
import SwiftData

extension TaskListView {
    func configured(
        modelContext: ModelContext
    ) -> TaskListView {
        var view = self
        let presenter = TaskListPresenter(view: view)
        let interactor = TaskListInteractor(
            presenter: presenter,
            modelContext: modelContext
        )
        view.interactor = interactor
        return view
    }
}
