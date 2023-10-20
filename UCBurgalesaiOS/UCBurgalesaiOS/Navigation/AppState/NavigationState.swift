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
        case .registerEmail:
            RegisterEmailView()
        case .codeVerify:
            CodeVerifyView()
        case .profile:
            ProfileRegisterView()
        case .forgotPassword:
            ForgotPasswordView()
        case .routes:
            RoutesView()
        case .points:
            PointsView()
        case .sponsors:
            SponsorsView()
        case .settings:
            SettingsView()
        case .history:
            HistoryView()
        case .news:
            NewsView()
        }
    }
}

