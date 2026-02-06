
📱 Chat Swipe Navigation (SwiftUI + UIKit)

This feature implements a WhatsApp-style horizontal swipe interaction in SwiftUI, allowing users to swipe between:

Chat View (messages)

Message Info View (details of a selected message)

The swipe animation is smooth and interactive, powered by UIKit gestures, while the UI is built in SwiftUI.
______________________________________________________________
✨ Features
______________________________________________________________

Horizontal swipe right → left to open Message Info

Swipe left → right to return to Chat

Smooth UIKit pan gesture (no SwiftUI drag lag)

Parallax effect on message bubble

Dim overlay during swipe

Header stays fixed while content slides

No visual gaps or white bars during swipe

______________________________________________________________
🧩 Architecture Overview
______________________________________________________________
## 📂 Project Structure

```text
ChatMsg
│
├─ Component
│   ├─ ChatHeaderComponent.swift        # Fixed header shown above swipe content
│   └─ MessageBubbleComponent.swift     # Reusable chat bubble UI
│
├─ Controller
│   └─ SwipeViewController.swift        # UIKit pan gesture controller
│
├─ Model
│   ├─ ChatMessage.swift                # Chat message data model
│   └─ SwipeDirection.swift             # Swipe direction enum
│
├─ View
│   ├─ ChatSwipeView.swift              # Main swipe container & coordinator
│   ├─ ChatView.swift                   # Chat screen content
│   └─ MessageInfoView.swift            # Message details screen
```
______________________________________________________________
🧱 UIKit Integration (Why It’s Used)
______________________________________________________________

❌ SwiftUI’s DragGesture can feel laggy for chat-style interactions.

This project uses:

- UIPanGestureRecognizer
- UIViewControllerRepresentable
- UIHostingController

to achieve native, buttery-smooth swipe behavior.

______________________________________________________________
🏁 Final Result
______________________________________________________________

- ✅ No gaps during swipe
- ✅ Full edge-to-edge animation
- ✅ Header stays fixed
- ✅ Smooth UIKit interaction
- ✅ Clean SwiftUI layout
