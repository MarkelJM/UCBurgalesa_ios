//
//  RoutesView.swift
//  UCBurgalesaiOS
//
//  Created by Markel Juaristi on 20/10/23.
//

import SwiftUI

struct RoutesListView: View {
    @ObservedObject var viewModel: RoutesListViewModel
        
    init(appState: AppState) {
        self.viewModel = RoutesListViewModel(appState: appState)
    }
    var body: some View {
        VStack {
            HStack {
                Image(systemName: "arrow.left")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 20, height: 20)
                    .onTapGesture {
                        viewModel.navigateBackToHome()
                    }
                Spacer()
                Text("Rutas")
            }
            .padding()
            Text("Rutas")
            List(viewModel.rides) { ride in
                HStack {
                    VStack(alignment: .leading) {
                        Text(ride.rideName).font(.headline)
                        Text(ride.organizer).font(.subheadline)
                        Text(ride.restStopName).font(.subheadline)
                        Text(DateFormatter.firestoreDateFormatter.string(from: ride.date)).font(.subheadline)
                    }
                    Spacer()
                    URLImage(url: ride.routeImage)
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 100, height: 100)
                }
            }
            .onAppear(perform: viewModel.fetchRides)
        }
        onChange(of: viewModel.shouldNavigateBackToHome) { shouldNavigate in
            if shouldNavigate {
                viewModel.appState.currentView = .home
                viewModel.shouldNavigateBackToHome = false
            }
        }
    }
}

struct RoutesListView_Previews: PreviewProvider {
    static var previews: some View {
        RoutesListView(appState: AppState())
    }
}

/*
struct RoutesListView_Previews: PreviewProvider {
    static var previews: some View {
        RoutesListView()
    }
}
*/
