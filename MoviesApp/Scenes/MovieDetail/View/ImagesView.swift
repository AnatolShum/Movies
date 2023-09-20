//
//  ImagesView.swift
//  MoviesApp
//
//  Created by Anatolii Shumov on 07/09/2023.
//

import SwiftUI

struct ImagesView: View {
    @StateObject var viewModel = ImagesViewModel()
    var path: String?
    
    var body: some View {
        ZStack {
            if viewModel.image != nil {
                viewModel.image!
                    .resizable()
                    .scaledToFit()
            }
        }
        .ignoresSafeArea()
        .onAppear {
            viewModel.fetchImage(with: path)
        }
        .onChange(of: path) { newValue in
            viewModel.fetchImage(with: newValue)
        }
    }
}

struct ImagesView_Previews: PreviewProvider {
    static var previews: some View {
        ImagesView(path: "/pbrkL804c8yAv3zBZR4QPEafpAR.jpg")
    }
}
