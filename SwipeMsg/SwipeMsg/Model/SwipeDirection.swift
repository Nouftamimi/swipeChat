//
//  SwipeDirection.swift
//  SwipeMsg
//
//  Created by Nouf Altamimi on 05/02/2026.
//
import SwiftUI

enum SwipeDirection {
    case leftToRight
    case rightToLeft

    var sign: CGFloat {
        switch self {
        case .leftToRight: return 1
        case .rightToLeft: return -1
        }
    }
}
