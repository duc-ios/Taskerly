//
//  TaskListCard.swift
//  Taskerly
//
//  Created by Duc on 9/8/24.
//

import SwiftUI

struct TaskListCard: View {
    let task: TaskItem

    var body: some View {
        NavigationLink(value: Route.detail(task)) {
            HStack {
                Image(systemName: "list.clipboard")
                    .foregroundStyle(.white)
                    .padding()
                    .frame(width: 32, height: 32)
                    .background(
                        RoundedRectangle(cornerRadius: 8)
                            .foregroundStyle(Color.gradient)
                    )
                VStack(alignment: .leading) {
                    Text(task.name)
                        .font(.body)

                    HStack {
                        Text(task.category.toString() + " -").foregroundStyle(.gray)

                        Group {
                            if task.rawPriority == 1 {
                                Text("!")
                            } else if task.rawPriority == 2 {
                                Text("!!")
                            } else if task.rawPriority >= 2 {
                                Text("!!!")
                            }
                            Text(task.timestamp, format: Date.FormatStyle(date: .numeric, time: .shortened))
                        }.foregroundStyle(task.rawPriority == 1 ? .green
                            : task.rawPriority == 2 ? .blue
                            : task.rawPriority == 3 ? .red
                            : .gray)
                    }
                }
                .font(.callout)
            }
        }
        .padding()
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(
            RoundedRectangle(cornerRadius: 8)
                .foregroundStyle(task.status == .completed ? Color.background2 : .white)
        )
        .listRowBackground(Color.clear)
        .listRowSeparator(.hidden)
    }
}

#if DEBUG
#Preview {
    List {
        TaskListCard(task: .init(timestamp: Date(), name: "Name1", category: .personal))
        TaskListCard(task: .init(timestamp: Date(), name: "Name2", category: .work))
    }
    .listStyle(.plain)
    .background(.gray)
}
#endif
