//
//  Card.swift
//  Taskerly
//
//  Created by Duc on 10/8/24.
//

import SwiftUI

struct TaskDetailCard: View {
    let title: String
    let detail: String?

    var body: some View {
        VStack(alignment: .leading) {
            Text(title).font(.caption)
            if let detail {
                Text(detail)
            }
            Divider().background(.white)
        }.padding(.vertical, 4)
    }
}
