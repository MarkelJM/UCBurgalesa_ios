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
        ZStack {
            DiagonalSolidShadedBackground()
                .edgesIgnoringSafeArea(.all)

            VStack {
                headerView

                ScrollView {
                    VStack(spacing: 20) {
                        ForEach(viewModel.sponsors, id: \.sponsorURL) { sponsor in
                            if let validURL = URL(string: sponsor.sponsorURL) {
                                URLImage(url: validURL)
                                    .aspectRatio(contentMode: .fit)
                                    .frame(maxWidth: .infinity, maxHeight: 200)
                                    .cornerRadius(10)
                                    .padding()
                            } else {
                                Text("URL inválida")
                                    .foregroundColor(.red)
                                    .textStyle()
                            }
                        }
                    }
                    .padding()
                    .background(Color.white.opacity(0.9))
                    .cornerRadius(15)
                    .shadow(radius: 10)
                }
            }
        }
        .onAppear {
            viewModel.fetchSponsors()
        }
    }

    var headerView: some View {
        HStack {
            BackButton(destination: .home)
                .environmentObject(appState)
                .border(Color.white, width: 2)
            Spacer()
            Text("Patrocinadores")
                .font(.whatTheFont(size: 24))
            Spacer()
        }
    }
}

struct SponsorsView_Previews: PreviewProvider {
    static var previews: some View {
        SponsorsView().environmentObject(AppState())
    }
}


