//
//  MainView.swift
//  MoviesApp
//
//  Created by Anatolii Shumov on 04/09/2023.
//

import SwiftUI

struct MainView<ViewModel>: View where ViewModel: MainViewModelProtocol {
    @StateObject var viewModel: ViewModel
    
    init(viewModel: ViewModel = MainViewModel()) {
        self._viewModel = StateObject(wrappedValue: viewModel)
        UITabBar.appearance().unselectedItemTintColor = UIColor(Color.cyan.opacity(0.8))
    }
    
    var body: some View {
        if viewModel.isSignedIn, !viewModel.currentUserId.isEmpty {
            tabView
        } else {
            if ProcessInfo().arguments.contains("-ui-testing") {
                LoginView(viewModel: MockLoginViewModel())
            } else {
                LoginView()
            }
        }
    }
    
    @ViewBuilder var tabView: some View {
        TabView {
            MoviesView()
                .tabItem {
                    Label("Movies", systemImage: "film")
                }
            
            FavouritesView(userID: viewModel.currentUserId)
                .tabItem {
                    Label("Favourites", systemImage: "star")
                }
            
            SearchView()
                .tabItem {
                    Label("Search", systemImage: "magnifyingglass")
                }
            
            ProfileView()
                .tabItem {
                    Label("Profile", systemImage: "person")
                }
        }
        .accentColor(.blue.opacity(0.7))
    }
    
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
