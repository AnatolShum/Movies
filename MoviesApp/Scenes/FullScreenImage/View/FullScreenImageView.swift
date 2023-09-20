//
//  FullScreenImageView.swift
//  MoviesApp
//
//  Created by Anatolii Shumov on 04/09/2023.
//

import SwiftUI

struct FullScreenImageView: View {
    let paths: [Photos]
    let rows = [GridItem(spacing: 10)]
    
    @State var path: String?
    
    @StateObject var viewModel = FullScreenImageViewModel()
    @State private var scale: CGFloat = 1.0
    @State private var lastScale: CGFloat = 1.0
    
    var body: some View {
        ZStack {
            Color.black.opacity(0.9)
            
            ImagesView(path: path)
                .scaledToFit()
                .scaleEffect(scale)
                .gesture(pinchGesture)
            
            HStack {
                ZStack {
                    RoundedRectangle(cornerRadius: 5)
                        .foregroundColor(.white.opacity(0.3))
                        .frame(width: 32, height: 46)
                    RoundedRectangle(cornerRadius: 5)
                        .foregroundColor(.black.opacity(0.3))
                        .frame(width: 30, height: 44)
                    
                    Button {
                        viewModel.previousPhoto(paths)
                    } label: {
                        Image(systemName: "chevron.left")
                            .resizable()
                            .foregroundColor(.white)
                            .frame(width: 10, height: 20)
                            .bold()
                    }
                }
                Spacer()
                
                ZStack {
                    RoundedRectangle(cornerRadius: 5)
                        .foregroundColor(.white.opacity(0.3))
                        .frame(width: 32, height: 46)
                    RoundedRectangle(cornerRadius: 5)
                        .foregroundColor(.black.opacity(0.3))
                        .frame(width: 30, height: 44)
                    
                    Button {
                        viewModel.nextPhoto(paths)
                    } label: {
                        Image(systemName: "chevron.right")
                            .resizable()
                            .foregroundColor(.white)
                            .frame(width: 10, height: 20)
                            .bold()
                    }
                }
            }
            .padding(.top, 100)
            .padding(.leading, 30)
            .padding(.trailing, 30)
        }
        .ignoresSafeArea()
        .navigationBarItems(
            trailing: Text("\(viewModel.photoIndex) of \(paths.count)")
                .foregroundColor(.yellow.opacity(0.8))
                .padding(.trailing, 20)
        )
        .task {
            viewModel.getImageIndex(path: path, paths: paths)
        }
        .onChange(of: viewModel.newPath) { newValue in
            path = newValue
        }
    }
    
    var pinchGesture: some Gesture {
        MagnificationGesture()
            .onChanged { value in
                let deltaScale = value / lastScale
                lastScale = value
                scale *= deltaScale
            }
            .onEnded { value in
                lastScale = 1.0
                scale = 1.0
            }
    }
}

struct FullScreenImageView_Previews: PreviewProvider {
    static var previews: some View {
        FullScreenImageView(paths: [Photos(path: "/pbrkL804c8yAv3zBZR4QPEafpAR.jpg")], path: "/pbrkL804c8yAv3zBZR4QPEafpAR.jpg")
    }
}
