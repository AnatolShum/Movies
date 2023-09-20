//
//  SearchView.swift
//  MoviesApp
//
//  Created by Anatolii Shumov on 11/09/2023.
//

import SwiftUI

struct SearchView: View {
    @StateObject var viewModel = SearchViewModel()
    @State private var searchText = ""
    let layout = [GridItem(.adaptive(minimum: 150, maximum: 180), alignment: .top)]
    
    var body: some View {
        NavigationStack {
            ZStack {
                MainColorView()
                
                if !viewModel.movies.isEmpty {
                    ScrollView {
                        LazyVGrid(columns: layout, spacing: 10) {
                            ForEach(viewModel.movies) { movie in
                                NavigationLink {
                                    MovieDetailView(movie: movie)
                                } label: {
                                    MovieItem(movie: movie)
                                        .cornerRadius(20)
                                }
                            }
                        }
                    }
                }
            }
            .navigationTitle("Search")
        }
        .searchable(text: $searchText)
        .onChange(of: searchText) { newValue in
            viewModel.fetchMovies(with: newValue)
        }
    }
}

struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        SearchView()
    }
}
