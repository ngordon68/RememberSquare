//
//  SquareButton.swift
//  RememberSquare
//
//  Created by Nick Gordon on 2/10/26.
//

import SwiftUI

enum SquareVisualState: Equatable {
    case neutral
    case preview
    case correct
    case incorrect
}

struct SquareButton: View {
    let state: SquareVisualState
    let isDisabled: Bool
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            RoundedRectangle(cornerRadius: 12)
                .fill(fillColor)
                .overlay(
                    RoundedRectangle(cornerRadius: 12)
                        .strokeBorder(borderColor, lineWidth: 2)
                )
                .scaleEffect(state == .preview ? 1.06 : 1.0)
                .animation(.spring(response: 0.3, dampingFraction: 0.7), value: state)
                .accessibilityHidden(true)
        }
        .buttonStyle(.plain)
        .disabled(isDisabled)
        .aspectRatio(1, contentMode: .fit)
    }

    private var fillColor: Color {
        switch state {
        case .neutral:
            return Color(.systemGray6)
        case .preview:
            return Color(.systemYellow).opacity(0.85)
        case .correct:
            return Color(.systemGreen).opacity(0.85)
        case .incorrect:
            return Color(.systemRed).opacity(0.85)
        }
    }

    private var borderColor: Color {
        switch state {
        case .neutral:
            return Color(.systemGray4)
        case .preview:
            return Color(.systemYellow)
        case .correct:
            return Color(.systemGreen)
        case .incorrect:
            return Color(.systemRed)
        }
    }
}
