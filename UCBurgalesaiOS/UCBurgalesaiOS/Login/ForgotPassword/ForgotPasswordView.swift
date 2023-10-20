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
    
    var body: some View {
        VStack(spacing: 20) {
            Text("Restablecer contraseña")
                .font(.largeTitle)
                .fontWeight(.bold)
            
            Text("Introduce tu correo electrónico y te enviaremos instrucciones para restablecer tu contraseña.")
                .multilineTextAlignment(.center)
                .padding(.horizontal)
            
            TextField("Correo electrónico", text: $viewModel.email)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .keyboardType(.emailAddress)
                .autocapitalization(.none)
            
            Button(action: viewModel.resetPassword) {
                Text("Enviar")
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }
            
            if !viewModel.message.isEmpty {
                Text(viewModel.message)
                    .foregroundColor(viewModel.isError ? .red : .green)
                    .padding()
            }
            Spacer()
            Button("Volver al login") {
                presentationMode.wrappedValue.dismiss()
            }
            .padding(.top)
            
            Spacer()
        }
        .padding()
    }
}

struct ForgotPasswordView_Previews: PreviewProvider {
    static var previews: some View {
        ForgotPasswordView()
    }
}
