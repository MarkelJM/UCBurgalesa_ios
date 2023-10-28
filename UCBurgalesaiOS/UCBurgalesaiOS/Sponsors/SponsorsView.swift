//
//  SponsorsView.swift
//  UCBurgalesaiOS
//
//  Created by Markel Juaristi on 20/10/23.
//

import SwiftUI

struct SponsorsView: View {
    @StateObject var viewModel = SponsorsViewModel()
    @EnvironmentObject var appState: AppState


    var body: some View {
        VStack {
            HStack {
                BackButton(destination: .home)
                    .environmentObject(appState)
                Spacer()
                
            }
            .padding()
            Text("Patrocinadores")
                .font(.largeTitle)
                .padding()

            List(viewModel.sponsors, id: \.sponsorURL) { sponsor in
                if let validURL = URL(string: sponsor.sponsorURL) {
                    URLImage(url: validURL)
                        .aspectRatio(contentMode: .fit)
                        .padding()
                } else {
                    Text("URL inválida")
                        .foregroundColor(.red)
                }
            }
        }
        .onAppear {
            viewModel.fetchSponsors()
        }
    }
}
struct SponsorsView_Previews: PreviewProvider {
    static var previews: some View {
        SponsorsView()
    }
}
