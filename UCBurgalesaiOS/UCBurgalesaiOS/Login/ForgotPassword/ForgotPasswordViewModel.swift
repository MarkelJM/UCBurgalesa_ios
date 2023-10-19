//
//  ForgotPasswordViewModel.swift
//  UCBurgalesaiOS
//
//  Created by Markel Juaristi on 19/10/23.
//

import Foundation
import FirebaseAuth

class ForgotPasswordViewModel: ObservableObject {
    @Published var email: String = ""
    @Published var message: String = ""
    @Published var isError: Bool = false
    
    func resetPassword() {
        Auth.auth().sendPasswordReset(withEmail: email) { error in
            if let error = error {
                self.message = error.localizedDescription
                self.isError = true
            } else {
                self.message = "Se ha enviado un correo para restablecer tu contraseña. Por favor, revisa tu bandeja de entrada."
                self.isError = false
            }
        }
    }
}
