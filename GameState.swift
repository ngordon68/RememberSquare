//
//  GameState.swift
//  RememberSquare
//
//  Created by Nick Gordon on 2/10/26.
//

import Observation
import Foundation

@MainActor
@Observable
final class GameState {
    enum Phase {
        case idle
        case previewing
        case playing
        case success
        case failure
    }

    enum TapOutcome {
        case ignored
        case correct
        case incorrect
        case completed
    }

    let gridSide = 4
    let totalSquares = 16

    var orderLength = 6
    var phase: Phase = .idle
    var sequence: [Int] = []
    var userInputs: [Int] = []
    var incorrectIndex: Int?
    var previewIndex: Int?

    @ObservationIgnored private var previewTask: Task<Void, Never>?

    func startGame() {
        cancelPreview()
        sequence = Array(0..<totalSquares).shuffled().prefix(orderLength).map { $0 }
        userInputs = []
        incorrectIndex = nil
        previewIndex = nil
        phase = .previewing
        previewSequence()
    }

    func registerTap(index: Int) -> TapOutcome {
        guard phase == .playing else { return .ignored }
        let expectedIndex = userInputs.count
        guard expectedIndex < sequence.count else { return .ignored }

        if sequence[expectedIndex] == index {
            userInputs.append(index)
            if userInputs.count == sequence.count {
                phase = .success
                return .completed
            }
            return .correct
        }

        incorrectIndex = index
        phase = .failure
        return .incorrect
    }

    func cancelPreview() {
        previewTask?.cancel()
        previewTask = nil
    }

    private func previewSequence() {
        previewTask = Task { [sequence] in
            for index in sequence {
                if Task.isCancelled { break }
                await MainActor.run {
                    previewIndex = index
                }
                try? await Task.sleep(nanoseconds: 500_000_000)
                await MainActor.run {
                    previewIndex = nil
                }
                try? await Task.sleep(nanoseconds: 250_000_000)
            }

            await MainActor.run {
                previewIndex = nil
                if !Task.isCancelled {
                    phase = .playing
                }
            }
        }
    }
}
