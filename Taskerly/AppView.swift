//
//  AppView.swift
//  Taskerly
//
//  Created by Duc on 9/8/24.
//

import SwiftData
import SwiftUI

struct AppView: View {
    @State private var router = Router.shared

    var body: some View {
        NavigationStack(path: $router.path) {
            ProgressView()
                .onAppear {
                    router.pop(to: .list)
                }
                .navigationDestination(for: Route.self) {
                    switch $0 {
                    case .list:
                        TaskListView()
                            .configured()
                    case .create:
                        CreateTaskView()
                            .configured()
                    case .detail(let task):
                        CreateTaskView()
                            .configured(task: task)
                    }
                }
        }
        .tint(Color.purple)
    }
}

extension UINavigationController {
    override open func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        navigationBar.topItem?.backButtonDisplayMode = .minimal
    }
}
