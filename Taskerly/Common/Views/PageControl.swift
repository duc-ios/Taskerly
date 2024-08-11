//
//  PageControl.swift
//  Taskerly
//
//  Created by Duc on 11/8/24.
//

import SwiftUI

struct PageControl: View {
    let totalIndex: Int
    @Binding var selectedIndex: Int

    @Namespace private var animation

    var body: some View {
        HStack {
            ForEach(0 ..< totalIndex, id: \.self) { index in
                Group {
                    if selectedIndex == index {
                        Rectangle()
                            .fill(.white)
                            .frame(height: 5)
                            .clipShape(
                                RoundedRectangle(cornerRadius: 3)
                            )
                            .matchedGeometryEffect(id: "PageControlAnimation", in: animation)
                    } else {
                        Rectangle()
                            .fill(.white.opacity(0.3))
                            .frame(height: 5)
                            .clipShape(
                                RoundedRectangle(cornerRadius: 3)
                            )
                    }
                }
                .onTapGesture {
                    selectedIndex = index
                }
            }
        }.animation(.spring(), value: UUID())
    }
}

#if DEBUG
#Preview {
    @State var selectedIndex = 0
    return Color.blue.overlay {
        PageControl(totalIndex: 3, selectedIndex: $selectedIndex)
    }
}
#endif
