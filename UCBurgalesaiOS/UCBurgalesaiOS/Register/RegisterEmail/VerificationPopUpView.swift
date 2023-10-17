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
        VStack {
            Text("Comprueba tu email para verificar el email")
            Button(action: checkVerification) {
                Text("Verificado y Registrar")
            }
        }
        .padding()
        .background(Color.white)
        .cornerRadius(10)
        .shadow(radius: 10)
    }
}

/*
struct VerificationPopUpView_Previews: PreviewProvider {
    static var previews: some View {
        VerificationPopUpView()
    }
}
*/
