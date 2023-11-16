//
//  ClubView.swift
//  UCBurgalesaiOS
//
//  Created by Markel Juaristi on 25/10/23.
//

import SwiftUI

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
    }
}

struct ClubView_Previews: PreviewProvider {
    static var previews: some View {
        let appState = AppState() // Asegúrate de que esto se inicializa con los valores necesarios
        ClubView().environmentObject(appState)
    }
}

