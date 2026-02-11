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

## Screenshots

<table>
 <tr>
  <td align="center">
   <img width="250" alt="Idle State - Start Screen" src="Screenshots/ios-home.png">
   <br><b>Idle State</b><br>
   <em>Press Start to begin</em>
  </td>
  <td align="center">
   <img width="250" alt="Preview State - Memorizing Sequence" src="Screenshots/ios-preview.png">
   <br><b>Preview State</b><br>
   <em>Memorize the order</em>
  </td>
  <td align="center">
   <img width="250" alt="Playing State - Your Turn" src="Screenshots/ios-playing.png">
   <br><b>Playing State</b><br>
   <em>Tap the squares in order</em>
  </td>
 </tr>
 <tr>
  <td align="center">
   <img width="250" alt="Success State - Completed Round" src="Screenshots/ios-success.png">
   <br><b>Success State</b><br>
   <em>Nice job! You nailed it</em>
  </td>
  <td align="center">
   <img width="250" alt="Failure State - Wrong Square" src="Screenshots/ios-failure.png">
   <br><b>Failure State</b><br>
   <em>Oops! Wrong square</em>
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
