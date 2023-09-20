//
//  SectionHeader.swift
//  MoviesApp
//
//  Created by Anatolii Shumov on 12/09/2023.
//

import SwiftUI

struct SectionHeader: View {
    let title: String
    
    var body: some View {
        HStack {
            Image(systemName: "poweron")
                .resizable()
                .frame(width: 4, height: 30)
                .foregroundColor(.yellow)
                .padding(.leading, 20)
            
            Text(title)
                .font(.title)
                .bold()
                .foregroundColor(.white.opacity(0.9))
            
            Spacer()
        }
        .padding(.top, 10)
    }
}

struct SectionHeader_Previews: PreviewProvider {
    static var previews: some View {
        SectionHeader(title: "Title")
    }
}
