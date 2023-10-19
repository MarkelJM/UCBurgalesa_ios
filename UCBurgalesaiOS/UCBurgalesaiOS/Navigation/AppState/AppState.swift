//
//  AppState.swift
//  UCBurgalesaiOS
//
//  Created by Markel Juaristi on 16/10/23.
//

import Foundation

class AppState: ObservableObject {
    @Published var isLoggedIn: Bool = false
    @Published var currentView: AppView = .login
    
    enum AppView {
        case login
        case registerEmail
        case codeVerify
        case profile
    }
}
