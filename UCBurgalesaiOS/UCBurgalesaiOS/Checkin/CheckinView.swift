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
    
    var body: some View {
        VStack {
            HStack {
                ForEach(RouteType.allCases, id: \.self) { routeType in
                    Button(action: {
                        viewModel.selectedRouteType = routeType
                        viewModel.checkForTodaysRide()
                    }) {
                        Text(routeType.rawValue.capitalized)
                    }
                }
            }
            
            if viewModel.isCheckinAvailable {
                Button("Iniciar Check-in") {
                    showingCheckinSheet = true
                }
                .sheet(isPresented: $showingCheckinSheet) {
                    CheckinSheetView(viewModel: viewModel)
                }
            }
        }
        .alert(isPresented: $viewModel.showAlert) {
            Alert(title: Text("Check-in"), message: Text(viewModel.alertMessage), dismissButton: .default(Text("OK")))
        }
        .navigationBarTitle("Check-in", displayMode: .inline)
        .navigationBarItems(trailing: Button("Cerrar") {
            appState.currentView = .home
        })
    }
}

struct CheckinView_Previews: PreviewProvider {
    static var previews: some View {
        
        CheckinView()
            .environmentObject(AppState())
    }
}
