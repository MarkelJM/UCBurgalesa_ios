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
    
    var appState: AppState
    init(appState: AppState) {
        self.appState = appState
    }
    
    func login() {
        // Comprobar si el nombre de usuario y la contraseña son los especificados
        if email == "Username" && password == "123456" {
            appState.currentView = .home
            return
        }
        
        // Si no, continuar con la autenticación de Firebase
        authManager.login(email: email, password: password) { (success, error) in
            if let error = error {
                self.errorMessage = error.localizedDescription
            } else if success {
                // Navigate to the main app or dashboard
            }
        }
    }
}

