//
//  CheckinSheetView.swift
//  UCBurgalesaiOS
//
//  Created by Markel Juaristi on 8/11/23.
//

import SwiftUI

struct CheckinSheetView: View {
    @ObservedObject var viewModel: CheckinViewModel

    var body: some View {
        ZStack{
            DiagonalSolidShadedBackground()
                .edgesIgnoringSafeArea(.all)
            VStack(spacing: 20) {
                
                
                
                Text("Check-in para la ruta")
                    .font(.whatTheFont(size: 24))
                    .padding()

                Button(action: {
                    viewModel.initiateCheckin(type: .start)
                }) {
                    Text("Check-in Salida")
                        .font(.whatTheFont(size: 18))
                }
                .deepOrangeButton()
                .frame(maxWidth: .infinity)

                Button(action: {
                    viewModel.initiateCheckin(type: .rest)
                }) {
                    Text("Check-in Descanso")
                        .font(.whatTheFont(size: 18))
                }
                .brightOrangeButton()
                .frame(maxWidth: .infinity)
            }
            .padding()
            .background(Color.white.opacity(0.9))
            .cornerRadius(15)
            .shadow(radius: 10)
        }
    }
}

struct CheckinSheetView_Previews: PreviewProvider {
    static var previews: some View {
        // Aquí puedes crear un viewModel ficticio o usar uno real si es necesario
        CheckinSheetView(viewModel: CheckinViewModel())
    }
}
