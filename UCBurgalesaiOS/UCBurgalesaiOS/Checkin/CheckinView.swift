//
//  CheckinView.swift
//  UCBurgalesaiOS
//
//  Created by Markel Juaristi on 1/11/23.
//

import SwiftUI

struct CheckinView: View {
    @StateObject var viewModel = CheckinViewModel()
    @EnvironmentObject var appState: AppState
    @State private var showingCheckinSheet = false
    @StateObject private var keychainManager = KeychainManager()

    var body: some View {
        ZStack {
            DiagonalSolidShadedBackground()
                .edgesIgnoringSafeArea(.all)

            VStack(spacing: 20) {
                HStack{
                    Text("U.C. Burgalesa")
                        .font(.whatTheFont(size: 20))

                        
                    Button("Cerrar sesión") {
                        keychainManager.deleteToken()
                        appState.currentView = .login
                    }
                    .vibrantVioletButton() 
                    .frame(maxWidth: .infinity, alignment: .trailing)
                    
                    Spacer()
                }
                .padding()
                //headerView

                Image("EscudoUCB")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 200, height: 200)
                    .padding(.top, 50)

                Text("Selecciona la ruta en la que participas para comenzar el check-in")
                    .textStyle()
                    .padding(.bottom,100)
                    
                

                VStack {
                    HStack {
                        Button(action: {
                            viewModel.selectedRouteType = .all
                            viewModel.checkForTodaysRide()
                        }) {
                            Text("Todas")
                        }
                        .vibrantVioletButton()
                        .frame(maxWidth: .infinity)
                        Button(action: {
                            viewModel.selectedRouteType = .short
                            viewModel.checkForTodaysRide()
                        }) {
                            Text("Corta")
                        }
                        .deepOrangeButton()
                        .frame(maxWidth: .infinity)

                        Button(action: {
                            viewModel.selectedRouteType = .long
                            viewModel.checkForTodaysRide()
                        }) {
                            Text("Larga")
                        }
                        .brightOrangeButton()
                        .frame(maxWidth: .infinity)

                        
                    }
                    .padding(.horizontal)

                    if viewModel.isCheckinAvailable {
                        Button("Iniciar Check-in") {
                            showingCheckinSheet = true
                        }
                        .vibrantVioletButton()
                        .sheet(isPresented: $showingCheckinSheet) {
                            CheckinSheetView(viewModel: viewModel)
                        }
                    }
                }
                .padding()
                .background(Color.white.opacity(0.9))
                .cornerRadius(15)
                .shadow(radius: 10)
            }
        }
        .alert(isPresented: $viewModel.showAlert) {
            Alert(title: Text("Check-in"), message: Text(viewModel.alertMessage), dismissButton: .default(Text("OK")))
        }
    }
    
}

struct CheckinView_Previews: PreviewProvider {
    static var previews: some View {
        CheckinView()
            .environmentObject(AppState())
    }
}



