# RememberSquare

RememberSquare is a SwiftUI memory game. The app previews a sequence of highlighted squares on a 4×4 grid, and the player taps the squares back in the same order.

## Features
- 4×4 tappable grid with visual feedback
- Sequence preview with input disabled during playback
- Immediate tap validation with success/failure states
- Configurable order length (4–16)
- Accessibility labels for each square

## Requirements
- iOS 26.0+
- Swift 6.2+
- Xcode 16+

## Run
1. Open `RememberSquare.xcodeproj` in Xcode.
2. Select an iOS 26 simulator or device.
3. Build and run.

## Screenshots
- `Screenshots/ios-home.png`
- `Screenshots/ios-preview.png`
- `Screenshots/ios-success.png`
- `Screenshots/ios-failure.png`

## Project Layout
- `RememberSquare/ContentView.swift` — screen composition and UI wiring
- `RememberSquare/GameState.swift` — game logic and preview timing
- `RememberSquare/GridSectionView.swift` — grid layout
- `RememberSquare/SquareButton.swift` — single square visuals
- `RememberSquare/HeaderSectionView.swift` — title and subtitle
- `RememberSquare/StatusSectionView.swift` — status messaging
- `RememberSquare/ControlsSectionView.swift` — start/retry and length controls

## Notes
- The sequence preview uses Swift Concurrency (`Task.sleep(for:)`) and disables input during playback.
