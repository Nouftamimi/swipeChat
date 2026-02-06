//
//  MessageBubbleComponent.swift
//  SwipeMsg
//
//  Created by Nouf Altamimi on 05/02/2026.
//
import SwiftUI

// MARK: - Message Bubble
struct MessageBubbleComponent: View {
    let message: ChatMessage
    let offsetX: CGFloat
    let onIncrement: () -> Void
    let onDecrement: () -> Void

    var body: some View {
        HStack(spacing: 8) {
            HStack {
                Button(action: onIncrement) {
                    Image(systemName: "plus.circle.fill")
                        .foregroundColor(.blue)
                        .font(.title2)
                }

                Button(action: onDecrement) {
                    Image(systemName: "minus.circle.fill")
                        .foregroundColor(.gray)
                        .font(.title2)
                }
            }

            Spacer()

            Text(message.text)
                .padding()
                .background(Color.green)
                .cornerRadius(12)
                .offset(x: min(offsetX, 60))
        }
        .padding(.horizontal)
    }
}
