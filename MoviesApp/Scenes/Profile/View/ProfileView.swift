//
//  ProfileView.swift
//  MoviesApp
//
//  Created by Anatolii Shumov on 04/09/2023.
//

import SwiftUI

struct ProfileView: View {
    @StateObject var viewModel = ProfileViewModel()
    
    var body: some View {
        NavigationView {
            ZStack {
                MainColorView()
                
                if let user = viewModel.user {
                    profile(user)
                } else {
                    VStack(alignment: .center) {
                        ProgressView()
                            .progressViewStyle(.circular)
                            .tint(.black.opacity(0.6))
                        
                            .padding(10)
                        
                        Text("Loading ...")
                            .foregroundColor(.black.opacity(0.6))
                    }
                }
            }
            .navigationTitle("Profile")
        }
        .onAppear {
            viewModel.fetchUser()
        }
    }
    
    @ViewBuilder func profile(_ user: User) -> some View {
        VStack {
            Image(systemName: "person.circle")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 100, height: 100)
                .foregroundColor(.black.opacity(0.3))
                .padding(.top, 0)
            
            Form {
                Section("Name") {
                    Text(user.name)
                        .bold()
                }
                .listRowBackground(Color.white.opacity(0.7))
                
                Section("Email") {
                    Text(user.email)
                        .bold()
                }
                .listRowBackground(Color.white.opacity(0.7))
                
                Section("Member since") {
                    Text("\(Date(timeIntervalSince1970: user.joined).formatted(date: .abbreviated, time: .shortened))")
                        .bold()
                }
                .listRowBackground(Color.white.opacity(0.7))
            }
            
            
            
            Form {
                Section {
                    HStack {
                        Button(action: {
                            viewModel.logOut()
                        }) {
                            HStack {
                                Spacer()
                                Text("Sign out")
                                    .font(.headline)
                                    .foregroundColor(.red)
                                
                                Spacer()
                            }
                        }
                    }
                }
                .listRowBackground(Color.white.opacity(0.7))
            }
        }
        .scrollContentBackground(.hidden)
        .scrollDisabled(true)
        .background(Color.cyan.opacity(0))
        .padding(.bottom, -180)
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
    }
}
