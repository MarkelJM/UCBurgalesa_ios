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
    @Published var shouldShowTabBar: Bool = true
    @Published var currentView: AppView = .onboarding {
        didSet {
            shouldShowTabBar = !(currentView == .onboarding || currentView == .login)
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
