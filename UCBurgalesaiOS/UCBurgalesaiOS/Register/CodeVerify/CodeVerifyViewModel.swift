//
//  CodeVerifyViewModel.swift
//  UCBurgalesaiOS
//
//  Created by Markel Juaristi on 17/10/23.
//

import Foundation
import FirebaseFirestore
import SwiftUI


class CodeVerifyViewModel: ObservableObject {
    @Published var identifier: String = ""
    @Published var code: String = ""
    @Published var showAlert = false
    @Published var alertMessage = ""
    @EnvironmentObject var appState: AppState
    
    private var firestoreManager = FirestoreManager()
    
    func verifyCode() {
        guard let identifierInt = Int(identifier) else {
            alertMessage = "Identificador no válido"
            showAlert = true
            return
        }
        
        firestoreManager.getVerifier(for: identifierInt) { verifier, error in
            if let error = error {
                self.alertMessage = "Error: \(error.localizedDescription)"
                self.showAlert = true
                return
            }
            
            if let verifier = verifier {
                if verifier.verifierCode == self.code {
                    if verifier.registered {
                        self.alertMessage = "Este código ya ha sido registrado."
                        self.showAlert = true
                    } else {
                        // Continuar con el proceso de registro
                        self.appState.currentView = .registerEmail // Navegar a la vista de registro de email
                    }
                } else {
                    self.alertMessage = "Código incorrecto."
                    self.showAlert = true
                }
            } else {
                self.alertMessage = "Identificador no encontrado."
                self.showAlert = true
            }
        }
    }
}
