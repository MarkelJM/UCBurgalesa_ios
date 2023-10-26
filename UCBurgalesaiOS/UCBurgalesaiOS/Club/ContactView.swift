//
//  ContactView.swift
//  UCBurgalesaiOS
//
//  Created by Markel Juaristi on 25/10/23.
//

import SwiftUI

struct ContactView: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            Text("Para contactar personalmente con nosotros estamos en nuestra sede los Martes y Viernes de 20:30 a 21:30")
                .padding(.bottom, 20)
                .font(.title2)
            
            HStack {
                Image(systemName: "house.fill")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 20, height: 20)
                Text("Unión Cicloturista Burgalesa")
            }
            
            HStack {
                Image(systemName: "mappin.and.ellipse")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 20, height: 20)
                Text("C/ Pintor Manero Nº 7, 09006  Burgos")
            }
            
            HStack {
                Image(systemName: "phone.fill")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 20, height: 20)
                Text("Tel 609 785 799")
            }
            
            HStack {
                Image(systemName: "envelope.fill")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 20, height: 20)
                Text("E-Mail: informacion@ucburgalesa.com")
            }
        }
        .padding()
    }
}

struct ContactView_Previews: PreviewProvider {
    static var previews: some View {
        ContactView()
    }
}
