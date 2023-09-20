//
//  TitleView.swift
//  MoviesApp
//
//  Created by Anatolii Shumov on 04/09/2023.
//

import SwiftUI

struct TitleView: View {
    let title: String
    let color: Color
    var body: some View {
        ZStack {
            color
                .ignoresSafeArea()
            
            VStack {
                Text(title)
                    .font(.system(size: 40))
                    .foregroundColor(.white)
                    .bold()
                
                Spacer()
            }
        }
    }
}

struct TitleView_Previews: PreviewProvider {
    static var previews: some View {
        TitleView(title: "Title", color: .black)
    }
}
