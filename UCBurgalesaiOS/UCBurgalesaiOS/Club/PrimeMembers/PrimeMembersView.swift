//
//  PrimeMembersView.swift
//  UCBurgalesaiOS
//
//  Created by Markel Juaristi on 25/10/23.
//

import SwiftUI

struct PrimeMembersView: View {
    
    let viewmodel = PrimeMembersViewModel()
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                Text("Presidentes")
                    .font(.title2)
                    .padding(.top)
                
                ForEach(viewmodel.presidentes, id: \.self) { presidente in
                    Text(presidente)
                }
                
                Text("Socios con 25 temporadas")
                    .font(.title2)
                    .padding(.top)
                
                Text("En 1996 la Sociedad cumplió 25 temporada, desde ese día cada temporada se hace un pequeño homenaje a esos socios fieles con la sociedad, entregándo una placa conmemorativa.")
                
                Text("Socios fundadores")
                    .font(.title2)
                    .padding(.top)
                
                ForEach(viewmodel.sociosFundadores, id: \.self) { socio in
                    Text(socio)
                }
                
                Text("Socios con veintinco temporadas")
                    .font(.title2)
                    .padding(.top)
                
                ForEach(viewmodel.socios25Temporadas, id: \.self) { socio in
                    Text(socio)
                }
            VStack(alignment: .leading, spacing: 20) {
                Text("Socios de Honor")
                    .font(.title2)
                    .padding(.top)
                
                Text("Son socios que han realizado una función entrañable dentro de la sociedad.")
                
                ForEach(viewmodel.sociosHonor, id: \.self) { socio in
                    Text(socio)
                }
            }
                
            }
            .padding()
        }
    }
    
    
}

struct PrimeMembersView_Previews: PreviewProvider {
    static var previews: some View {
        PrimeMembersView()
    }
}

