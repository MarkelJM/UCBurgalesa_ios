//
//  ClubTopTabBar.swift
//  UCBurgalesaiOS
//
//  Created by Markel Juaristi on 25/10/23.
//

import Foundation
import SwiftUI

struct ClubTopTabBar: View {
    @Binding var selectedTab: Int
    
    var body: some View {
        HStack {
            ForEach(Tab.allCases, id: \.self) { tab in
                Button(action: {
                    self.selectedTab = tab.rawValue
                }) {
                    Text(tab.title)
                        .padding()
                        .background(selectedTab == tab.rawValue ? Color.blue : Color.clear)
                        .foregroundColor(selectedTab == tab.rawValue ? .white : .blue)
                        .cornerRadius(10)
                }
            }
        }
        .padding(.top)
    }
    
    enum Tab: Int, CaseIterable {
        case history = 0
        case contact
        case primeMembers
        
        var title: String {
            switch self {
            case .history:
                return "History"
            case .contact:
                return "Contact"
            case .primeMembers:
                return "PrimeMembers"
            }
        }
    }
}
