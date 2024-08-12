//
//  AppView.swift
//  Taskerly
//
//  Created by Duc on 9/8/24.
//

import SwiftData
import SwiftUI

struct AppView: View {
    @ObservedObject var router = Router()

    var body: some View {
        NavigationStack(path: $router.path) {
            OnboardingView()
        }
        .tint(Color.gradient)
        .environmentObject(router)
    }
}

extension UINavigationController {
    override open func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        navigationBar.topItem?.backButtonDisplayMode = .minimal
    }
}
