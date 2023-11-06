//
//  TabBarView.swift
//  UCBurgalesaiOS
//
//  Created by Markel Juaristi on 6/11/23.
//

import SwiftUI

struct TabBarView: View {
    @EnvironmentObject var appState: AppState
    
    var body: some View {
        TabView {
            HomeView()
                .tabItem {
                    Label("Home", systemImage: "house.fill")
                }
                .tag(AppState.AppView.home)
            
            // Asegúrate de que CheckinView solo se muestra si hay un selectedRide disponible
            if let selectedRide = appState.selectedRide {
                CheckinView(viewModel: CheckinViewModel(), ride: selectedRide)
                    .tabItem {
                        Label("Check-in", systemImage: "checkmark.circle.fill")
                    }
                    .tag(AppState.AppView.detailRoute)
            }
        }
    }
}

/*
struct TabBarView_Previews: PreviewProvider {
    static var previews: some View {
        TabBarView()
    }
}
*/
