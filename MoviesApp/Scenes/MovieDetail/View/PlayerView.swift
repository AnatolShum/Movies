//
//  PlayerView.swift
//  MoviesApp
//
//  Created by Anatolii Shumov on 08/09/2023.
//

import SwiftUI
import YouTubeiOSPlayerHelper

struct YTWrapper : UIViewRepresentable {
    var videoID : String
    
    func makeUIView(context: Context) -> YTPlayerView {
        let playerView = YTPlayerView()
        playerView.load(withVideoId: videoID)
        return playerView
    }
    
    func updateUIView(_ uiView: YTPlayerView, context: Context) {
    }
}

struct PlayerView: View {
    let key: String
    var body: some View {
        YTWrapper(videoID: key)
            .ignoresSafeArea()
    }
}

struct PlayerView_Previews: PreviewProvider {
    static var previews: some View {
        PlayerView(key: "KlyknsTJk0w")
    }
}
