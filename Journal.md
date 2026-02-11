# Journal.md

## The Big Picture
RememberSquare is a bite-sized memory game: the app flashes a short dance of squares on a 4×4 grid, and your job is to repeat the choreography in the exact order. Think of it as Simon Says with a minimalist suit and a sharp timer.

## Architecture Deep Dive
The `GameState` object is the stage manager. It decides the sequence, runs the preview show, and tracks what the player taps. The SwiftUI view is the audience-facing set: it just reads the stage manager's cues and paints the lights accordingly. When the preview runs, a `Task` is the spotlight operator, turning one square on at a time before handing control back to the player.

## The Codebase Map
- `RememberSquare/ContentView.swift` composes the screen from focused subviews.
- `RememberSquare/GameState.swift` owns the game rules, sequence, and preview timing.
- `RememberSquare/GridSectionView.swift`, `RememberSquare/HeaderSectionView.swift`, `RememberSquare/StatusSectionView.swift`, and `RememberSquare/ControlsSectionView.swift` are the UI sections.
- `RememberSquare/SquareButton.swift` renders a single square and its visual state.
- `RememberSquare/RememberSquareApp.swift` boots the app and shows `ContentView`.
- Tests live in `RememberSquareTests/` and `RememberSquareUITests/` but are still stock templates.

## Tech Stack & Why
- SwiftUI: fast iteration, declarative UI, and built-in accessibility hooks.
- Observation (`@Observable`): lighter than `ObservableObject`, keeps state changes smooth.
- Swift Concurrency: `Task.sleep` makes the preview timing clean without timers or callback soup.

## The Journey
- Feature drop: built the full 4×4 order-based game loop (preview → play → success/fail) with a clean state machine.
- Aha!: storing only the sequence and the user inputs is enough to derive every visual state—no need to stash per-square flags.
- Pitfall avoided: input is locked during the preview, so we don't accidentally let players "cheat" during the demo.
- Refactor win: split the monolithic view into small, reusable sections so each piece is easier to reason about.

## Engineer's Wisdom
- Keep UI dumb and state smart. The view shouldn't know the rules; it should only paint the scoreboard.
- Async previews are easier to reason about than timers and invalidate calls.
- Accessibility labels are a feature, not a chore. They make the grid navigable for everyone.

## If I Were Starting Over...
I'd add automated tests for sequence generation and tap validation early, so refactors don't accidentally break the win/fail logic.
