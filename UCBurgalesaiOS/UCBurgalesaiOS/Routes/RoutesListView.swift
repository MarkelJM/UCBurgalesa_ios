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
        VStack {
            HStack {
                BackButton(destination: .home)
                    .environmentObject(appState)
                Spacer()
                
            }
            .padding()
            
            Text("Rutas")
            List(viewModel.rides) { ride in
                HStack {
                    VStack(alignment: .leading) {
                        Text(ride.rideName).font(.headline)
                        Text(ride.organizer).font(.subheadline)
                        Text(ride.restStopName).font(.subheadline)
                        Text(DateFormatter.firestoreDateOnlyFormatter.string(from: ride.date)).font(.subheadline)
                    }
                    Spacer()
                    URLImage(url: ride.routeImage)
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 100, height: 100)
                }
            }
            .onAppear(perform: viewModel.fetchRides)
        }
        
    }
}

struct RoutesListView_Previews: PreviewProvider {
    static var previews: some View {
        RoutesListView().environmentObject(AppState())
    }
}




