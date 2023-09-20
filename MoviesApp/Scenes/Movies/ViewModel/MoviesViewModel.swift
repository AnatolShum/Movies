//
//  MoviesViewModel.swift
//  MoviesApp
//
//  Created by Anatolii Shumov on 04/09/2023.
//

import Foundation

class MoviesViewModel: ObservableObject {
    @Published var nowPlaying: [Movie] = []
    @Published var topRated: [Movie] = []
    @Published var popular: [Movie] = []
    
    func fetchNowPlaying(with page: Int) {
        Network.Client.shared.get(.nowPlaying(page: page)) { [weak self] (result: Result<Network.Types.Response.MovieResults, Network.Errors>) in
            guard let self = self else { return }
            DispatchQueue.main.async {
                switch result {
                case .success(let success):
                    success.results.forEach { movie in
                        if !self.nowPlaying.contains(movie) {
                            self.nowPlaying.append(movie)
                        }
                    }
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
        }
    }
    
    func fetchTopRated(with page: Int) {
        Network.Client.shared.get(.topRated(page: page)) { [weak self] (result: Result<Network.Types.Response.MovieResults, Network.Errors>) in
            guard let self = self else { return }
            DispatchQueue.main.async {
                switch result {
                case .success(let success):
                    success.results.forEach { movie in
                        if !self.topRated.contains(movie) {
                            self.topRated.append(movie)
                        }
                    }
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
        }
    }
    
    func fetchPopular(with page: Int) {
        Network.Client.shared.get(.popular(page: page)) { [weak self] (result: Result<Network.Types.Response.MovieResults, Network.Errors>) in
            guard let self = self else { return }
            DispatchQueue.main.async {
                switch result {
                case .success(let success):
                    success.results.forEach { movie in
                        if !self.popular.contains(movie) {
                            self.popular.append(movie)
                        }
                    }
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
        }
    }
    
}
