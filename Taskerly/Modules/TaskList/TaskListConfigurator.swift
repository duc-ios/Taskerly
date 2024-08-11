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
    func configured(database: TaskItemDB? = nil) -> TaskListView {
        var view = self
        let presenter = TaskListPresenter(view: view)
        let interactor = TaskListInteractor(presenter: presenter, database: database)
        view.interactor = interactor
        return view
    }
}
