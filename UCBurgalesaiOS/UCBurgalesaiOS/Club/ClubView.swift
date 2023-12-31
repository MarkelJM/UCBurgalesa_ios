//
//  ClubView.swift
//  UCBurgalesaiOS
//
//  Created by Markel Juaristi on 25/10/23.
//

import SwiftUI
import FirebaseAnalytics

struct ClubView: View {
    @State private var selectedTab: Int = 0
    @EnvironmentObject var appState: AppState

    
    var body: some View {
        VStack {
            HStack {
                BackButton(destination: .home)
                    .environmentObject(appState)
                Spacer()
                
            }
            .padding()
            ClubTopTabBar(selectedTab: $selectedTab)
            
            if selectedTab == 0 {
                HistoryView()
            } else if selectedTab == 1 {
                ContactView()
            } else if selectedTab == 2 {
                PrimeMembersView()
            }
            
            Spacer()
        }
        .onAppear {
            // Registro del evento de visualización de la vista del club
            Analytics.logEvent("club_viewed", parameters: nil)
        }
    }
    
}

struct ClubView_Previews: PreviewProvider {
    static var previews: some View {
        let appState = AppState() 
        ClubView().environmentObject(appState)
    }
}

