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
        ZStack {
            DiagonalSolidShadedBackground()
                .edgesIgnoringSafeArea(.all)

            ScrollView {
                VStack(spacing: 30) {
                    vstackPresidentes
                    vstackSociosFundadores
                    vstackSocios25Temporadas
                    vstackSociosHonor
                }
                .padding()
                .background(Color.white.opacity(0.9))
                .cornerRadius(15)
                .shadow(radius: 10)
                .padding()
            }
        }
    }

    var vstackPresidentes: some View {
        VStack(alignment: .leading, spacing: 10) {
            sectionHeader("Presidentes")
            
            ForEach(viewmodel.presidentes, id: \.self) { presidente in
                Text(presidente)
            }
        }
        .sectionStyle()
    }

    var vstackSociosFundadores: some View {
        VStack(alignment: .leading, spacing: 10) {
            sectionHeader("Socios fundadores")
            
            ForEach(viewmodel.sociosFundadores, id: \.self) { socio in
                Text(socio)
            }
        }
        .sectionStyle()
    }

    var vstackSocios25Temporadas: some View {
        VStack(alignment: .leading, spacing: 10) {
            sectionHeader("Socios con veinticinco temporadas")
            
            ForEach(viewmodel.socios25Temporadas, id: \.self) { socio in
                Text(socio)
            }
        }
        .sectionStyle()
    }

    var vstackSociosHonor: some View {
        VStack(alignment: .leading, spacing: 10) {
            sectionHeader("Socios de Honor")
            
            Text("Son socios que han realizado una función entrañable dentro de la sociedad.")
            
            ForEach(viewmodel.sociosHonor, id: \.self) { socio in
                Text(socio)
            }
        }
        .sectionStyle()
    }
 
    func sectionHeader(_ text: String) -> some View {
        Text(text)
            .font(.title2)
            .padding(.vertical)
    }
    
    
}

struct PrimeMembersView_Previews: PreviewProvider {
    static var previews: some View {
        PrimeMembersView()
    }
}

