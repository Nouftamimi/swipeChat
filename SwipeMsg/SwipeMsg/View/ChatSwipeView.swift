//
//  ChatSwipeView.swift
//  SwipeMsg
//
//  Created by Nouf Altamimi on 04/02/2026.
//

import SwiftUI
import UIKit

// MARK: - Swipe Container
struct ChatSwipeView: View {
    @State private var offsetX: CGFloat = 0
    @GestureState private var dragOffset: CGFloat = 0
    @State private var pendingMessage: ChatMessage?
    @State private var selectedMessage: ChatMessage?
    private let screenWidth = UIScreen.main.bounds.width
    private let headerHeight: CGFloat = 90
    
    private var progress: CGFloat {
        abs(limitedOffset) / screenWidth
    }
    var body: some View {
        ZStack(alignment: .top) {
            ZStack {
                HStack(spacing: 0) {
                    VStack(spacing: 0) {
                        SwipeContainer(
                            content:
                                ChatView(
                                    bubbleParallax: progress * -30,
                                    dimProgress: progress ) {
                                        message in pendingMessage = message
                                    },
                            direction: .rightToLeft,
                            screenWidth: screenWidth,
                            offsetX: $offsetX,
                            onCommit: {
                                selectedMessage = pendingMessage
                            }
                        )
                        .overlay(
                            Color.black
                                .opacity(progress > 0 ? 0.2 : 0)
                                .ignoresSafeArea()
                                .allowsHitTesting(false)
                        )
                    }
                    .frame(width: screenWidth)
                    .padding(.top, headerHeight)
                    VStack(spacing: 0) {
                        SwipeContainer(
                            content:
                                MessageInfoView(message: selectedMessage),
                            direction: .leftToRight, screenWidth: screenWidth, offsetX: $offsetX, onCommit: nil )
                    }
                    .frame(width: screenWidth)
                    .padding(.top, headerHeight)
                }
                .frame(width: screenWidth, alignment: .leading)
                .offset(x: limitedOffset)
                .gesture(swipeGesture)
                .animation(
                    .interactiveSpring(response: 0.35, dampingFraction: 0.9), value: offsetX )
            }
            ChatHeaderComponent( title: progress < 0.9 ? "Nouf" : "Message Info" )
        }
        .ignoresSafeArea()
    }
    private var limitedOffset: CGFloat {
        let total = offsetX + dragOffset
        return min(0, max(-screenWidth, total))
    }
    private var swipeGesture: some Gesture {
        DragGesture()
            .updating($dragOffset) {
                value, state, _ in
                if abs(value.translation.width) > abs(value.translation.height) {
                    state = value.translation.width
                }
            }
            .onEnded {
                value in guard value.predictedEndTranslation.width < 0 else { return }
                let openInfo = value.predictedEndTranslation.width < -screenWidth * 0.35
                withAnimation(.interactiveSpring()) {
                    offsetX = openInfo ? -screenWidth : 0
                }
            }
    }
    private func closeInfo() {
        withAnimation(.interactiveSpring(response: 0.35, dampingFraction: 0.9)) { offsetX = 0
        }
    }
}

#Preview {
    ChatSwipeView()
}
