//
//  MovieDetailViewModel.swift
//  MoviesApp
//
//  Created by Anatolii Shumov on 04/09/2023.
//

import Foundation
import SwiftUI
import FirebaseFirestoreSwift
import FirebaseAuth
import FirebaseFirestore

class MovieDetailViewModel: ObservableObject {
    @Published var uiImage: UIImage? = nil
    @Published var image: Image? = nil
    @Published var photos: [Photos] = []
    @Published var videos: [Videos] = []
    @Published var key: String? = ""
    let movie: Movie
    var manager: ProtocolFavouriteManager
    
    init(movie: Movie) {
        self.movie = movie
        self.manager = FavouriteManager(movie: movie)
    }
    
    func fetchImage() {
        Task {
            do {
                let backdrop = try await Network.Client.shared.fetchImage(with: self.movie.backdrop)
                DispatchQueue.main.async {
                    self.uiImage = backdrop
                    self.image = Image(uiImage: backdrop)
                }
            } catch {
                DispatchQueue.main.async {
                    self.uiImage = UIImage(systemName: "film")
                    self.image = Image(systemName: "film")
                }
                print(error.localizedDescription)
            }
        }
    }
    
    func fetchPhotos() {
        Network.Client.shared.get(.photos(id: movie.id)) { [weak self] (result: Result<Network.Types.Response.Backdrops, Network.Errors>) in
            guard let self = self else { return }
            switch result {
            case .success(let success):
                DispatchQueue.main.async {
                    self.photos = success.backdrops
                }
            case .failure(let failure):
                print(failure.localizedDescription)
            }
        }
    }
    
    func fetchVideos() {
        Network.Client.shared.get(.videos(id: movie.id)) { [weak self] (result: Result<Network.Types.Response.VideoResults, Network.Errors>) in
            guard let self = self else { return }
            switch result {
            case .success(let success):
                DispatchQueue.main.async {
                    self.videos = success.results
                    self.key = self.videoKey()
                }
            case .failure(let failure):
                print(failure.localizedDescription)
            }
        }
    }
    
    func formattedYear() -> String {
        guard let inputDate = movie.releaseDate else { return "" }
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        guard let date = dateFormatter.date(from: inputDate) else { return "" }
        dateFormatter.dateFormat = "(yyyy)"
        return dateFormatter.string(from: date)
    }
    
    private func videoKey() -> String? {
        guard !videos.isEmpty else { return nil }
        let firstVideo = videos.first { $0.official == true && $0.type == "Trailer" && $0.site == "YouTube" }
        guard firstVideo != nil else { return videos.first?.key }
        
        return firstVideo?.key
    }
    
}
