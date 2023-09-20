//
//  MovieDetailView.swift
//  MoviesApp
//
//  Created by Anatolii Shumov on 04/09/2023.
//

import SwiftUI
import AVKit

struct MovieDetailView: View {
    let movie: Movie
    @StateObject var viewModel: MovieDetailViewModel
    @State var isFavourite: Bool = false
    
    init(movie: Movie) {
        self.movie = movie
        self._viewModel = StateObject(wrappedValue: MovieDetailViewModel(movie: movie))
    }
    
    var body: some View {
        ZStack {
            ScrollView {
                LazyVStack {
                    if viewModel.image != nil {
                        viewModel.image!
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(height: 300)
                    }
                    
                    titleView()
                        .padding(.horizontal)
                    
                    HStack {
                        CircleVoteView(vote: movie.vote ?? 0)
                            .frame(width: 60, height: 60)
                        Text("Score")
                            .font(.title2)
                            .padding(5)
                        
                        Text("|")
                            .font(.system(size: 30))
                            .foregroundColor(.white.opacity(0.5))
                        
                        Spacer()
                        
                        if let key = viewModel.key {
                            NavigationLink {
                                PlayerView(key: key)
                            } label: {
                                Label("Trailer", systemImage:"play.fill")
                                    .font(.title2)
                                    .bold()
                            }
                        } else {
                            Label("Trailer", systemImage: "play.slash.fill")
                                .font(.title2)
                                .bold()
                        }
                        Spacer()
                    }
                    .padding(.leading, 40)
                    .padding(.trailing, 20)
                    
                    VStack(alignment: .leading) {
                        HStack {
                            Text("Overview")
                                .font(.title2)
                                .bold()
                            
                            Spacer()
                        }
                        
                        HStack {
                            Text(movie.overview ?? "")
                                .font(.headline)
                        }
                        .padding(.top, 5)
                    }
                    .padding(.top, 5)
                    .padding(.leading)
                    .padding(.trailing)
                    
                    VStack {
                        HStack {
                            Text("Photos")
                                .font(.title2)
                                .bold()
                            
                            Spacer()
                        }
                        ScrollView(.horizontal) {
                            HStack {
                                ForEach(viewModel.photos) { photo in
                                    NavigationLink {
                                        FullScreenImageView(paths: viewModel.photos, path: photo.path)
                                    } label: {
                                        ImagesView(path: photo.path)
                                            .accessibilityIdentifier("image_\(movie.id!)")
                                    }
                                }
                            }
                            .frame(height: 90)
                        }
                        .scrollIndicators(.hidden)
                    }
                    .padding(.top, 5)
                    .padding(.leading)
                    .padding(.trailing)
                }
                .foregroundColor(.white)
            }
        }
        .navigationBarItems(trailing:
                                Button(action: {
            viewModel.manager.toggleFavourites()
            isFavourite.toggle()
        }) {
            Image(systemName: isFavourite ? "heart.fill" : "heart")
                .foregroundColor(.pink.opacity(0.6))
        })
        .edgesIgnoringSafeArea(.top)
        .background(Color(viewModel.uiImage?.averageColor() ?? .clear))
        .task {
            viewModel.manager.checkFavourite()
            viewModel.fetchImage()
            viewModel.fetchPhotos()
            viewModel.fetchVideos()
        }
        .onChange(of: viewModel.manager.isFavourite) { newValue in
            isFavourite = newValue
        }
    }
    
    @ViewBuilder func titleView() -> some View {
        if (movie.title?.count ?? 0) < 30 {
            HStack {
                Text(movie.title ?? "")
                    .font(.title2)
                    .bold()
                
                Text(viewModel.formattedYear())
                    .font(.body)
            }
        } else {
            VStack {
                Text(movie.title ?? "")
                    .font(.title3)
                    .bold()
                
                Text(viewModel.formattedYear())
                    .font(.body)
            }
        }
    }
}

struct MovieDetailView_Previews: PreviewProvider {
    static var previews: some View {
        MovieDetailView(movie: Movie(
            title: "John Wick: Chapter 4",
            id: 603692,
            backdrop: "/7I6VUdPj6tQECNHdviJkUHD2u89.jpg",
            poster: "/vZloFAK7NmvMGKE7VkF5UHaz0I.jpg",
            releaseDate: "2023-03-22",
            overview: "With the price on his head ever increasing, John Wick uncovers a path to defeating The High Table. But before he can earn his freedom, Wick must face off against a new enemy with powerful alliances across the globe and forces that turn old friends into foes.",
            vote: 7.8))
    }
}
