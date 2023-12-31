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
        GeometryReader{  geometry in//añadimos geometryreader para la animacion del logo
            ZStack {
                DiagonalSolidShadedBackground()

                VStack {
                    Spacer()
                    LogoAnimationView(screenSize: geometry.size)
                        .padding(.bottom,200)
                    Spacer()
                    
                    Text("Bienvenido a la aplicación de la Unión Cicloturista Burgalesa")
                        .font(.title) // Cambié el font para evitar el error
                        .foregroundColor(.white)
                        .padding()
                        .background(Color.violet5) // Cambié el color para evitar el error
                        .cornerRadius(10)

                    Spacer()
                    /*
                    ProgressView(value: progress, total: 50)
                        .progressViewStyle(LinearProgressViewStyle())
                        .tint(Color.violet) // Cambié el color para evitar el error
                        .scaleEffect(x: 1, y: 2, anchor: .center)
                        .padding(.bottom, 100)
                     */
                }
                .padding(.bottom, 100)
            }
            
            .onReceive(timer) { _ in
                if progress < 30 {
                    progress += 1
                } else {
                    timer.upstream.connect().cancel() // Detener el temporizador
                    navigateBasedOnAuthentication()
                }
            }
        }
        .onAppear {
            progress = 0
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
