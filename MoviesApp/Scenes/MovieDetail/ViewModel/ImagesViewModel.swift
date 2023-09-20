//
//  ImagesViewModel.swift
//  MoviesApp
//
//  Created by Anatolii Shumov on 07/09/2023.
//

import Foundation
import SwiftUI

class ImagesViewModel: ObservableObject {
    @Published var image: Image? = nil
    
    func fetchImage(with path: String?) {
        Task {
            do {
                let photo = try await Network.Client.shared.fetchImage(with: path)
                DispatchQueue.main.async {
                    self.image = Image(uiImage: photo)
                }
            } catch {
                DispatchQueue.main.async {
                    self.image = Image(systemName: "film")
                }
                print(error.localizedDescription)
            }
        }
    }
}
