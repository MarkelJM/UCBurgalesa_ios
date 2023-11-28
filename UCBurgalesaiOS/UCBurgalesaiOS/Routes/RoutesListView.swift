//
//  RoutesView.swift
//  UCBurgalesaiOS
//
//  Created by Markel Juaristi on 20/10/23.
//
import SwiftUI

struct RoutesListView: View {
    @StateObject var viewModel = RoutesListViewModel()
    @EnvironmentObject var appState: AppState
    
    var body: some View {
        ZStack {
            DiagonalSolidShadedBackground()
                .edgesIgnoringSafeArea(.all)

            VStack(spacing: 20) {
                headerView

                ScrollView {
                    VStack(spacing: 20) {
                        ForEach(viewModel.rides) { ride in
                            Button(action: {
                                appState.currentView = .detailRoute
                            }) {
                                rideCell(ride)
                            }
                            .padding()
                            .background(Color.gray.opacity(0.1))
                            .cornerRadius(10)
                        }
                    }
                    .padding()
                    .background(Color.white.opacity(0.9))
                    .cornerRadius(15)
                    .shadow(radius: 10)
                }
            }
        }
        .onAppear(perform: viewModel.fetchRides)
    }

    var headerView: some View {
        HStack {
            BackButton(destination: .home)
                .environmentObject(appState)
                .border(Color.white, width: 2)
            Spacer()
            Text("Rutas")
                .font(.whatTheFont(size: 24))
            Spacer()
        }
    }

    func rideCell(_ ride: RideModel) -> some View {
        HStack {
            VStack(alignment: .leading) {
                Text(ride.rideName).font(.headline).foregroundColor(Color.violet5)
                Text(ride.organizer).font(.subheadline).foregroundColor(Color.black)
                Text(ride.restStopName).font(.subheadline).foregroundColor(Color.black)
                Text(DateFormatter.firestoreDateOnlyFormatter.string(from: ride.date)).font(.subheadline).foregroundColor(Color.violet5)
            }
            Spacer()
            URLImage(url: ride.routeImage)
                .aspectRatio(contentMode: .fit)
                .frame(width: 100, height: 100)
                .cornerRadius(10)
        }
    }
}

struct RoutesListView_Previews: PreviewProvider {
    static var previews: some View {
        RoutesListView().environmentObject(AppState())
    }
}




