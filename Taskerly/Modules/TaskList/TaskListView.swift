//
//  TaskListView.swift
//  Taskerly
//
//  Created by Duc on 9/8/24.
//

import SwiftData
import SwiftUI

protocol TaskListDisplayLogic {
    func displayLoading(isLoading: Bool)
    func displayError(viewModel: TaskList.ShowError.ViewModel)
    func displayGreeting(viewModel: TaskList.GetGreeting.ViewModel)
    func displayTasks(viewModel: TaskList.FetchTasks.ViewModel)
}

extension TaskListView: TaskListDisplayLogic {
    func displayLoading(isLoading: Bool) {
        store.isLoading = isLoading
    }

    func displayError(viewModel: TaskList.ShowError.ViewModel) {
        store.errorMessage = viewModel.message
        store.displayError = true
    }

    func displayGreeting(viewModel: TaskList.GetGreeting.ViewModel) {
        store.greeting = viewModel.greetingText
    }

    func displayTasks(viewModel: TaskList.FetchTasks.ViewModel) {
        store.tab = viewModel.tab
        if viewModel.animated {
            withAnimation {
                store.tasks = viewModel.tasks
            }
        } else {
            store.tasks = viewModel.tasks
        }
    }
}

extension TaskListView {
    enum Tab: CaseIterable, SegmentedControlItem {
        case pending, completed, all

        func toString() -> String {
            switch self {
            case .all:
                return "All"
            case .pending:
                return "Pending"
            case .completed:
                return "Completed"
            }
        }

        func toStatus() -> TaskItem.Status? {
            switch self {
            case .all:
                return nil
            case .pending:
                return .pending
            case .completed:
                return .completed
            }
        }
    }
}

struct TaskListView: View {
    @ObservedObject var store = TaskListDataStore()
    var interactor: TaskListBusinessLogic!

    @Environment(\.safeAreaInsets) private var safeAreaInsets

    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            VStack(spacing: 0) {
                Color.clear.frame(height: safeAreaInsets.top)

                HStack {
                    Text(store.greeting).font(.largeTitle.weight(.semibold))

                    Spacer()

                    LinearButton(label: { Text("+ Add Task") }, action: {
                        Router.shared.navigate(to: .create)
                    })
                }

                Spacer().frame(height: 24)

                SegmentedControl(
                    items: Tab.allCases,
                    selected: store.tab,
                    onSelected: {
                        switch $0 {
                        case .all:
                            interactor.fetchTasks(request: .init(animated: false, status: nil))
                        case .pending:
                            interactor.fetchTasks(request: .init(animated: false, status: .pending))
                        case .completed:
                            interactor.fetchTasks(request: .init(animated: false, status: .completed))
                        }
                    }
                )

                Spacer().frame(height: 8)
            }
            .padding(.horizontal)
            .background(.white)
            .clipShape(.rect(
                topLeadingRadius: 0,
                bottomLeadingRadius: 20,
                bottomTrailingRadius: 20,
                topTrailingRadius: 0
            ))

            Group {
                Text("Tasks")
                    .font(.title2.weight(.semibold))
                    .padding()

                if store.tasks.isEmpty {
                    Spacer()
                    Text("No Data").frame(maxWidth: .infinity, alignment: .center)
                    Spacer()
                } else {
                    List {
                        ForEach(store.tasks) { task in
                            TaskListCard(task: task)
                                .swipeActions {
                                    Button("Delete") {
                                        interactor.deleteTask(request: .init(task: task))
                                    }.tint(.red)
                                    if task.status == .pending {
                                        Button("Complete") {
                                            interactor.markTask(request: .init(task: task, status: .completed))
                                        }.tint(.blue)
                                    } else {
                                        Button("Pending") {
                                            interactor.markTask(request: .init(task: task, status: .pending))
                                        }.tint(.orange)
                                    }
                                }
                        }
                        .onMove(perform: interactor.moveTasks)
                    }
                    .listStyle(.plain)
                    .background(.clear)
                }
            }
        }
        .background(Color.background)
        .ignoresSafeArea(edges: .top)
        .navigationBarBackButtonHidden(true)
        .onAppear {
            interactor.fetchTasks(request: .init(status: store.tab.toStatus()))
        }
    }
}

#if DEBUG
#Preview {
    // swiftlint:disable:next force_try
    let container = try! ModelContainer(
        for: TaskItem.self,
        configurations: .init(isStoredInMemoryOnly: true)
    )
    return NavigationView {
        TaskListView()
            .configured(modelContext: container.mainContext)
    }
}
#endif
