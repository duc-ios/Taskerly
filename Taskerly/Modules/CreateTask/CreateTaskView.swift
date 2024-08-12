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
        store.task = viewModel.task
        store.title = viewModel.title
        store.buttonTitle = viewModel.buttonTitle
        store.formFields = viewModel.formFields
    }

    func displayCreateButton(viewModel: CreateTask.ValidateFormFields.ViewModel) {
        store.isButtonDisabled = viewModel.isButtonDisabled
    }

    func displayCreatedTask(viewModel: CreateTask.CreateTask.ViewModel) {
        store.router?.pop(to: .list)
    }
}

struct CreateTaskView: View {
    var interactor: CreateTaskBusinessLogic!

    @ObservedObject var store = CreateTaskDataStore()
    @EnvironmentObject var router: Router
   @Environment(\.safeAreaInsets) private var safeAreaInsets

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
        store.router = router
        return ScrollView {
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

                Button(action: {
                    interactor.createTask(request: .init(
                        task: store.task,
                        formFields: store.formFields
                    ))
                }, label: {
                    Text(store.buttonTitle)
                        .font(.body.weight(.semibold))
                        .frame(maxWidth: .infinity)
                })
                .buttonStyle(LinearButtonStyle())
                .disabled(store.isButtonDisabled)
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
                    router.pop(to: .list)
                }, label: {
                    Image(systemName: "chevron.left")
                        .font(.body.weight(.semibold))
                        .foregroundStyle(.white)
                        .padding(.trailing, 16)
                        .padding(.vertical, 8)
//                        .background(.red)
                })
//                .background(.yellow)
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
    NavigationStack {
        // swiftlint:disable:next force_try
        CreateTaskView().configured(database: try! TaskItemDB(useInMemoryStore: true))
    }
}
#endif
