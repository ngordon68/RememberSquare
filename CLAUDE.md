# CLAUDE.md

## Project overview and purpose
RememberSquare is a SwiftUI memory game where players watch a short sequence of highlighted squares on a 4×4 grid and then tap the squares back in the same order.

## Screenshots
![RememberSquare App](file:///var/folders/nx/b534dgpj2m183fmtvbsssvvh0000gr/T/ActionArtifacts/0FD8D478-5C32-4646-885A-BE5058290325/RenderPreview/RenderPreview_result_2026-02-11T020831Z@3x.png)

The app features:
- A clean, centered layout with the game title at the top
- Status display showing current streak and order length
- Control buttons (New Game, Start) for game flow
- A 4×4 grid of interactive square buttons with rounded corners
- Squares highlight during the preview sequence and respond to user taps

## Key architecture decisions
- Use a dedicated `@Observable` `GameState` class to own game logic and keep the view simple.
- Drive the UI purely from state (phase, sequence, user inputs) to keep transitions predictable.
- Use async preview playback via `Task.sleep` to avoid timers and keep UI responsive.
- Compose the UI from small section views to keep `ContentView` focused on layout and data flow.

## Important conventions and patterns used
- `@State private var` for view-owned state.
- `@Observable` + `@MainActor` for shared game state.
- SwiftUI `Button` for taps, not `onTapGesture`.
- Visual states computed from game state, not stored separately.
- Section views receive primitive values or bindings instead of owning state.

## Build/run instructions
- Open `RememberSquare.xcodeproj` in Xcode.
- Run the iOS target with the standard Run button.

## Quirks or gotchas specific to this project
- The preview sequence disables input, so avoid testing taps during the preview phase.
- Order length is locked during active play to keep the sequence consistent.
