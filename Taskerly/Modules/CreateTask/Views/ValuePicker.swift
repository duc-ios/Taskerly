//
//  ValuePicker.swift
//  Taskerly
//
//  Created by Duc on 10/8/24.
//

import SwiftUI

struct ValuePicker<Value: Hashable & ToStringProtocol>: View {
    let label: String
    @Binding var selection: Value
    let items: [Value]

    var body: some View {
        HStack {
            Text(label).font(.callout)
            Spacer()
            Picker("", selection: $selection) {
                ForEach(items, id: \.self) {
                    Text($0.toString())
                }
            }
            .tint(.gray)
        }.padding(.vertical, 8)
    }
}
