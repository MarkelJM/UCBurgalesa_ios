//
//  AppState.swift
//  UCBurgalesaiOS
//
//  Created by Markel Juaristi on 16/10/23.
//

import Foundation

class AppState: ObservableObject {
    @Published var isLoggedIn: Bool = false
    @Published var selectedRide: RideModel? // used for detailroutes inicializator
    @Published var currentView: AppView = .login {
        didSet {
            // Actualiza la visibilidad de la TabBar basada en la vista actual
            isTabViewHidden = !(currentView == .home || currentView == .detailRoute)
        }
    }
    @Published var isTabViewHidden: Bool = true
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
        case detailRoute
    }
}
