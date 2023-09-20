//
//  FullScreenImageViewModel.swift
//  MoviesApp
//
//  Created by Anatolii Shumov on 04/09/2023.
//

import Foundation

class FullScreenImageViewModel: ObservableObject {
    @Published var photoIndex: Int = 1
    @Published var newPath: String? = nil
    
    func getImageIndex(path: String?, paths: [Photos]) {
        guard let path = path else { return }
        for (index, element) in paths.enumerated() {
            if element.path == path {
                DispatchQueue.main.async {
                    self.photoIndex = index + 1
                }
            }
        }
    }
    
    private func newPath(_ paths: [Photos]) {
        DispatchQueue.main.async {
            self.newPath = paths[self.photoIndex - 1].path
        }
    }
    
    func previousPhoto(_ paths: [Photos]) {
        if photoIndex > 1 {
            photoIndex -= 1
            newPath(paths)
        } else {
            photoIndex = paths.count
            newPath(paths)
        }
    }
    
    func nextPhoto(_ paths: [Photos]) {
        if photoIndex < paths.count {
            photoIndex += 1
            newPath(paths)
        } else {
            photoIndex = 1
            newPath(paths)
        }
    }
}
