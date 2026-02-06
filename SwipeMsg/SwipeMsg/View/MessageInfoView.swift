//
//  MessageInfoView.swift
//  SwipeMsg
//
//  Created by Nouf Altamimi on 05/02/2026.
//

import SwiftUI
// MARK: - Message Info
struct MessageInfoView: View {
    let message: ChatMessage?

    var body: some View {
        ZStack {
            Color(.systemGroupedBackground)
                .ignoresSafeArea()

            ScrollView {
                VStack(alignment: .leading, spacing: 16) {

                    if let message {
                        Text(message.text)
                            .padding()
                            .background(Color.green)
                            .cornerRadius(12)
                            .frame(maxWidth: .infinity, alignment: .trailing)
                    }
                }
                .padding()
                .padding(.top, 40)
                .padding(.bottom, 0)
            }
        }
        .ignoresSafeArea()
    }

    private func statusRow(_ title: String, _ icon: String) -> some View {
        HStack(spacing: 12) {
            Image(systemName: icon)
                .foregroundColor(.blue)
            Text(title)
            Spacer()
        }
    }
}
