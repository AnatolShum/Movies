//
//  RegisterView.swift
//  MoviesApp
//
//  Created by Anatolii Shumov on 04/09/2023.
//

import SwiftUI

struct RegisterView: View {
    @StateObject var viewModel = RegisterViewModel()
    
    var body: some View {
        VStack {
            TitleView(title: "Register", color: .green)
            
            Form {
                Section {
                    if viewModel.errorMessage != nil {
                        Text(viewModel.errorMessage!)
                            .foregroundColor(.red)
                    }
                    
                    TextField("Name", text: $viewModel.name)
                        .textFieldStyle(DefaultTextFieldStyle())
                        .autocorrectionDisabled()
                        .textInputAutocapitalization(.words)
                        .colorMultiply(.black)
                    
                    TextField("Email address", text: $viewModel.email)
                        .textFieldStyle(DefaultTextFieldStyle())
                        .autocorrectionDisabled()
                        .textInputAutocapitalization(.never)
                        .colorMultiply(.black)
                    
                    SecureField("Password", text: $viewModel.password)
                        .textFieldStyle(DefaultTextFieldStyle())
                        .colorMultiply(.black)
                    
                    ActionButton(title: "Create account", background: .blue) {
                        viewModel.register()
                    }
                }
                .listRowBackground(Color.white.opacity(0.7))
            }
            .scrollDisabled(true)
            .scrollContentBackground(.hidden)
            .background(Color.green)
            Spacer(minLength: 120)
        }
        .background(Color.green)
    }
}

struct RegisterView_Previews: PreviewProvider {
    static var previews: some View {
        RegisterView()
    }
}
