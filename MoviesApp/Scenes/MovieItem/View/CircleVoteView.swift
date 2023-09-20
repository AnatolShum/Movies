//
//  CircleVoitView.swift
//  MoviesApp
//
//  Created by Anatolii Shumov on 06/09/2023.
//

import SwiftUI

struct CircleVoteView: View {
    @StateObject var viewModel = CircleVoteViewModel()
    let vote: Double
    
    var body: some View {
        ZStack {
            Color.black
                .ignoresSafeArea()
                .clipShape(Circle())
            
            Circle()
                .stroke(Color.gray.opacity(0.7), lineWidth: 10)
            
            Circle()
                .trim(from: 0, to: vote / 10)
                .stroke(viewModel.setColor(with: vote), style: StrokeStyle(lineWidth: 5, lineCap: .round))
                .rotationEffect(.degrees(-90))
            
            HStack {
                Image(systemName: "star.fill")
                    .resizable()
                    .foregroundColor(.yellow)
                    .frame(width: 15, height: 15)
                
                Text(viewModel.formattedString(vote))
                    .font(.system(size: 18))
                    .foregroundColor(.white.opacity(0.7))
            }
        }
    }
}

struct CircleVoteView_Previews: PreviewProvider {
    static var previews: some View {
        CircleVoteView(vote: 7.5)
    }
}
