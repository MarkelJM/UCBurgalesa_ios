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
            Text("Para contactar personalmente con nosotros...")
                .textStyle()
            
            Label("Unión Cicloturista Burgalesa", systemImage: "house.fill")
                .labelStyle()
            Label("C/ Pintor Manero Nº 7, 09006 Burgos", systemImage: "mappin.and.ellipse")
                .labelStyle()
            Label("Tel 609 785 799", systemImage: "phone.fill")
                .labelStyle()
            Label("E-Mail: informacion@ucburgalesa.com", systemImage: "envelope.fill")
                .labelStyle()
        }
        .padding()
        .background(DiagonalSolidShadedBackground())
    }
}

struct ContactView_Previews: PreviewProvider {
    static var previews: some View {
        ContactView()
    }
}

