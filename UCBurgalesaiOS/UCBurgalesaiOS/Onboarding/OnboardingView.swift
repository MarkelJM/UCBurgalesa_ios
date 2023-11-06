//
//  OnboardingView.swift
//  UCBurgalesaiOS
//
//  Created by Markel Juaristi on 6/11/23.
//
import SwiftUI

struct OnboardingView: View {
    @EnvironmentObject var appState: AppState
    @StateObject private var keychainManager = KeychainManager()
    @State private var progress = 0.0

    let timer = Timer.publish(every: 0.1, on: .main, in: .common).autoconnect()

    var body: some View {
        VStack {
            Text("Onboarding")
            ProgressView(value: progress, total: 2)
                .progressViewStyle(LinearProgressViewStyle())
                //.tint(LinearGradient(gradient: Gradient(colors: [Color.red, Color.blue]), startPoint: .leading, endPoint: .trailing))
                .tint(Color.violet3) 
                .onReceive(timer) { _ in
                    if progress < 2 {
                        progress += 0.1
                    } else {
                        timer.upstream.connect().cancel()
                        navigateBasedOnAuthentication()
                    }
                }
                .onAppear {
                    progress = 0 // Reset the progress when the view appears
                }
        }
    }

    private func navigateBasedOnAuthentication() {
        if keychainManager.getToken() != nil {
            appState.currentView = .home
        } else {
            appState.currentView = .login
        }
    }
}

struct OnboardingView_Previews: PreviewProvider {
    static var previews: some View {
        OnboardingView().environmentObject(AppState())
    }
}
