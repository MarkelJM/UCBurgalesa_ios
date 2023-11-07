//
//  AppState.swift
//  UCBurgalesaiOS
//
//  Created by Markel Juaristi on 16/10/23.
//

import Foundation

class AppState: ObservableObject {
    @Published var isLoggedIn: Bool = false
    @Published var selectedRide: RideModel? // Utilizado para el inicializador de DetailRoutes
    @Published var shouldShowTabBar: Bool = false // Por defecto es true para mostrar en home y checkin
    @Published var currentView: AppView = .onboarding {
        didSet {
            // El TabBar se muestra solo en home y checkin
            shouldShowTabBar = (currentView == .home || currentView == .checkin)
            print("shouldShowTabBar is now \(shouldShowTabBar)")
        }
    }
    
    enum AppView {
        case onboarding
        case login
        case registerEmail
        case codeVerify
        case profile
        case forgotPassword
        case routesList
        case points
        case sponsors
        case profileSettings
        case club
        case news
        case home
        case checkin
        case detailRoute
    }
}
