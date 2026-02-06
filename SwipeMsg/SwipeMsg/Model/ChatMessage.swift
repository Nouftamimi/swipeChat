//
//  ChatMessage.swift
//  SwipeMsg
//
//  Created by Nouf Altamimi on 05/02/2026.
//

import SwiftUI

struct ChatMessage: Identifiable, Equatable {
    let id = UUID()
    let text: String
    let sender: String
    let time: String
}
