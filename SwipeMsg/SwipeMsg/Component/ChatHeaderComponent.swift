//
//  ChatHeaderComponent.swift
//  SwipeMsg
//
//  Created by Nouf Altamimi on 05/02/2026.
//
import SwiftUI

struct ChatHeaderComponent: View {
    let title: String
    var body: some View {
        HStack {
            Image(systemName: "chevron.left")
            Text(title)
                .font(.headline)
            Spacer()
        }
        .padding(.top, UIApplication.shared.connectedScenes
            .compactMap {
                ($0 as? UIWindowScene)?.keyWindow?.safeAreaInsets.top
            }
            .first ?? 0 )
        .padding(.horizontal)
        .padding(.bottom, 12)
        .background(.ultraThinMaterial)
        .overlay(Divider(), alignment: .bottom)
    }
}
