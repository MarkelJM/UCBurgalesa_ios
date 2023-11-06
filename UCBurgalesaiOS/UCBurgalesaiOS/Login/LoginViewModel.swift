//
//  LoginViewModel.swift
//  UCBurgalesaiOS
//
//  Created by Markel Juaristi on 16/10/23.
//

import Foundation
import FirebaseAuth
import SwiftUI


class LoginViewModel: ObservableObject {
    @Published var email: String = ""
    @Published var password: String = ""
    @Published var errorMessage: String = ""
    
    private var authManager = FirebaseAuthManager()
    @StateObject private var keychainManager = KeychainManager()
    
    var appState: AppState
    init(appState: AppState) {
        self.appState = appState
    }
    
    func login() {
        authManager.login(email: email, password: password) { (success, error) in
            if let error = error {
                self.errorMessage = error.localizedDescription
            } else if success {
                // Aquí debes obtener el token de Firebase y guardarlo
                if let token = Auth.auth().currentUser?.uid { // Usando el UID como token de ejemplo
                    self.keychainManager.saveToken(token) // Corregido aquí
                }
                self.appState.currentView = .home
            }
        }
    }

    
}

