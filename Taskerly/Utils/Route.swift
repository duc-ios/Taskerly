//
//  Route.swift
//  Taskerly
//
//  Created by Duc on 10/8/24.
//

import Observation
import SwiftUI

enum Route: Hashable {
    case list
    case create
    case detail(TaskItem)
}

extension [Route] {
    mutating func navigate(to route: Route) {
        append(route)
    }

    mutating func pop(to route: Route) {
        if let idx = lastIndex(where: { $0 == route }) {
            self = Array(self[0 ... idx])
        } else {
            self = [.list]
        }
    }

    mutating func pop() {
        removeLast()
    }

    mutating func popToRoot() {
        removeLast(count)
    }
}

@Observable class Router {
    static let shared = Router()

    var path = [Route]()

    func navigate(to route: Route) {
        path.append(route)
    }

    func pop(to route: Route) {
        if let idx = path.lastIndex(where: { $0 == route }) {
            path = Array(path[0 ... idx])
        } else {
            path = [.list]
        }
    }

    func pop() {
        path.removeLast()
    }

    func popToRoot() {
        path.removeLast(path.count)
    }
}
