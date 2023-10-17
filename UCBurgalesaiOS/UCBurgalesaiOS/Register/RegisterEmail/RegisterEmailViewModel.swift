//
//  RegisterEmailViewModel.swift
//  UCBurgalesaiOS
//
//  Created by Markel Juaristi on 17/10/23.
//

import Foundation
import FirebaseAuth
import Combine

class RegisterEmailViewModel: ObservableObject {
    @Published var email: String = ""
    @Published var password: String = ""
    @Published var repeatPassword: String = ""
    @Published var isEmailVerified: Bool = false
    @Published var errorMessage: String = ""
    @Published var showVerificationPopup: Bool = false
    
    private var authManager = FirebaseAuthManager()
    private var firestoreManager = FirestoreManager()
    private var cancellables = Set<AnyCancellable>()
    
    func registerAndVerifyEmail() {
        guard password == repeatPassword else {
            errorMessage = "Las contraseñas no coinciden."
            return
        }
        
        authManager.register(email: email, password: password) { [weak self] success, error in
            if let error = error {
                self?.errorMessage = error.localizedDescription
            } else if success {
                self?.showVerificationPopup = true
            }
        }
    }
    
    func checkEmailVerification(identifier: Int) {
        authManager.checkEmailVerification { [weak self] isVerified in
            if isVerified {
                self?.firestoreManager.updateEmail(for: identifier, email: self?.email ?? "") { error in
                    if let error = error {
                        self?.errorMessage = error.localizedDescription
                    } else {
                        self?.isEmailVerified = true
                        self?.firestoreManager.markAsRegistered(for: identifier) { error in
                            if let error = error {
                                self?.errorMessage = error.localizedDescription
                            }
                        }
                    }
                }
            } else {
                self?.errorMessage = "Por favor, verifica tu email antes de continuar."
            }
        }
    }
}

