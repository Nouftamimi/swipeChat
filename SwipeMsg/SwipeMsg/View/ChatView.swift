//
//  ChatView.swift
//  SwipeMsg
//
//  Created by Nouf Altamimi on 05/02/2026.
//

import SwiftUI

struct ChatView: View {
    let bubbleParallax: CGFloat
    let dimProgress: CGFloat
    let onMessageUpdate: (ChatMessage) -> Void
    @State private var counter: Int = 1
    let baseMessage = ChatMessage(
        text: "Hello 👋",
        sender: "Nouf",
        time: "10:32" )
    private var displayedMessage: ChatMessage {
        ChatMessage( text: "\(counter) \(baseMessage.text)", sender: baseMessage.sender, time: baseMessage.time )
    }
    var body: some View {
        ZStack {
            VStack {
                MessageBubbleComponent(
                    message: displayedMessage,
                    offsetX: bubbleParallax,
                    onIncrement: {
                        counter += 1
                        onMessageUpdate(displayedMessage)
                    },
                    onDecrement: {
                        if counter > 1 {
                            counter -= 1
                            onMessageUpdate(displayedMessage)
                        }
                    }
                )
                Spacer()
            }
            .padding(.top, 60)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .onAppear {
            onMessageUpdate(displayedMessage)
        }
    }
}
