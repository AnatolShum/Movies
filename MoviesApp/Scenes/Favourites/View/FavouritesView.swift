//
//  FavouritesView.swift
//  MoviesApp
//
//  Created by Anatolii Shumov on 04/09/2023.
//

import FirebaseFirestoreSwift
import SwiftUI

struct FavouritesView: View {
    @StateObject var viewModel: FavouritesViewModel
    @FirestoreQuery var favourites: [Favourite]
    private let userID: String
    let layout = [GridItem(.adaptive(minimum: 150, maximum: 180), alignment: .top)]
    
    init(userID: String) {
        self.userID = userID
        self._favourites = FirestoreQuery(collectionPath: "users/\(userID)/favourites")
        self._viewModel = StateObject(wrappedValue: FavouritesViewModel(userID: userID))
    }
    
    var body: some View {
        NavigationView {
            ZStack {
                MainColorView()
                ScrollView {
                    LazyVGrid(columns: layout, spacing: 10) {
                        ForEach(viewModel.favourites) { favourite in
                            NavigationLink {
                                MovieDetailView(movie: favourite)
                            } label: {
                                MovieItem(movie: favourite)
                                    .cornerRadius(20)
                            }
                        }
                    }
                }
            }
            .navigationTitle("Favourites")
        }
        .onAppear {
            viewModel.fetchFavourites(favourites)
        }
    }
}

struct FavouritesView_Previews: PreviewProvider {
    static var previews: some View {
        FavouritesView(userID: "E7KJ8BhuJEeGDJQRQ7asaAxGQ9p1")
    }
}
