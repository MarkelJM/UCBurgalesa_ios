//
//  CodeVerifyView.swift
//  UCBurgalesaiOS
//
//  Created by Markel Juaristi on 17/10/23.
//

import SwiftUI

struct CodeVerifyView: View {
    @ObservedObject var viewModel = CodeVerifyViewModel()
    @EnvironmentObject var appState: AppState
    
    var body: some View {
        ZStack {
            DiagonalSolidShadedBackground()

            VStack(spacing: 20) {
                HStack{
                    BackButton(destination: .login)
                        .environmentObject(appState)
                    Spacer()
                    Text("Registrándote")
                        .font(.title)
                    Spacer()
                }
                Text("Introduce el código e Identificador que te ha facilitado U.C. Burgalesa")
                    .font(.whatTheFont(size: 20))
                    .foregroundColor(.white)
                    .padding()
                    .background(Color.violet5.opacity(0.3))
                    .cornerRadius(10)
                    .padding(.bottom, 25)


                TextField("Identificador", text: $viewModel.identifier)
                    .keyboardType(.numberPad)
                    .inputFieldStyle()

                TextField("Código", text: $viewModel.code)
                    .inputFieldStyle()

                Button("Verificar") {
                    viewModel.verifyCode()
                }
                .vibrantVioletButton()
                .padding(.top, 150)

            }
            .padding()
            .alert(isPresented: $viewModel.showAlert) {
                Alert(title: Text("Error"), message: Text(viewModel.alertMessage), dismissButton: .default(Text("OK")))
            }
        }
        .edgesIgnoringSafeArea(.all)
    }
}

struct CodeVerifyView_Previews: PreviewProvider {
    static var previews: some View {
        CodeVerifyView()
    }
}
