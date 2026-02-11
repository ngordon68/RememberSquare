//
//  GridSectionView.swift
//  RememberSquare
//
//  Created by Nick Gordon on 2/10/26.
//

import SwiftUI

struct GridSectionView: View {
    let totalSquares: Int
    let gridSide: Int
    let spacing: CGFloat
    let allowsInput: Bool
    let visualState: (Int) -> SquareVisualState
    let onTap: (Int) -> Void
    let accessibilityLabel: (Int) -> String
    let accessibilityValue: (Int) -> String

    var body: some View {
        let columns = Array(repeating: GridItem(.flexible(), spacing: spacing), count: gridSide)
        return LazyVGrid(columns: columns, spacing: spacing) {
            ForEach(0..<totalSquares, id: \.self) { index in
                SquareButton(state: visualState(index), isDisabled: !allowsInput) {
                    onTap(index)
                }
                .accessibilityLabel(accessibilityLabel(index))
                .accessibilityValue(accessibilityValue(index))
            }
        }
        .aspectRatio(1, contentMode: .fit)
    }
}
