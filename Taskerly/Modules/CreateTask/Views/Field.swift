//
//  Field.swift
//  Taskerly
//
//  Created by Duc on 10/8/24.
//

import SwiftUI

struct Field: View {
    let label: String
    @Binding var text: String

    var body: some View {
        VStack(alignment: .leading) {
            Spacer().frame(height: 8)
            Text(label).font(.caption)
            TextField(label, text: $text)
            Divider().background(.white)
        }
    }
}

struct MultilineField: View {
    let label: String
    @Binding var text: String

    var body: some View {
        VStack(alignment: .leading) {
            Spacer().frame(height: 16)
            Text(label).font(.caption)
            TextField(label, text: $text, axis: .vertical)
                .lineLimit(5 ... 10)
            Divider().background(.white)
        }
    }
}
