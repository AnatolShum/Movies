//
//  MoviesAppApp.swift
//  MoviesApp
//
//  Created by Anatolii Shumov on 04/09/2023.
//

import SwiftUI
import FirebaseCore

@main
struct MoviesAppApp: App {
    init() {
        FirebaseApp.configure()
        let temporaryDirectory = NSTemporaryDirectory()
        let urlCache = URLCache(memoryCapacity: 25_000_000,
                                diskCapacity: 50_000_000,
                                diskPath: temporaryDirectory)
        URLCache.shared = urlCache
    }
    
    var body: some Scene {
        WindowGroup {
            if ProcessInfo().arguments.contains("-ui-testing") {
                MainView(viewModel: MockMainViewModel())
            } else {
                MainView()
            }
        }
    }
}
