//
//  HomeView.swift
//  UCBurgalesaiOS
//
//  Created by Markel Juaristi on 20/10/23.
//
import SwiftUI
import KeychainSwift

struct HomeView: View {
    @StateObject var viewModel = HomeViewModel()
    @EnvironmentObject var appState: AppState
    @StateObject private var keychainManager = KeychainManager()
    
    var body: some View {
        NavigationView {
            ZStack {
                DiagonalSolidShadedBackground()
                
                VStack(spacing: 20) {
                    // Botón de cerrar sesión
                    HStack{
                        Text("U.C. Burgalesa")
                            .font(.whatTheFont(size: 20))

                            
                        Button("Cerrar sesión") {
                            keychainManager.deleteToken()
                            appState.currentView = .login
                        }
                        .vibrantVioletButton() // Color violeta para el botón
                        .frame(maxWidth: .infinity, alignment: .trailing)
                        
                        Spacer()
                    }
                    .padding()
                    
                    
                    // Botones organizados en un VStack con transparencia
                    VStack(spacing: 20) {
                        // Primera fila de botones
                        HStack(spacing: 20) {
                            navigationButton(destination: .sponsors, imageName: "patrocinadoresUCB")
                            navigationButton(destination: .club, imageName: "clubUCB")
                        }
                        
                        // Segunda fila de botones
                        HStack(spacing: 20) {
                            navigationButton(destination: .news, imageName: "noticiasUCB")
                            navigationButton(destination: .routesList, imageName: "rutasUCB")
                        }
                        
                        // Tercera fila de botones
                        HStack(spacing: 20) {
                            navigationButton(destination: .profileSettings, imageName: "perfilUCB")
                            navigationButton(destination: .points, imageName: "puntosUCB")
                        }
                    }
                    .padding()
                    .background(Color.white.opacity(0.2))
                    .cornerRadius(15)
                    .shadow(radius: 10)
                    
                    Spacer()
                }
                .padding()
            }
            //.navigationBarTitle("U.C. Burgalesa", displayMode: .inline)
        }
    }
    
    func navigationButton(destination: AppState.AppView, imageName: String) -> some View {
        Button(action: {
            appState.currentView = destination
        }) {
            Image(imageName)
                .resizable()
                .scaledToFit()
                .frame(width: 150, height: 150)
                .cornerRadius(15)
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView().environmentObject(AppState())
    }
}

