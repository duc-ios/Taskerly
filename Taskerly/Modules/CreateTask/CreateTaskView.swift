//
//  CreateTaskView.swift
//  Taskerly
//
//  Created by Duc on 10/8/24.
//

import SwiftData
import SwiftUI

protocol CreateTaskDisplayLogic {
    func displayLoading(isLoading: Bool)
    func displayError(viewModel: CreateTask.ShowError.ViewModel)
    func displayTask(viewModel: CreateTask.ShowTask.ViewModel)
    func displayCreateButton(viewModel: CreateTask.ValidateFormFields.ViewModel)
    func displayCreatedTask(viewModel: CreateTask.CreateTask.ViewModel)
}

extension CreateTaskView: CreateTaskDisplayLogic {
    func displayLoading(isLoading: Bool) {
        store.isLoading = isLoading
    }

    func displayError(viewModel: CreateTask.ShowError.ViewModel) {
        store.errorMessage = viewModel.message
        store.displayError = true
    }

    func displayTask(viewModel: CreateTask.ShowTask.ViewModel) {
        store.title = viewModel.title
        store.buttonTitle = viewModel.buttonTitle
        store.formFields = viewModel.formFields
        store.task = viewModel.task
    }

    func displayCreateButton(viewModel: CreateTask.ValidateFormFields.ViewModel) {
        store.isButtonDisabled = viewModel.isButtonDisabled
    }

    func displayCreatedTask(viewModel: CreateTask.CreateTask.ViewModel) {
        path.removeLast()
    }
}

struct CreateTaskView: View {
    var interactor: CreateTaskBusinessLogic!
    @Binding var path: [Route]

    @ObservedObject var store = CreateTaskDataStore()
    @Environment(\.safeAreaInsets) private var safeAreaInsets

    init(path: Binding<[Route]>) {
        _path = path
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
        ScrollView {
            VStack(alignment: .leading) {
                Color.clear.frame(height: safeAreaInsets.top + 22)

                DatePicker("", selection: $store.formFields.date)
                    .datePickerStyle(.graphical)
                    .colorInvert()
            }
            .foregroundStyle(.white)
            .padding(.horizontal, 24)
            .padding(.bottom, 32)
            .background(Color.gradient)

            Color.white
                .clipShape(.rect(topLeadingRadius: 12, topTrailingRadius: 12))
                .offset(.init(width: 0, height: -24))
                .frame(height: 24)

            Group {
                Field(label: "Name", text: $store.formFields.name)
                MultilineField(label: "Description", text: $store.formFields.desc)

                let items = [TaskCategory.personal, .work].map { $0.toString() } + ["Custom"]
                ValuePicker(
                    label: "Category",
                    selection: $store.formFields.category,
                    items: items
                )

                if store.formFields.category == "Custom" {
                    TextField("Category", text: $store.formFields.customCategory)
                }

                ValuePicker(
                    label: "Priority",
                    selection: $store.formFields.priority,
                    items: TaskItem.Priority.allCases
                )

                ValuePicker(
                    label: "Reminder",
                    selection: $store.formFields.reminder,
                    items: TaskItem.Reminder.allCases
                )

                Spacer().frame(height: 24)

                LinearButton(label: {
                    Text(store.buttonTitle)
                        .font(.body.weight(.semibold))
                        .frame(maxWidth: .infinity)
                }, action: {
                    interactor.createTask(request: .init(
                        task: store.task,
                        name: store.formFields.name,
                        date: store.formFields.date,
                        desc: store.formFields.desc,
                        category: store.formFields.category,
                        customCategory: store.formFields.customCategory,
                        priority: store.formFields.priority,
                        reminder: store.formFields.reminder
                    ))
                }, isDisabled: store.isButtonDisabled)
                .listRowBackground(Color.clear)
            }
            .padding(.horizontal, 44)
        }
        .ignoresSafeArea(edges: .top)
        .listStyle(.plain)
        .navigationTitle(store.title)
        .navigationBarTitleDisplayMode(.inline)
        .tint(.black)
        .navigationBarBackButtonHidden(true)
        .toolbar {
            ToolbarItem(placement: .topBarLeading) {
                Button(action: {
                    path.removeLast()
                }, label: {
                    Image(systemName: "chevron.left")
                        .font(.body.weight(.semibold))
                        .foregroundStyle(.white)
                })
            }
        }
        .onChange(of: store.formFields) {
            Haptic.fire()
            interactor.validateFormFields(request: .init(formFields: store.formFields))
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
    return NavigationStack {
        CreateTaskView(path: .constant([]))
            .configured(modelContext: container.mainContext)
    }
}
#endif
