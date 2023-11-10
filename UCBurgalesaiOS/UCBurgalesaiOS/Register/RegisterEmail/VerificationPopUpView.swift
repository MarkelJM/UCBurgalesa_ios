//
//  VerificationPopUpView.swift
//  UCBurgalesaiOS
//
//  Created by Markel Juaristi on 17/10/23.
//

import SwiftUI

struct VerificationPopUpView: View {
    @Binding var isEmailVerified: Bool
    var checkVerification: () -> Void
    
    var body: some View {
        VStack(spacing: 20) {
            Text("Comprueba tu email para verificar el email")
                .padding()
                .background(Color.gray.opacity(0.2))
                .cornerRadius(10)

            Button(action: checkVerification) {
                Text("Verificado y Registrar")
            }
            .brightOrangeButton() 
        }
        .padding()
        .background(Color.white)
        .cornerRadius(10)
        .shadow(radius: 10)
        .padding(.horizontal, 20)
    }
}


/*
struct VerificationPopUpView_Previews: PreviewProvider {
    static var previews: some View {
        VerificationPopUpView()
    }
}
*/
