//
//  MovieItemViewModel.swift
//  MoviesApp
//
//  Created by Anatolii Shumov on 06/09/2023.
//

import Foundation
import SwiftUI

class MovieItemViewModel: ObservableObject {
    let movie: Movie
    var manager: ProtocolFavouriteManager
    @Published var image: Image? = nil
    
    init(movie: Movie) {
        self.movie = movie
        self.manager = FavouriteManager(movie: movie)
    }
    
    func fetchImage() {
        Task {
            do {
                let poster = try await Network.Client.shared.fetchImage(with: self.movie.poster)
                DispatchQueue.main.async {
                    self.image = Image(uiImage: poster)
                }
            } catch {
                DispatchQueue.main.async {
                    self.image = Image(systemName: "film")
                }
                print(error.localizedDescription)
            }
        }
    }
    
    func formattedDate(_ date: String?) -> String {
        guard let inputDate = date else { return "" }
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        guard let date = dateFormatter.date(from: inputDate) else { return "" }
        dateFormatter.dateFormat = "dd MMM yyyy"
        return dateFormatter.string(from: date)
    }
    
    func checkFavourite(_ isFavourite: Bool) -> Bool {
        if isFavourite != manager.isFavourite {
            return manager.isFavourite
        } else {
            return isFavourite
        }
    }
}
