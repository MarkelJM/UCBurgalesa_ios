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
            ProgressView(value: progress, total: 10)
                .progressViewStyle(LinearProgressViewStyle())
                .tint(Color.violet3)
                .onReceive(timer) { _ in
                    if progress < 10 {
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
        if progress >= 10 { // Asegúrate de que esta condición coincida con el progreso total
            if keychainManager.getToken() != nil {
                DispatchQueue.main.async {
                    self.appState.currentView = .home
                }
            } else {
                DispatchQueue.main.async {
                    self.appState.currentView = .login
                }
            }
        }
    }
}

struct OnboardingView_Previews: PreviewProvider {
    static var previews: some View {
        OnboardingView().environmentObject(AppState())
    }
}
