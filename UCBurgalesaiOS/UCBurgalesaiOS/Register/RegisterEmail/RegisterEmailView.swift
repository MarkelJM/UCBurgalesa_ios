//
//  RegisterEmailView.swift
//  UCBurgalesaiOS
//
//  Created by Markel Juaristi on 17/10/23.
//

import SwiftUI

struct RegisterEmailView: View {
    @StateObject var viewModel = RegisterEmailViewModel()
    
    var body: some View {
        VStack {
            TextField("Email", text: $viewModel.email)
            SecureField("Contraseña", text: $viewModel.password)
            SecureField("Repetir Contraseña", text: $viewModel.repeatPassword)
            
            Button(action: viewModel.registerAndVerifyEmail) {
                Text("Verificar Email")
            }
            
            if viewModel.showVerificationPopup {
                VerificationPopUpView(isEmailVerified: $viewModel.isEmailVerified, checkVerification: {
                    // Aquí debes proporcionar el identificador que corresponde al usuario.
                    // Por simplicidad, usaré 1 como un valor fijo, pero debes obtenerlo de la manera que corresponda.
                    viewModel.checkEmailVerification(identifier: 1)
                })
            }
            
            if viewModel.isEmailVerified {
                // Aquí puedes añadir una navegación a ProfileView
                Text("Email verificado, puedes continuar.")
            }
            
            if !viewModel.errorMessage.isEmpty {
                Text(viewModel.errorMessage)
                    .foregroundColor(.red)
            }
        }
        .padding()
    }
}





struct RegisterEmailView_Previews: PreviewProvider {
    static var previews: some View {
        RegisterEmailView()
    }
}



