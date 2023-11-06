//
//  NavigationState.swift
//  UCBurgalesaiOS
//
//  Created by Markel Juaristi on 16/10/23.
//
import Foundation
import SwiftUI

/*
struct NavigationState: View {
    @EnvironmentObject var appState: AppState
    
    var body: some View {
        
        switch appState.currentView {
        case .onboarding:
            OnboardingView()
        case .login:
            LoginView(appState: appState)
        case .registerEmail:
            RegisterEmailView()
        case .codeVerify:
            CodeVerifyView().environmentObject(appState)
        case .profile:
            ProfileRegisterView()
        case .forgotPassword:
            ForgotPasswordView()
        case .routesList:
            RoutesListView().environmentObject(appState)
        case .points:
            PointsView().environmentObject(appState)
        case .sponsors:
            SponsorsView().environmentObject(appState)
        case .profileSettings:
            ProfileSettingView(viewModel: ProfileSettingViewModel())
        case .club:
            ClubView().environmentObject(appState)
        case .news:
            NewsView()
        case .home:
            HomeView().environmentObject(appState)
        case .detailRoute:
            Group {
                if let selectedRide = appState.selectedRide {
                    DetailRoutesView(viewModel: DetailRoutesViewModel(ride: selectedRide))
                        .environmentObject(appState)
                } else {
                    Text("No ride selected")
                }
            }
        }
        
    }
}
*/


/*

struct NavigationState: View {
    @EnvironmentObject var appState: AppState
    
    var body: some View {
        
        VStack {
            if appState.isTabViewHidden {
                
            
                switch appState.currentView {
                case .onboarding:
                    OnboardingView()
                case .login:
                    LoginView(appState: appState)
                case .registerEmail:
                    RegisterEmailView()
                case .codeVerify:
                    CodeVerifyView().environmentObject(appState)
                case .profile:
                    ProfileRegisterView()
                case .forgotPassword:
                    ForgotPasswordView()
                case .routesList:
                    RoutesListView().environmentObject(appState)
                case .points:
                    PointsView().environmentObject(appState)
                case .sponsors:
                    SponsorsView().environmentObject(appState)
                case .profileSettings:
                    ProfileSettingView(viewModel: ProfileSettingViewModel())
                case .club:
                    ClubView().environmentObject(appState)
                case .news:
                    NewsView()
                case .home:
                    HomeView().environmentObject(appState)
                case .detailRoute:
                    Group {
                        if let selectedRide = appState.selectedRide {
                            DetailRoutesView(viewModel: DetailRoutesViewModel(ride: selectedRide))
                                .environmentObject(appState)
                        } else {
                            Text("No ride selected")
                        }
                    }
                }
                
            }
        }
        
    }
}
*/

struct NavigationState: View {
    @EnvironmentObject var appState: AppState
    
    var body: some View {
        Group {
            if appState.isTabViewHidden {
                switch appState.currentView {
                case .onboarding:
                    OnboardingView()
                case .login:
                    LoginView(appState: appState)
                case .registerEmail:
                    RegisterEmailView()
                case .codeVerify:
                    CodeVerifyView().environmentObject(appState)
                case .profile:
                    ProfileRegisterView()
                case .forgotPassword:
                    ForgotPasswordView()
                case .routesList:
                    RoutesListView().environmentObject(appState)
                case .points:
                    PointsView().environmentObject(appState)
                case .sponsors:
                    SponsorsView().environmentObject(appState)
                case .profileSettings:
                    ProfileSettingView(viewModel: ProfileSettingViewModel())
                case .club:
                    ClubView().environmentObject(appState)
                case .news:
                    NewsView()
                case .home:
                    HomeView().environmentObject(appState)
                case .detailRoute:
                    Group {
                        if let selectedRide = appState.selectedRide {
                            DetailRoutesView(viewModel: DetailRoutesViewModel(ride: selectedRide))
                                .environmentObject(appState)
                        } else {
                            Text("No ride selected")
                        }
                    }
                }
            } else {
                TabBarView() // La TabBarView se muestra cuando no está oculta
            }
        }
    }
}
