//
//  ForgotViewModel.swift
//  MoviesApp
//
//  Created by Anatolii Shumov on 05/09/2023.
//

import Foundation
import FirebaseAuth

class ForgotViewModel: ObservableObject {
    @Published var email: String = ""
    @Published var errorMessage: String? = nil
    @Published var isNotError: Bool = false
    
    init() {}
    
    func resetPassword() {
        guard validate() else { return }
        
        Auth.auth().sendPasswordReset(withEmail: email) { [weak self] error in
            if error != nil {
                self?.errorMessage = error?.localizedDescription
            } else {
                self?.isNotError = true
            }
        }
    }
    
    func validate() -> Bool {
        errorMessage = nil
        isNotError = false
        
        guard !email.trimmingCharacters(in: .whitespaces).isEmpty else {
            errorMessage = "Please fill in email address."
            return false
        }
        
        guard email.contains("@") && email.contains(".") else {
            errorMessage = "Please enter valid email."
            return false
        }
        
        return true
    }
}
