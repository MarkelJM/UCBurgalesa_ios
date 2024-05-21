//
//  LoginView.swift
//  UCBurgalesaiOS
//
//  Created by Markel Juaristi on 16/10/23.
//

import SwiftUI

struct LoginView: View {
    @State private var showForgotPassword = false
    @EnvironmentObject var appState: AppState
    @ObservedObject var viewModel: LoginViewModel
        
    init(appState: AppState) {
        self.viewModel = LoginViewModel(appState: appState)
    }
    
    var body: some View {
        ZStack {
            DiagonalSolidShadedBackground()

            VStack {
                Image("escudoUCB")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 150, height: 150)
                    .padding(.top, 200)
                    .padding(.bottom, 50)
                
                TextField("Email", text: $viewModel.email)
                    .textFieldStyle()
                
                SecureField("Contraseña", text: $viewModel.password)
                    .inputFieldStyle()
                
                Button("¿Olvidó su contraseña?") {
                    showForgotPassword = true
                }
                .buttonStyle()
                
                Button(action: viewModel.login) {
                    Text("Iniciar")
                }
                .brightOrangeButton()
                
                Button("Regístrate") {
                    viewModel.register()
                }
                .vibrantVioletButton()
                
                Spacer()
            }
            .padding(.horizontal) 
        }
        .edgesIgnoringSafeArea(.all)
    }
}


struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView(appState: AppState()).environmentObject(AppState())
    }
}


