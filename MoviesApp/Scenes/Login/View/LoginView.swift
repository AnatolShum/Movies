//
//  LoginView.swift
//  MoviesApp
//
//  Created by Anatolii Shumov on 04/09/2023.
//

import SwiftUI

struct LoginView<ViewModel>: View where ViewModel: LoginViewModelProtocol {
    @StateObject var viewModel: ViewModel
    
    init(viewModel: ViewModel = LoginViewModel()) {
        self._viewModel = StateObject(wrappedValue: viewModel)
    }
    
    var body: some View {
        NavigationView {
            VStack {
                TitleView(title: "Movies", color: .blue)
                
                Form {
                    Section {
                        if viewModel.errorMessage != nil {
                            Text(viewModel.errorMessage!)
                                .foregroundColor(.red)
                        }
                        
                        TextField("Email address", text: $viewModel.email)
                            .textFieldStyle(DefaultTextFieldStyle())
                            .textInputAutocapitalization(.never)
                            .autocorrectionDisabled()
                            .colorMultiply(.black)
                        
                        SecureField("Password", text: $viewModel.password)
                            .textFieldStyle(DefaultTextFieldStyle())
                            .colorMultiply(.black)
                        
                        ZStack {
                            NavigationLink(destination: ForgotView()) {
                                EmptyView()
                            }
                            .opacity(0)
                            .buttonStyle(PlainButtonStyle())
                            
                            HStack {
                                Text("Forgot password?")
                                    .font(.headline)
                                    .foregroundColor(.black).opacity(0.6)
                                Spacer()
                            }
                        }
                        
                        ActionButton(title: "Log in", background: .red.opacity(0.9)) {
                            viewModel.logIn()
                        }
                    }
                    .listRowBackground(Color.white.opacity(0.7))
                }
                .scrollDisabled(true)
                .scrollContentBackground(.hidden)
                .background(Color.blue)
                Spacer(minLength: 50)
                
                VStack {
                    NavigationLink("Create an account", destination: RegisterView())
                        .foregroundColor(.white)
                        .font(.headline)
                        .padding(.bottom, 10)
                }
                Spacer()
            }
            .background(Color.blue)
        }
        .accentColor(Color.black)
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
