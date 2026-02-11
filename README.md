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

<table>
 <tr>
  <td>
   <img width="300" alt="RememberSquare Game Screen" src="https://github.com/user-attachments/assets/daf14083-5609-4414-be9d-24a098415eaa">
  </td>
  <td>
   <img width="300" alt="Game in Progress" src="https://github.com/user-attachments/assets/f708f074-7f09-4441-a671-29e2fa4ecf69">
  </td>
  <td>
   <img width="300" alt="Memory Sequence Preview" src="https://github.com/user-attachments/assets/90cec049-a3f1-4ccd-89e9-b5cd5ede06e2">
  </td>
 </tr>
</table>

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
