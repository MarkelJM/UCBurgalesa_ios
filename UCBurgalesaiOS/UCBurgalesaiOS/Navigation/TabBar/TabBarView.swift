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
        TabView(selection: $appState.currentView) {
            HomeView()
                .tabItem {
                    Label("Home", systemImage: "house.fill")
                }
                .tag(AppState.AppView.home)
            
            // Muestra la vista de Checkin directamente
            CheckinView()
                .tabItem {
                    Label("Check-in", systemImage: "checkmark.circle.fill")
                }
                .tag(AppState.AppView.checkin)
        }
        .accentColor(.primary) // O el color que prefieras para los íconos de la TabBar
    }
}



/*
struct TabBarView_Previews: PreviewProvider {
    static var previews: some View {
        TabBarView()
    }
}
*/
