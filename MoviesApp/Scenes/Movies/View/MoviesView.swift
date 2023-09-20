//
//  MoviesView.swift
//  MoviesApp
//
//  Created by Anatolii Shumov on 04/09/2023.
//

import SwiftUI

struct MoviesView: View {
    @StateObject var viewModel = MoviesViewModel()
    @State var nowPlayingPage: Int = 1
    @State var topRatedPage: Int = 1
    @State var popularPage: Int = 1
    let layout = [GridItem(.fixed(395))]
    
    init() {
        UINavigationBar.appearance().largeTitleTextAttributes = [.foregroundColor: UIColor.white]
        UINavigationBar.appearance().titleTextAttributes = [.foregroundColor: UIColor.black]
    }
    
    var body: some View {
        NavigationView {
            ZStack {
                MainColorView()
                
                ScrollView {
                    if !viewModel.nowPlaying.isEmpty {
                        Section {
                            ScrollView(.horizontal) {
                                LazyHGrid(rows: layout, spacing: 10) {
                                    ForEach(viewModel.nowPlaying) { movie in
                                        NavigationLink {
                                            MovieDetailView(movie: movie)
                                        } label: {
                                            MovieItem(movie: movie)
                                                .frame(width: 170)
                                                .cornerRadius(20)
                                                .accessibilityIdentifier("item_\(movie.id!)")
                                        }
                                        .onAppear {
                                            if movie == viewModel.nowPlaying.last {
                                                nowPlayingPage += 1
                                                viewModel.fetchNowPlaying(with: nowPlayingPage)
                                            }
                                        }
                                    }
                                }
                                .padding(.leading, 10)
                                .accessibilityIdentifier("nowPlayingGrid")
                            }
                            .scrollIndicators(.hidden)
                        } header: {
                            SectionHeader(title: "Now playing")
                        }
                        Spacer()
                    }
                    
                    if !viewModel.topRated.isEmpty {
                        Section {
                            ScrollView(.horizontal) {
                                LazyHGrid(rows: layout, spacing: 10) {
                                    ForEach(viewModel.topRated) { movie in
                                        NavigationLink {
                                            MovieDetailView(movie: movie)
                                        } label: {
                                            MovieItem(movie: movie)
                                                .frame(width: 170)
                                                .cornerRadius(20)
                                        }
                                        .onAppear {
                                            if movie == viewModel.topRated.last {
                                                topRatedPage += 1
                                                viewModel.fetchTopRated(with: topRatedPage)
                                            }
                                        }
                                    }
                                }
                                .padding(.leading, 10)
                            }
                            .scrollIndicators(.hidden)
                        } header: {
                            SectionHeader(title: "Top rated")
                        }
                        Spacer()
                    }
                    
                    if !viewModel.popular.isEmpty {
                        Section {
                            ScrollView(.horizontal) {
                                LazyHGrid(rows: layout, spacing: 10) {
                                    ForEach(viewModel.popular) { movie in
                                        NavigationLink {
                                            MovieDetailView(movie: movie)
                                        } label: {
                                            MovieItem(movie: movie)
                                                .frame(width: 170)
                                                .cornerRadius(20)
                                        }
                                        .onAppear {
                                            if movie == viewModel.popular.last {
                                                popularPage += 1
                                                viewModel.fetchPopular(with: popularPage)
                                            }
                                        }
                                    }
                                }
                                .padding(.leading, 10)
                            }
                            .scrollIndicators(.hidden)
                        } header: {
                            SectionHeader(title: "Popular")
                        }
                        Spacer()
                    }
                }
            }
            .navigationTitle("Movies")
            .navigationBarTitleDisplayMode(.large)
        }
        .task {
            viewModel.fetchNowPlaying(with: nowPlayingPage)
            viewModel.fetchTopRated(with: topRatedPage)
            viewModel.fetchPopular(with: popularPage)
        }
    }
}

struct MoviesView_Previews: PreviewProvider {
    static var previews: some View {
        MoviesView()
    }
}
