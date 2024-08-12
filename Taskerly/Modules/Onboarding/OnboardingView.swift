//
//  OnboardingView.swift
//  Taskerly
//
//  Created by Duc on 11/8/24.
//

import SwiftUI

struct OnboardingContentView: View {
    let title: String
    let image: String
    let description: String

    var body: some View {
        VStack {
            Image(systemName: image)
                .font(.largeTitle)
                .padding()
                .foregroundStyle(Color.gradientPink)
            Text(title)
                .font(.headline)
            Text(description)
                .multilineTextAlignment(.center)
                .padding()
                .foregroundStyle(.gray)
        }
        .frame(height: 300)
        .background(.white)
        .clipShape(RoundedRectangle(cornerRadius: 25.0))
        .padding()
    }
}

struct OnboardingView: View {
    @EnvironmentObject var router: Router
    @State private var selectedIndex = 0

    var body: some View {
        VStack {
            Text("Taskerly")
                .font(.largeTitle.weight(.semibold))
                .foregroundStyle(.white)
            Image("ic-launch-screen")
            TabView(selection: $selectedIndex) {
                // swiftlint:disable line_length
                OnboardingContentView(
                    title: "Welcome to Taskerly!",
                    image: "globe",
                    description: "Your personal assistant for staying organized and productive. Manage your tasks, set priorities, and achieve your goals—all in one place.")
                    .tag(0)
                OnboardingContentView(
                    title: "Simplified Task Management",
                    image: "list.clipboard",
                    description: "Create, categorize, and prioritize tasks effortlessly. With Taskerly, staying on top of your to-do list has never been easier.")
                    .tag(1)
                OnboardingContentView(
                    title: "Stay on Track with Notifications",
                    image: "bell",
                    description: "Never miss a deadline. Get timely reminders and notifications to keep your tasks in check and your goals within reach.")
                    .tag(2)
                // swiftlint:enable line_length
            }
            .frame(height: 330)
            .tabViewStyle(.page(indexDisplayMode: .never))
            .animation(.easeOut, value: selectedIndex)

            PageControl(totalIndex: 3, selectedIndex: $selectedIndex).padding()

            Button(action: {
                router.pop(to: .list)
            }, label: {
                Text("Get Started")
            })
            .padding()
            .font(.title3.weight(.semibold))
            .foregroundStyle(Color.gradient)
            .background(.white)
            .clipShape(Capsule())
            .padding()
        }
        .frame(maxHeight: .infinity)
        .background(Color.gradient)
        .onAppear {
            if UserSettings.isOnboarded {
                router.pop(to: .list)
            } else {
                UserSettings.isOnboarded = true
            }
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
}

#Preview {
    OnboardingView()
}
