//
//  MovieItem.swift
//  MoviesApp
//
//  Created by Anatolii Shumov on 05/09/2023.
//

import SwiftUI

struct MovieItem: View {
    let movie: Movie
    @StateObject var viewModel: MovieItemViewModel
    @State var isFavourite: Bool = false
    
    init(movie: Movie) {
        self.movie = movie
        self._viewModel = StateObject(wrappedValue: MovieItemViewModel(movie: movie))
    }
    
    var body: some View {
        VStack {
            ZStack(alignment: .top) {
                if viewModel.image != nil {
                    viewModel.image!
                        .resizable()
                        .aspectRatio(1/1.5, contentMode: .fit)
                        .cornerRadius(20)
                        .foregroundColor(.gray.opacity(0.3))
                }
                
                HStack {
                    VStack {
                        Button {
                            viewModel.manager.toggleFavourites()
                            isFavourite.toggle()
                            viewModel.manager.isFavourite.toggle()
                        } label: {
                            Image(systemName: viewModel.checkFavourite(isFavourite) ? "heart.fill" : "heart")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .foregroundColor(.pink.opacity(0.6))
                                .frame(width: 30, height: 30)
                                .padding(.top, 10)
                                .padding(.leading, -10)
                        }
                        Spacer()
                        
                        CircleVoteView(vote: movie.vote ?? 0)
                            .frame(width: 60, height: 60)
                    }
                    .padding(.bottom, -50)
                    .padding(.leading, 10)
                    Spacer()
                }
                Spacer()
            }
            
            HStack {
                Text(movie.title ?? "")
                    .font(.system(size: 16))
                    .foregroundColor(.white)
                    .bold()
                    .multilineTextAlignment(.leading)
                    .frame(height: 40, alignment: .top)
                    .padding(.top, 55)
                    .padding(.leading)
                Spacer()
            }
            
            HStack {
                Text(viewModel.formattedDate(movie.releaseDate))
                    .font(.system(size: 16))
                    .foregroundColor(.white.opacity(0.7))
                    .padding()
                Spacer()
            }
            .frame(height: 20)
            
            Spacer()
        }
        .background(Color.black.opacity(0.9))
        .task {
            viewModel.manager.checkFavourite()
            viewModel.fetchImage()
        }
        .onChange(of: viewModel.manager.isFavourite) { newValue in
            isFavourite = newValue
        }
    }
}

struct MovieItem_Previews: PreviewProvider {
    static var previews: some View {
        MovieItem(movie: Movie(
            title: "John Wick: Chapter 4",
            id: 603692,
            backdrop: "/7I6VUdPj6tQECNHdviJkUHD2u89.jpg",
            poster: "/vZloFAK7NmvMGKE7VkF5UHaz0I.jpg",
            releaseDate: "2023-03-22",
            overview: "With the price on his head ever increasing, John Wick uncovers a path to defeating The High Table. But before he can earn his freedom, Wick must face off against a new enemy with powerful alliances across the globe and forces that turn old friends into foes.",
            vote: 7.8))
    }
}
