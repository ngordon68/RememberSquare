//
//  ContentView.swift
//  RememberSquare
//
//  Created by Nick Gordon on 2/9/26.
//

import Observation
import SwiftUI
import UIKit

struct ContentView: View {
    @State private var game = GameState()

    private let gridSpacing: CGFloat = 12

    var body: some View {
        VStack(spacing: 20) {
            headerSection

            gridSection

            statusSection

            controlsSection
        }
        .padding(24)
    }

    private var headerSection: some View {
        HeaderSectionView()
    }

    private var gridSection: some View {
        GridSectionView(
            totalSquares: game.totalSquares,
            gridSide: game.gridSide,
            spacing: gridSpacing,
            allowsInput: allowsInput,
            visualState: visualState(for:),
            onTap: handleTap(index:),
            accessibilityLabel: accessibilityLabel(for:),
            accessibilityValue: accessibilityValue(for:)
        )
    }

    private var statusSection: some View {
        StatusSectionView(
            statusText: statusText,
            detail: statusDetail,
            showsSequence: game.phase == .failure,
            sequenceDescription: sequenceDescription
        )
    }

    private var controlsSection: some View {
        @Bindable var bindableGame = game
        return ControlsSectionView(
            primaryTitle: primaryButtonTitle,
            isPrimaryDisabled: game.phase == .previewing,
            orderLength: $bindableGame.orderLength,
            totalSquares: game.totalSquares,
            isStepperDisabled: game.phase == .previewing || game.phase == .playing,
            onPrimaryTap: {
                game.startGame()
            }
        )
    }

    private var allowsInput: Bool {
        game.phase == .playing
    }

    private var statusText: String {
        switch game.phase {
        case .idle:
            return "Press Start to begin."
        case .previewing:
            return "Memorize the order..."
        case .playing:
            return "Your turn!"
        case .success:
            return "Nice job! You nailed it."
        case .failure:
            return "Oops! That was the wrong square."
        }
    }

    private var statusDetail: String? {
        switch game.phase {
        case .playing:
            return "Step \(game.userInputs.count + 1) of \(game.sequence.count)"
        case .previewing:
            return "Tapping is disabled during the preview."
        case .idle:
            return "Order length can be adjusted from 4 to 16."
        case .success:
            return "Ready for another round?"
        case .failure:
            return "Try again or start a new sequence."
        }
    }

    private var primaryButtonTitle: String {
        switch game.phase {
        case .idle:
            return "Start Game"
        case .previewing:
            return "Restart"
        case .playing:
            return "Restart"
        case .success:
            return "Next Round"
        case .failure:
            return "Retry"
        }
    }

    private var sequenceDescription: String {
        game.sequence.map { "\($0 + 1)" }.joined(separator: " → ")
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

    private func accessibilityLabel(for index: Int) -> String {
        let row = index / game.gridSide + 1
        let column = index % game.gridSide + 1
        return "Square row \(row), column \(column)"
    }

    private func accessibilityValue(for index: Int) -> String {
        switch visualState(for: index) {
        case .neutral:
            return "neutral"
        case .preview:
            return "previewing"
        case .correct:
            return "correct"
        case .incorrect:
            return "incorrect"
        }
    }

    private func handleTap(index: Int) {
        let outcome = game.registerTap(index: index)
        handleHaptic(for: outcome)
    }

    private func handleHaptic(for outcome: GameState.TapOutcome) {
        let generator: UIImpactFeedbackGenerator
        switch outcome {
        case .ignored:
            return
        case .correct:
            generator = UIImpactFeedbackGenerator(style: .light)
        case .completed:
            generator = UIImpactFeedbackGenerator(style: .medium)
        case .incorrect:
            generator = UIImpactFeedbackGenerator(style: .rigid)
        }
        generator.prepare()
        generator.impactOccurred()
    }
}

#Preview {
    ContentView()
}
