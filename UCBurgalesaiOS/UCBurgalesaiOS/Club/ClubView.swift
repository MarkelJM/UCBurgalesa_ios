//
//  ClubView.swift
//  UCBurgalesaiOS
//
//  Created by Markel Juaristi on 25/10/23.
//

import SwiftUI

struct ClubView: View {
    @State private var selectedTab: Int = 0
    
    var body: some View {
        VStack {
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
        ClubView()
    }
}
