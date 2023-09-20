//
//  LeftTitleView.swift
//  MoviesApp
//
//  Created by Anatolii Shumov on 05/09/2023.
//

import SwiftUI

struct MainColorView: View {
    var body: some View {
        ZStack {
            LinearGradient(colors: [.blue.opacity(0.9), .cyan.opacity(0.7), .cyan.opacity(0.5)], startPoint: .topLeading, endPoint: .bottomTrailing)
                .ignoresSafeArea()
        }
    }
}

struct MainColorView_Previews: PreviewProvider {
    static var previews: some View {
        MainColorView()
    }
}
