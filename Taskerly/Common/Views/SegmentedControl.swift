//
//  SegmentedControl.swift
//  Taskerly
//
//  Created by Duc on 9/8/24.
//

import SwiftUI

protocol ToStringProtocol {
    func toString() -> String
}

protocol SegmentedControlItem: Hashable & Equatable & ToStringProtocol {}

extension String: SegmentedControlItem {
    func toString() -> String {
        self
    }
}

struct SegmentedControl<T: SegmentedControlItem>: View {
    let items: [T]
    let selected: T
    var baseColor: Color = .white
    let onSelected: (_ selected: T) -> Void
    let cRadius: CGFloat = 10

    var body: some View {
        ZStack {
            GeometryReader { geometry in
                RoundedRectangle(cornerRadius: 24.0)
                    .foregroundColor(.background2)
                    .frame(width: geometry.size.width / Double(items.count))
                    .animation(.easeInOut(duration: 0.25), value: selected)
                    .offset(x: geometry.size.width
                        / Double(items.count)
                        * Double(items.firstIndex(of: selected) ?? 0))
            }

            let columns = Array(repeating: GridItem(spacing: 1), count: items.count)
            LazyVGrid(columns: columns, spacing: 1) {
                ForEach(Array(items.enumerated()), id: \.element) { offset, element in
                    Button {
                        onSelected(items[offset])
                    } label: {
                        let isSelected = items[offset] == selected
                        VStack {
                            let text = Text(element.toString())
                                .padding(.vertical, 10)
                                .font(.footnote.weight(isSelected ? .semibold : .regular))
                            if isSelected {
                                text.foregroundStyle(Color.gradient)
                            } else {
                                text.foregroundStyle(Color.text)
                            }
                        }
                    }
                }
            }
            .foregroundColor(baseColor)
            .font(.callout)
            .cornerRadius(cRadius)
        }
        .frame(height: 44)
        .onChange(of: selected) { _, _ in
            Haptic.fire()
        }
    }
}

#Preview {
    struct PreviewWrapper: View {
        @State var selected = "All"

        var body: some View {
            SegmentedControl(
                items: ["All", "Pending", "Completed"],
                selected: "All",
                onSelected: { selected = $0 }
            )
        }
    }

    return PreviewWrapper()
}
