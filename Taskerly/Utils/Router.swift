//
//  Router.swift
//  Taskerly
//
//  Created by Duc on 12/8/24.
//

import Foundation
import SwiftUI

final class Router: ObservableObject {
    static let shared = Router()

    @Published var path = [Route]()

    func show(_ route: Route) {
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
