//
//  SwiftDatabase.swift
//  Taskerly
//
//  Created by Duc on 10/8/24.
//

import Foundation
import SwiftData

protocol SwiftDatabase: Database {
    associatedtype Model = PersistentModel
    var container: ModelContainer { get }
}

extension SwiftDatabase {
    func create<Model: PersistentModel>(_ items: Model...) throws {
        try create(items)
    }

    func create<Model: PersistentModel>(_ items: [Model]) throws {
        let context = ModelContext(container)
        for item in items {
            context.insert(item)
        }
        try context.save()
    }

    func read<Model: PersistentModel>(
        predicate: Predicate<Model>? = nil,
        sortBy sortDescriptors: SortDescriptor<Model>...
    ) throws -> [Model] {
        let context = ModelContext(container)
        let fetchDescriptor = FetchDescriptor<Model>(
            predicate: predicate,
            sortBy: sortDescriptors
        )
        return try context.fetch(fetchDescriptor)
    }

    func update<Model: PersistentModel>(_ item: Model) throws {
        let context = ModelContext(container)
        context.insert(item)
        try context.save()
    }

    func delete<Model: PersistentModel>(_ items: Model...) throws {
        try delete(items)
    }

    func delete<Model: PersistentModel>(_ items: [Model]) throws {
        let context = ModelContext(container)
        for item in items {
            let idToDelete = item.persistentModelID
            try context.delete(model: Model.self, where: #Predicate { item in
                item.persistentModelID == idToDelete
            })
        }
        try context.save()
    }
}
