//
//  TaskRepository.swift
//  Taskerly
//
//  Created by Duc on 10/8/24.
//

import SwiftData
import SwiftUI

protocol TaskRepository {
    func fetch(status: TaskItem.Status?) throws -> [TaskItem]
    func delete(task: TaskItem) throws
    func createTask(with formFields: CreateTaskFormField) throws -> TaskItem
    func update(task: TaskItem, formFields: CreateTaskFormField) throws -> TaskItem
    func updateOrder(tasks: [TaskItem]) throws
    func mark(task: TaskItem, status: TaskItem.Status) throws
}

class LocalTaskRepository: TaskRepository {
    private let database: TaskItemDB

    init(database: TaskItemDB? = nil) {
        self.database = database ?? TaskItemDB()
    }

    func fetch(status: TaskItem.Status? = nil) throws -> [TaskItem] {
        if let status = status {
            return try database.read(
                predicate: #Predicate { $0.rawStatus == status.rawValue },
                sortBy: SortDescriptor(\.order), SortDescriptor(\.timestamp)
            )
        } else {
            return try database.read(
                sortBy: SortDescriptor(\.order), SortDescriptor(\.timestamp)
            )
        }
    }

    func delete(task: TaskItem) throws {
        try database.delete(task)
    }

    func createTask(with formFields: CreateTaskFormField) throws -> TaskItem {
        var category = TaskCategory(rawValue: formFields.category) ?? .personal
        if formFields.category == "Custom" {
            category = .custom(formFields.customCategory)
        }
        let task = TaskItem(
            timestamp: formFields.date,
            name: formFields.name.isEmpty ? "Task" : formFields.name,
            desc: formFields.desc,
            category: category,
            priority: formFields.priority,
            status: .pending,
            reminder: formFields.reminder,
            order: 0
        )
        try database.create(task)
        return task
    }

    func update(task: TaskItem, formFields: CreateTaskFormField) throws -> TaskItem {
        var category = TaskCategory(rawValue: formFields.category) ?? .personal
        if formFields.category == "Custom" {
            category = .custom(formFields.customCategory)
        }
        task.timestamp = formFields.date
        task.name = formFields.name.isEmpty ? "Task" : formFields.name
        task.desc = formFields.desc
        task.rawCategory = category.rawValue
        task.rawPriority = formFields.priority.rawValue
        task.rawReminder = formFields.reminder.rawValue
        try database.create(task)
        return task
    }

    func updateOrder(tasks: [TaskItem]) throws {
        try tasks.enumerated().forEach {
            $0.element.order = $0.offset
            try database.create($0.element)
        }
    }

    func mark(task: TaskItem, status: TaskItem.Status) throws {
        task.rawStatus = status.rawValue
        try database.create(task)
    }
}
