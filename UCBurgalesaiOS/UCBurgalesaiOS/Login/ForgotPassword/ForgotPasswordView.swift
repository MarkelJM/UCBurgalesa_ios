//
//  ForgotPasswordView.swift
//  UCBurgalesaiOS
//
//  Created by Markel Juaristi on 19/10/23.
//

import SwiftUI

struct ForgotPasswordView: View {
    @StateObject var viewModel = ForgotPasswordViewModel()
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject var appState: AppState

    
    var body: some View {
        ZStack {
            DiagonalSolidShadedBackground()
            
            VStack(spacing: 20) {
                HStack{
                    BackButton(destination: .login)
                        .environmentObject(appState)
                    
                    Spacer()
                }
                Spacer()
                
                
                Text("Restablecer contraseña")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                    .padding(.top, 50)
                
                Text("Introduce tu correo electrónico y te enviaremos instrucciones para restablecer tu contraseña.")
                    .multilineTextAlignment(.center)
                    .padding(.horizontal)
                    .foregroundColor(.violet5)
                
                TextField("Correo electrónico", text: $viewModel.email)
                    .inputFieldStyle()
                
                
                Button(action: viewModel.resetPassword) {
                    Text("Enviar")
                }
                .brightOrangeButton()
                .padding(.top, 50)
                
                if !viewModel.message.isEmpty {
                    Text(viewModel.message)
                        .foregroundColor(viewModel.isError ? .red : .green)
                        .padding()
                }
                
                
                Button("Volver al login") {
                    presentationMode.wrappedValue.dismiss()
                }
                .vibrantVioletButton()
                
                Spacer()
            }
            .padding(.horizontal)
        }
        .edgesIgnoringSafeArea(.all)
    }
}

// Aquí, asegúrate de que la extensión brightOrangeButton y vibrantVioletButton estén disponibles
// como se definió anteriormente en tu código.

struct ForgotPasswordView_Previews: PreviewProvider {
    static var previews: some View {
        ForgotPasswordView()
    }
}
