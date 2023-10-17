//
//  CodeVerifyView.swift
//  UCBurgalesaiOS
//
//  Created by Markel Juaristi on 17/10/23.
//

import SwiftUI

struct CodeVerifyView: View {
    @ObservedObject var viewModel = CodeVerifyViewModel()
    
    var body: some View {
        VStack(spacing: 20) {
            TextField("Identificador", text: $viewModel.identifier)
                .keyboardType(.numberPad)
                .padding()
                .border(Color.gray, width: 0.5)
            
            TextField("Código", text: $viewModel.code)
                .padding()
                .border(Color.gray, width: 0.5)
            
            Button("Verificar") {
                viewModel.verifyCode()
            }
            .padding()
            .background(Color.blue)
            .foregroundColor(.white)
            .cornerRadius(8)
        }
        .padding()
        .alert(isPresented: $viewModel.showAlert) {
            Alert(title: Text("Error"), message: Text(viewModel.alertMessage), dismissButton: .default(Text("OK")))
        }
    }
}


struct CodeVerifyView_Previews: PreviewProvider {
    static var previews: some View {
        CodeVerifyView()
    }
}
