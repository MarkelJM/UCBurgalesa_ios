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
                    VStack {
                        Image(systemName: "house.fill")
                        Text("Home")
                            .background(Color.blue)
                    }
                }
                .tag(AppState.AppView.home)
                .background(Color.blue) // Fondo para el tabItem

            CheckinView()
                .tabItem {
                    VStack {
                        Image(systemName: "checkmark.circle.fill")
                        Text("Check-in")
                    }
                }
                .tag(AppState.AppView.checkin)
                .background(Color.white) // Fondo para el tabItem
        }
        .accentColor(Color.violet) // Color de los íconos y texto
        .background(Color.gray.opacity(0.5)) // Fondo para toda la TabBar
    }
}

