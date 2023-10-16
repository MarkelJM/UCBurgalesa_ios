//
//  NavigationState.swift
//  UCBurgalesaiOS
//
//  Created by Markel Juaristi on 16/10/23.
//

import Foundation
import SwiftUI

struct NavigationState: View {
    @EnvironmentObject var appState: AppState
    
    var body: some View {
        switch appState.currentView {
        case .login:
            LoginView()
        }
        
    }
}

