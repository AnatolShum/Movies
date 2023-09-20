//
//  CircleVoteViewModel.swift
//  MoviesApp
//
//  Created by Anatolii Shumov on 06/09/2023.
//

import Foundation
import SwiftUI

class CircleVoteViewModel: ObservableObject {
    func setColor(with vote: Double?) -> Color {
        guard let vote = vote else { return .gray }
        switch vote {
        case 0..<3:
            return .purple.opacity(0.7)
        case 3..<5:
            return .red.opacity(0.7)
        case 5..<6:
            return .orange.opacity(0.7)
        case 6..<7:
            return .yellow.opacity(0.7)
        case 7...10:
            return .green.opacity(0.7)
        default:
            return .gray
        }
    }
    
    func formattedString(_ vote: Double) -> String {
        return String(format: "%.1f", vote)
    }
}
