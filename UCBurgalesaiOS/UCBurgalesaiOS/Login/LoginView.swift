//
//  LoginView.swift
//  UCBurgalesaiOS
//
//  Created by Markel Juaristi on 16/10/23.
//

import SwiftUI

struct LoginView: View {
    @State private var showForgotPassword = false
    
    @ObservedObject var viewModel: LoginViewModel
        
    init(appState: AppState) {
        self.viewModel = LoginViewModel(appState: appState)
    }
    
    var body: some View {
        VStack {
            Image("escudoUCB")
                .resizable()
                .scaledToFit()
                .frame(width: 150, height: 150)
                .padding(.top, 50)
                .padding(.bottom, 50)
            
            TextField("Email", text: $viewModel.email)
                .padding()
                .background(Color.gray.opacity(0.2))
                .cornerRadius(8)
                .padding(.horizontal)
            
            SecureField("Password", text: $viewModel.password)
                .padding()
                .background(Color.gray.opacity(0.2))
                .cornerRadius(8)
                .padding(.horizontal)
            Text("Forgot your password?")
                .onTapGesture {
                    showForgotPassword = true
                }
                .sheet(isPresented: $showForgotPassword) { 
                    ForgotPasswordView()
                }
            
            Button(action: viewModel.login) {
                Text("Login")
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(8)
                    
            }
            .padding(.top)
            
            
            
            Text("Regístrate")
                .onTapGesture {
                    // Navigate to registration view
                }
                .padding(.top, 100)
            
            
            
            
        }
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView(appState: AppState())
    }
}
