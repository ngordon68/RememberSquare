# RememberSquare

> A SwiftUI memory challenge game that tests your pattern recognition and recall abilities

RememberSquare is an engaging memory game where you watch a sequence of squares light up on a 4×4 grid, then tap them back in the exact same order. Think Simon Says meets memory mastery – simple to learn, challenging to master!

## ✨ Features

### Gameplay
- **4×4 Interactive Grid** - 16 squares of brain-teasing fun
- **Visual Feedback** - Color-coded states (yellow for preview, green for correct, red for incorrect)
- **Progressive Difficulty** - Adjustable sequence length from 4 to 16 steps
- **Instant Validation** - Know immediately if you're on the right track
- **Haptic Feedback** - Feel every tap with tactile responses

### Technical Highlights
- Built with modern **SwiftUI** and **Swift Concurrency**
- Smooth animations using **Spring physics**
- Full **accessibility support** with VoiceOver labels
- Clean **MVVM architecture** with `@Observable` state management
- Responsive UI that adapts to different screen sizes

## 📱 Requirements
- iOS 26.0+
- Swift 6.2+
- Xcode 16+

## 🚀 Getting Started

1. Clone this repository
2. Open `RememberSquare.xcodeproj` in Xcode
3. Select an iOS 26 simulator or device
4. Hit **⌘R** to build and run
5. Tap **Start Game** and test your memory!

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

## 🎮 How to Play

1. **Start** - Tap the "Start Game" button
2. **Watch** - A sequence of squares will light up in yellow (preview phase)
3. **Remember** - Memorize the order of the highlighted squares
4. **Repeat** - Tap the squares back in the exact same order
5. **Progress** - Complete the sequence to advance to the next round
6. **Challenge** - Adjust the order length to increase difficulty
Green squares = correct taps ✅  
Red square = wrong tap ❌

## 🏗️ Architecture & Code Structure

This project demonstrates clean SwiftUI architecture with a focus on separation of concerns:

### Architecture Diagram

```mermaid
classDiagram
    class ContentView {
        -State~GameState~ game
        +body: View
        -headerSection: View
        -gridSection: View
        -statusSection: View
        -controlsSection: View
        -allowsInput: Bool
        -statusText: String
        -statusDetail: String
        -primaryButtonTitle: String
        +visualState(for: Int) SquareVisualState
        +handleTap(index: Int)
        +handleHaptic(for: TapOutcome)
    }
    
    class GameState {
        <<Observable>>
        +Phase phase
        +Int orderLength
        +Array~Int~ sequence
        +Array~Int~ userInputs
        +Int? incorrectIndex
        +Int? previewIndex
        -Task? previewTask
        +startGame()
        +registerTap(index: Int) TapOutcome
        +cancelPreview()
        -previewSequence()
    }
    
    class Phase {
        <<enumeration>>
        idle
        previewing
        playing
        success
        failure
    }
    
    class TapOutcome {
        <<enumeration>>
        ignored
        correct
        incorrect
        completed
    }
    
    class HeaderSectionView {
        +body: View
    }
    
    class StatusSectionView {
        +String statusText
        +String? detail
        +Bool showsSequence
        +String sequenceDescription
        +body: View
    }
    
    class GridSectionView {
        +Int totalSquares
        +Int gridSide
        +CGFloat spacing
        +Bool allowsInput
        +Function visualState
        +Function onTap
        +Function accessibilityLabel
        +Function accessibilityValue
        +body: View
    }
    
    class ControlsSectionView {
        +String primaryTitle
        +Bool isPrimaryDisabled
        +Binding~Int~ orderLength
        +Int totalSquares
        +Bool isStepperDisabled
        +Function onPrimaryTap
        +body: View
    }
    
    class SquareButton {
        +SquareVisualState state
        +Bool isDisabled
        +Function action
        +body: View
        -fillColor: Color
        -borderColor: Color
    }
    
    class SquareVisualState {
        <<enumeration>>
        neutral
        preview
        correct
        incorrect
    }
    
    ContentView --> GameState : owns
    ContentView --> HeaderSectionView : composes
    ContentView --> StatusSectionView : composes
    ContentView --> GridSectionView : composes
    ContentView --> ControlsSectionView : composes
    GridSectionView --> SquareButton : renders 16x
    GameState --> Phase : uses
    GameState --> TapOutcome : returns
    SquareButton --> SquareVisualState : displays
    ContentView --> SquareVisualState : computes

    note for ContentView "Main orchestrator\nComputes visual states\nHandles user interactions"
    note for GameState "Single source of truth\nThread-safe with @MainActor\nAsync preview playback"
    note for GridSectionView "Lazy grid layout\nDelegates tap handling\nNo internal state"
```

### Data Flow Diagram

