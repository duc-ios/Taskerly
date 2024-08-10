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
    @State private var path = [Route]()

    var body: some View {
        NavigationStack(path: $path) {
            ProgressView()
                .onAppear {
                    path.append(.list)
                }
                .navigationDestination(for: Route.self) {
                    switch $0 {
                    case .list:
                        TaskListView(path: $path)
                            .configured(modelContext: modelContext)
                    case .create:
                        CreateTaskView(path: $path)
                            .configured(modelContext: modelContext)
                    case .detail(let task):
                        CreateTaskView(path: $path)
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
