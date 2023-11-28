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

/*
 struct TabBarView: View {
     @EnvironmentObject var appState: AppState

     var body: some View {
         TabView(selection: $appState.currentView) {
             HomeView()
                 .tabItem {
                     VStack {
                         Image(systemName: "house.fill")
                         Text("Home")
                     }
                     .background(tabIconBackground())
                 }
                 .tag(AppState.AppView.home)
             
             CheckinView()
                 .tabItem {
                     VStack {
                         Image(systemName: "checkmark.circle.fill")
                         Text("Check-in")
                     }
                     .background(tabIconBackground())
                 }
                 .tag(AppState.AppView.checkin)
         }
         .accentColor(Color.violet) // Color de los íconos y texto
     }

     func tabIconBackground() -> some View {
         Circle()
             .foregroundColor(Color.white.opacity(0.3)) // Color y opacidad del fondo
             .frame(width: 30, height: 30)
     }
 }


*/
/*
struct TabBarView_Previews: PreviewProvider {
    static var previews: some View {
        TabBarView()
    }
}
*/
