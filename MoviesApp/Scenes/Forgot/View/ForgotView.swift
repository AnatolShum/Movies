//
//  ForgotView.swift
//  MoviesApp
//
//  Created by Anatolii Shumov on 05/09/2023.
//

import SwiftUI

struct ForgotView: View {
    @StateObject var viewModel = ForgotViewModel()
    @Environment (\.dismiss) var dismiss
    
    var body: some View {
        VStack {
            TitleView(title: "Lost password", color: .orange)
            
            Form {
                Section {
                    if viewModel.errorMessage != nil {
                        Text(viewModel.errorMessage!)
                            .foregroundColor(.red)
                    }
                    
                    TextField("Email", text: $viewModel.email)
                        .textFieldStyle(DefaultTextFieldStyle())
                        .textInputAutocapitalization(.never)
                        .autocorrectionDisabled()
                        .colorMultiply(.black)
                    
                    ActionButton(title: "Send password reset", background: .pink.opacity(0.9)) {
                        viewModel.resetPassword()
                    }
                }
                .listRowBackground(Color.white.opacity(0.7))
            }
            .scrollDisabled(true)
            .scrollContentBackground(.hidden)
            .background(Color.orange)
            
            Spacer(minLength: 150)
        }
        .onChange(of: viewModel.isNotError, perform: { newValue in
            if newValue {
                dismiss.callAsFunction()
            }
        })
        .background(Color.orange)
    }
}

struct ForgotView_Previews: PreviewProvider {
    static var previews: some View {
        ForgotView()
    }
}
