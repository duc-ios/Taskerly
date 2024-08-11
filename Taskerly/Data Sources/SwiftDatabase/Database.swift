//
//  Database.swift
//  Taskerly
//
//  Created by Duc on 10/8/24.
//

import Foundation

protocol Database<Model> {
    associatedtype Model
    func create(_ items: Model...) throws
    func create(_ items: [Model]) throws
    func read(predicate: Predicate<Model>?, sortBy sortDescriptors: SortDescriptor<Model>...) async throws -> [Model]
    func update(_ item: Model) throws
    func delete(_ items: Model...) throws
    func delete(_ items: [Model]) throws
}
