//
//  TaskDetailView.swift
//  Taskerly
//
//  Created by Duc on 10/8/24.
//

import SwiftUI

protocol TaskDetailDisplayLogic {
    func displayLoading(isLoading: Bool)
    func displayError(viewModel: TaskDetail.ShowError.ViewModel)
}

extension TaskDetailView: TaskDetailDisplayLogic {
    func displayLoading(isLoading: Bool) {
        store.isLoading = isLoading
    }

    func displayError(viewModel: TaskDetail.ShowError.ViewModel) {
        store.errorMessage = viewModel.message
        store.displayError = true
    }
}

struct TaskDetailView: View {
    @ObservedObject var store = TaskDetailDataStore()
    var interactor: TaskDetailBusinessLogic!

    @Environment(\.safeAreaInsets) var safeAreaInsets

    init() {
        let standardAppearance = UINavigationBarAppearance()
        standardAppearance.configureWithTransparentBackground()
        standardAppearance.titleTextAttributes = [
            .foregroundColor: UIColor.clear
        ]
        let scrollEdgeAppearance = UINavigationBarAppearance()
        scrollEdgeAppearance.configureWithTransparentBackground()
        scrollEdgeAppearance.titleTextAttributes = [
            .foregroundColor: UIColor.white,
            .font: UIFont.preferredFont(forTextStyle: .body)
        ]
        UINavigationBar.appearance().standardAppearance = standardAppearance
        UINavigationBar.appearance().scrollEdgeAppearance = scrollEdgeAppearance
        UIScrollView.appearance().bounces = false
    }

    var body: some View {
        if let task = store.task {
            ScrollView {
                VStack(alignment: .leading) {
                    Color.clear
                        .frame(height: safeAreaInsets.top + 44)
                    TaskDetailCard(title: "Name", detail: task.name)
                    TaskDetailCard(
                        title: "Due date",
                        detail: task.timestamp.formatted(date: .numeric, time: .shortened)
                    )
                    Spacer().frame(height: 12)
                }
                .foregroundStyle(.white)
                .padding()
                .background(Color.gradient)

                Color.white
                    .clipShape(.rect(topLeadingRadius: 12, topTrailingRadius: 12))
                    .offset(.init(width: 0, height: -24))
                    .frame(height: 24)

                VStack(alignment: .leading) {
                    Text("Description")
                        .font(.caption)
                    Text(task.desc)
                    TaskDetailCard(title: "Priority", detail: task.priority.toString())
                    TaskDetailCard(title: "Category", detail: task.category.toString())
                    TaskDetailCard(title: "Status", detail: task.status.toString())
                }.padding(.horizontal, 44)
            }
            .ignoresSafeArea(edges: .top)
            .navigationTitle("Task")
            .navigationBarTitleDisplayMode(.inline)
        } else {
            ProgressView()
        }
    }
}

#if DEBUG
#Preview {
    NavigationStack {
        // swiftlint:disable:next force_try
        let database = try! TaskItemDB(useInMemoryStore: true)
        TaskDetailView()
            .configured(
                task: TaskItem(
                    timestamp: Date(),
                    name: "Name",
                    // swiftlint:disable:next line_length
                    desc: "Description Description Description Description Description Description Description Description Description Description Description Description Description Description"
                )
            )
    }
}
#endif
