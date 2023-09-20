//
//  MainViewModelMock.swift
//  MoviesApp
//
//  Created by Anatolii Shumov on 14/09/2023.
//

import Foundation
import FirebaseAuth

class MockMainViewModel: ObservableObject, MainViewModelProtocol {
    @Published var currentUserId: String = ""
    private var handler: AuthStateDidChangeListenerHandle?
    
    init() {
        do {
            try Auth.auth().signOut()
        } catch {
            print(error.localizedDescription)
        }
        self.handler = Auth.auth().addStateDidChangeListener({ [weak self] _, user in
            DispatchQueue.main.async {
                self?.currentUserId = user?.uid ?? ""
            }
        })
    }
    
    public var isSignedIn: Bool {
        return Auth.auth().currentUser != nil
    }
    
}
