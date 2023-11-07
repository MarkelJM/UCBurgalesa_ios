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
        print("Intentando iniciar sesión con: \(email)")
        /*
        if email == "Username" && password == "123456" {
            print("Inicio de sesión exitoso con credenciales predeterminadas")
            DispatchQueue.main.async {
                self.appState.currentView = .home
            }
            return
        }
         */
        print("Intentando iniciar sesión con: \(email)")

        // Verificar si las credenciales predeterminadas están siendo usadas
        if email == "Username" && password == "123456" {
            print("Inicio de sesión exitoso con credenciales predeterminadas")
            DispatchQueue.main.async {
                self.keychainManager.saveToken("default_token")
                self.appState.currentView = .home
            }
            return
        }

        authManager.login(email: email, password: password) { (success, error) in
            DispatchQueue.main.async {
                if let error = error {
                    print("Error de inicio de sesión: \(error.localizedDescription)")
                    self.errorMessage = error.localizedDescription
                } else if success {
                    print("Inicio de sesión exitoso con Firebase")
                    if let token = Auth.auth().currentUser?.uid {
                        self.keychainManager.saveToken(token)
                        print("Token guardado: \(token)")
                    }
                    self.appState.currentView = .home
                }
            }
        }
    }



    
}

