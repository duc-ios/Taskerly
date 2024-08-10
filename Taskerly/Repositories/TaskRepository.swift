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
    func delete(task: TaskItem)
    func createTask(with formFields: CreateTaskFormField) -> TaskItem
    func update(task: TaskItem, formFields: CreateTaskFormField) throws -> TaskItem
    func updateOrder(tasks: [TaskItem]) throws
    func mark(task: TaskItem, status: TaskItem.Status) throws
}

class LocalTaskRepository: TaskRepository {
    let modelContext: ModelContext

    init(modelContext: ModelContext) {
        self.modelContext = modelContext
    }

    private func safeSave(task: TaskItem) throws {
        if let modelContext = task.modelContext {
            try modelContext.save()
        } else {
            modelContext.insert(task)
        }
    }

    func fetch(status: TaskItem.Status? = nil) throws -> [TaskItem] {
        let descriptor: FetchDescriptor<TaskItem>
        if let status = status {
            descriptor = FetchDescriptor<TaskItem>(
                predicate: #Predicate { $0.rawStatus == status.rawValue },
                sortBy: [SortDescriptor(\.order), SortDescriptor(\.timestamp)]
            )
        } else {
            descriptor = FetchDescriptor<TaskItem>(
                sortBy: [SortDescriptor(\.order), SortDescriptor(\.timestamp)]
            )
        }
        return try modelContext.fetch(descriptor)
    }

    func delete(task: TaskItem) {
        modelContext.delete(task)
    }

    func createTask(with formFields: CreateTaskFormField) -> TaskItem {
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
        modelContext.insert(task)
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
        try safeSave(task: task)
        return task
    }

    func updateOrder(tasks: [TaskItem]) throws {
        try tasks.enumerated().forEach { task in
            task.element.order = task.offset
            try safeSave(task: task.element)
        }
    }

    func mark(task: TaskItem, status: TaskItem.Status) throws {
        task.rawStatus = status.rawValue
        try safeSave(task: task)
    }
}
