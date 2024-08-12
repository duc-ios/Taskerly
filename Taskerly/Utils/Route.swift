//
//  Route.swift
//  Taskerly
//
//  Created by Duc on 10/8/24.
//

import Observation

enum Route: Hashable {
    case list
    case create
    case detail(TaskItem)
}
