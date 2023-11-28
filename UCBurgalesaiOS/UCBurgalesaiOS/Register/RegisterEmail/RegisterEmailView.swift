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
        ZStack {
            DiagonalSolidShadedBackground() 

            VStack(spacing: 20) {
                HStack{
                    
                    Text("Registrándote")
                        .font(.title)
                        .foregroundColor(Color.white)
                    
                }
                
                Text("Registra tu email, para poder tener conectado tu cuenta con la app")
                    .font(.whatTheFont(size: 20))
                    .foregroundColor(.white)
                    .padding()
                    .background(Color.violet5.opacity(0.3))
                    .cornerRadius(10)
                    .padding(.bottom, 25)
                    
                
                TextField("Email", text: $viewModel.email)
                    .inputFieldStyle()

                SecureField("Contraseña", text: $viewModel.password)
                    .inputFieldStyle()
                SecureField("Repetir Contraseña", text: $viewModel.repeatPassword)
                    .inputFieldStyle()
                Button(action: viewModel.registerAndVerifyEmail) {
                    Text("Verificar Email")
                }
                .vibrantVioletButton()
                .padding(.top, 100)
                
                if viewModel.showVerificationPopup {
                    VerificationPopUpView(isEmailVerified: $viewModel.isEmailVerified, checkVerification: {
                        viewModel.checkEmailVerification(identifier: 1)                    })
                    .frame(maxWidth: 300)
                    .padding()
                    .background(Color.white)
                    .cornerRadius(10)
                    .shadow(radius: 10)
                    .background(Color.black.opacity(0.5).edgesIgnoringSafeArea(.all))
                }

                if viewModel.isEmailVerified {
                    Text("Email verificado, puedes continuar.")
                        .foregroundColor(.green)
                }

                if !viewModel.errorMessage.isEmpty {
                    Text(viewModel.errorMessage)
                        .foregroundColor(.red)
                }
            }
            .padding()
        }
        .edgesIgnoringSafeArea(.all)
    }
}

struct RegisterEmailView_Previews: PreviewProvider {
    static var previews: some View {
        RegisterEmailView()
    }
}