```mermaid
flowchart TB
    User([User Tap]) --> ContentView
    ContentView --> |registerTap| GameState
    GameState --> |TapOutcome| ContentView
    ContentView --> |Haptic| Device[UIImpactFeedbackGenerator]
    
    StartButton([Start Button]) --> |startGame| GameState
    GameState --> |Update phase| ContentView
    GameState --> |previewSequence| AsyncTask[Task.sleep Preview]
    AsyncTask --> |Update previewIndex| GameState
    
    GameState -.->|@Observable| ContentView
    ContentView --> |Computed States| Sections[Section Views]
    Sections --> |Visual State| SquareButton
    
    style GameState fill:#90EE90
    style ContentView fill:#87CEEB
    style User fill:#FFD700
    style StartButton fill:#FFD700
    style Device fill:#FFA500
```

### Component Interaction Flow

```mermaid
sequenceDiagram
    actor User
    participant CV as ContentView
    participant GS as GameState
    participant Grid as GridSectionView
    participant SB as SquareButton
    
    User->>CV: Tap "Start Game"
    CV->>GS: startGame()
    GS->>GS: Generate sequence
    GS->>GS: phase = .previewing
    
    loop Preview Each Square
        GS->>GS: Task.sleep(500ms)
        GS-->>CV: previewIndex updated
        CV->>Grid: visualState = .preview
        Grid->>SB: Render yellow square
        GS->>GS: Task.sleep(250ms)
        GS-->>CV: previewIndex = nil
    end
    
    GS->>GS: phase = .playing
    GS-->>CV: State updated
    CV->>Grid: allowsInput = true
    
    User->>SB: Tap square
    SB->>Grid: onTap(index)
    Grid->>CV: handleTap(index)
    CV->>GS: registerTap(index)
    
    alt Correct Tap
        GS-->>CV: return .correct
        CV->>Grid: visualState = .correct
        Grid->>SB: Render green square
        CV->>CV: handleHaptic(.correct)
    else Incorrect Tap
        GS-->>CV: return .incorrect
        GS->>GS: phase = .failure
        CV->>Grid: visualState = .incorrect
        Grid->>SB: Render red square
        CV->>CV: handleHaptic(.incorrect)
    else Sequence Complete
        GS-->>CV: return .completed
        GS->>GS: phase = .success
        CV->>CV: handleHaptic(.completed)
    end
```

### Core Components

- **`GameState.swift`** - Observable game logic and state management
  - Manages game phases (idle, previewing, playing, success, failure)
  - Handles sequence generation and validation
  - Coordinates async preview playback with Swift Concurrency

- **`ContentView.swift`** - Main screen composition and orchestration
  - Composes section views into cohesive UI
  - Bridges user interactions to game state
  - Manages haptic feedback responses

- **`SquareButton.swift`** - Individual square component
  - Visual state rendering (neutral, preview, correct, incorrect)
  - Smooth spring animations with `scaleEffect`
  - Color theming with system colors

### Section Views (Composition Pattern)

- **`HeaderSectionView.swift`** - Title and subtitle display
- **`StatusSectionView.swift`** - Status messaging and sequence display
- **`GridSectionView.swift`** - 4×4 grid layout with lazy rendering
- **`ControlsSectionView.swift`** - Game controls and settings

### Key Architectural Decisions

✅ **@Observable + @MainActor** for thread-safe state management  
✅ **Composition over inheritance** - small, focused view components  
✅ **Swift Concurrency** (`Task.sleep`) for preview timing instead of timers  
✅ **Computed properties** for derived visual states (no duplicate state)  
✅ **Dependency injection** - sections receive data via parameters, not global state  

## 🛠️ Technical Implementation Notes

### State Management
- Uses Swift's modern `@Observable` macro (not `ObservableObject`)
- All state mutations happen on `@MainActor` for UI safety
- Visual states are computed from game state, never stored separately

### Async Preview Playback
- Sequence preview uses `Task.sleep(nanoseconds:)` for timing
- Input is disabled during preview phase to prevent premature taps
- Preview task is cancellable for responsive UI

### Accessibility
- Every square has descriptive labels with row/column info
- Visual states are announced to VoiceOver
- Button styles optimized for assistive technologies

### Haptic Feedback
- `UIImpactFeedbackGenerator` provides tactile responses
- Different feedback styles for correct, completed, and incorrect taps
- Haptics are prepared ahead of time for instant response

## 📚 Learning Resources

Want to understand this project better? Check out:
- `CLAUDE.md` - Project conventions and architecture decisions
- `Journal.md` - Development journey, bugs encountered, and lessons learned

## 🎯 Future Enhancements

Potential improvements to explore:
- [ ] Leaderboard with local high scores
- [ ] Sound effects for square taps
- [ ] Multiple difficulty modes (speed variations)
- [ ] Different grid sizes (3×3, 5×5)
- [ ] Dark mode color scheme
- [ ] Game statistics and analytics

## 📄 License

This project is open source and available for educational purposes.

---

**Built with ❤️ using SwiftUI and modern Swift Concurrency patterns**

