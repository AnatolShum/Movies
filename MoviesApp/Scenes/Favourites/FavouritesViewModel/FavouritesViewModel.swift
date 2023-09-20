//
//  FavouritesViewModel.swift
//  MoviesApp
//
//  Created by Anatolii Shumov on 04/09/2023.
//

import Foundation

class FavouritesViewModel: ObservableObject {
    @Published var favourites: [Movie] = []
    private let userID: String
    init(userID: String) {
        self.userID = userID
    }
    
    func fetchFavourites(_ dbFavourites: [Favourite]) {
        favourites = []
        dbFavourites.forEach { [weak self] favourite in
            guard let self = self else { return }
            Network.Client.shared.get(.movie(id: favourite.movieID)) { (result: Result<Network.Types.Response.MovieObject, Network.Errors>) in
                DispatchQueue.main.async {
                    switch result {
                    case .success(let success):
                        let movie = Movie(title: success.title,
                                          id: success.id,
                                          backdrop: success.backdrop,
                                          poster: success.poster,
                                          releaseDate: success.releaseDate,
                                          overview: success.overview,
                                          vote: success.vote)
                        self.favourites.append(movie)
                    case .failure(let failure):
                        print(failure.localizedDescription)
                    }
                }
            }
        }
    }
}
