//
//  PreviewStates.swift
//  RememberSquare
//
//  Preview helpers for different game states
//

import SwiftUI

// Wrapper to inject game state
struct ContentViewPreview: View {
    let game: GameState
    
    var body: some View {
        ContentViewWithState(game: game)
    }
}

struct ContentViewWithState: View {
    @State var game: GameState
    
    private let gridSpacing: CGFloat = 12
    
    var body: some View {
        VStack(spacing: 20) {
            HeaderSectionView()
            
            GridSectionView(
                totalSquares: game.totalSquares,
                gridSide: game.gridSide,
                spacing: gridSpacing,
                allowsInput: game.phase == .playing,
                visualState: visualState(for:),
                onTap: { _ in },
                accessibilityLabel: { index in
                    let row = index / game.gridSide + 1
                    let column = index % game.gridSide + 1
                    return "Square row \(row), column \(column)"
                },
                accessibilityValue: { index in
                    switch visualState(for: index) {
                    case .neutral: return "neutral"
                    case .preview: return "previewing"
                    case .correct: return "correct"
                    case .incorrect: return "incorrect"
                    }
                }
            )
            
            StatusSectionView(
                statusText: statusText,
                detail: statusDetail,
                showsSequence: game.phase == .failure,
                sequenceDescription: game.sequence.map { "\($0 + 1)" }.joined(separator: " → ")
            )
            
            @Bindable var bindableGame = game
            ControlsSectionView(
                primaryTitle: primaryButtonTitle,
                isPrimaryDisabled: game.phase == .previewing,
                orderLength: $bindableGame.orderLength,
                totalSquares: game.totalSquares,
                isStepperDisabled: game.phase == .previewing || game.phase == .playing,
                onPrimaryTap: {}
            )
        }
        .padding(24)
    }
    
    private var statusText: String {
        switch game.phase {
        case .idle: return "Press Start to begin."
        case .previewing: return "Memorize the order..."
        case .playing: return "Your turn!"
        case .success: return "Nice job! You nailed it."
        case .failure: return "Oops! That was the wrong square."
        }
    }
    
    private var statusDetail: String? {
        switch game.phase {
        case .playing: return "Step \(game.userInputs.count + 1) of \(game.sequence.count)"
        case .previewing: return "Tapping is disabled during the preview."
        case .idle: return "Order length can be adjusted from 4 to 16."
        case .success: return "Ready for another round?"
        case .failure: return "Try again or start a new sequence."
        }
    }
    
    private var primaryButtonTitle: String {
        switch game.phase {
        case .idle: return "Start Game"
        case .previewing: return "Restart"
        case .playing: return "Restart"
        case .success: return "Next Round"
        case .failure: return "Retry"
        }
    }
    
    private func visualState(for index: Int) -> SquareVisualState {
        if game.phase == .previewing, game.previewIndex == index {
            return .preview
        }
        if game.incorrectIndex == index {
            return .incorrect
        }
        if game.userInputs.contains(index) {
            return .correct
        }
        return .neutral
    }
}

// Preview for idle state (initial screen)
#Preview("Idle State") {
    let game = GameState()
    return ContentViewPreview(game: game)
}

// Preview for playing state
#Preview("Playing State") {
    let game = GameState()
    game.phase = .playing
    game.sequence = [0, 5, 10, 15, 3, 7]
    game.userInputs = [0, 5]
    return ContentViewPreview(game: game)
}

// Preview for success state
#Preview("Success State") {
    let game = GameState()
    game.phase = .success
    game.sequence = [0, 5, 10, 15]
    game.userInputs = [0, 5, 10, 15]
    game.orderLength = 4
    return ContentViewPreview(game: game)
}

// Preview for failure state
#Preview("Failure State") {
    let game = GameState()
    game.phase = .failure
    game.sequence = [0, 5, 10, 15]
    game.userInputs = [0, 5]
    game.incorrectIndex = 9
    game.orderLength = 4
    return ContentViewPreview(game: game)
}

// Preview for previewing state (showing highlighted square)
#Preview("Previewing State") {
    let game = GameState()
    game.phase = .previewing
    game.sequence = [0, 5, 10, 15, 3, 7]
    game.previewIndex = 5
    return ContentViewPreview(game: game)
}
