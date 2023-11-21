//
//  ContactView.swift
//  UCBurgalesaiOS
//
//  Created by Markel Juaristi on 25/10/23.
//
import SwiftUI

struct ContactView: View {
    var body: some View {
        ZStack {
            DiagonalSolidShadedBackground()
                .edgesIgnoringSafeArea(.all)

            ScrollView {
                
                VStack(spacing: 40) {
                    
                    VStack(alignment: .leading, spacing: 15) {
                        sectionHeader("Contacto")
                            .padding(.horizontal, 100)
                            
                        
                        Label("Unión Cicloturista Burgalesa", systemImage: "house.fill")
                            .padding()
                        Label("C/ Pintor Manero Nº 7, 09006 Burgos", systemImage: "mappin.and.ellipse")
                            .padding()

                        Label("Tel 609 785 799", systemImage: "phone.fill")
                            .padding()

                        Label("E-Mail: informacion@ucburgalesa.com", systemImage: "envelope.fill")
                            .padding()

                    }
                    .sectionStyle()
                }
                .padding(.horizontal, 20)
                .padding(.vertical, 40)
                .background(Color.white.opacity(0.9))
                .cornerRadius(15)
                .shadow(radius: 10)
                .padding(.top, 150)
            }
        }
    }
    
    func sectionHeader(_ text: String) -> some View {
        Text(text)
            .font(.title2)
            .padding(.bottom, 10)
    }
}

struct ContactView_Previews: PreviewProvider {
    static var previews: some View {
        ContactView()
    }
}

