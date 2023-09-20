//
//  LoginViewModelMock.swift
//  MoviesApp
//
//  Created by Anatolii Shumov on 14/09/2023.
//

import Foundation
import FirebaseAuth

class MockLoginViewModel: ObservableObject, LoginViewModelProtocol {
    @Published var email: String = ""
    @Published var password: String = ""
    @Published var errorMessage: String? = nil
    
    init() {}
    
    func logIn() {
        guard validate() else { return }
        
        Auth.auth().signIn(withEmail: email, password: password) { [weak self] result, error in
            guard error != nil else { return }
            self?.errorMessage = error?.localizedDescription
        }
    }
    
    private func validate() -> Bool {
        errorMessage = nil
        
        guard !email.trimmingCharacters(in: .whitespaces).isEmpty,
              !password.trimmingCharacters(in: .whitespaces).isEmpty else {
            errorMessage = "Please fill in all fields."
            return false
        }
        
        guard email.contains("@") && email.contains(".") else {
            errorMessage = "Please enter valid email."
            return false
        }
        
        return true
    }
}
