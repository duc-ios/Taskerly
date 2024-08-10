//
//  AppView.swift
//  Taskerly
//
//  Created by Duc on 9/8/24.
//

import SwiftData
import SwiftUI

struct AppView: View {
    @Environment(\.modelContext) var modelContext
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
                            .configured(modelContext: modelContext)
                    case .create:
                        CreateTaskView()
                            .configured(modelContext: modelContext)
                    case .detail(let task):
                        CreateTaskView()
                            .configured(modelContext: modelContext, task: task)
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
