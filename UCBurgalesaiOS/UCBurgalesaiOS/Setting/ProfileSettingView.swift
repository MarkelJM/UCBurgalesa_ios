//
//  SettingView.swift
//  UCBurgalesaiOS
//
//  Created by Markel Juaristi on 20/10/23.
//

import SwiftUI

struct ProfileSettingView: View {
    @ObservedObject var viewModel: ProfileSettingViewModel
    @State private var showEditView: Bool = false
    
    @EnvironmentObject var appState: AppState

    var body: some View {
        VStack {
            HStack {
                BackButton(destination: .home)
                    .environmentObject(appState)
                Spacer()
            }
            
            ScrollView {
                VStack(alignment: .leading) {
                    Text("ID: \(viewModel.id)")
                    Text("Club ID: \(viewModel.clubId)")
                    Text("Nombre: \(viewModel.firstName) \(viewModel.lastName1) \(viewModel.lastName2)")
                    Text("Bike Brand: \(viewModel.bikeBrand ?? "N/A")")
                    Text("Address: \(viewModel.address.street), \(viewModel.address.city), \(viewModel.address.postalCode)")
                    Text("Phone: \(viewModel.phone)")
                    Text("Email: \(viewModel.email)")
                    Text("Birth Date: \(viewModel.birthDate)")
                    Text("Federated: \(viewModel.federated ? "Yes" : "No")")
                    Text("Volunteer: \(viewModel.volunteer ? "Yes" : "No")")
                }
                .padding()

                VStack(alignment: .leading) {
                    Text("Roles in Club: \(viewModel.rolesInClub?.joined(separator: ", ") ?? "N/A")")
                    Text("Route Type: \(viewModel.routeType.rawValue)")
                    Text("Facebook Name: \(viewModel.facebookName ?? "N/A")")
                    Text("Strava Account: \(viewModel.stravaAccount ?? "N/A")")
                    if let photoURL = viewModel.profilePhoto {
                        URLImage(url: photoURL)
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 100, height: 100)
                    } else {
                        // Mostrar una imagen predeterminada o un marcador de posición.
                        Image("placeholderImageName")
                    }
                }
                .padding()
            }
            
            Spacer()
            
            Button(action: {
                showEditView.toggle()
            }) {
                Image(systemName: "pencil") // Icono de lápiz
            }
            .padding()
            .sheet(isPresented: $showEditView) {
                EditProfileSettingView(viewModel: viewModel)
            }
        }
        .onAppear {
            viewModel.loadProfile()
        }
    }
}

struct ProfileSettingView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileSettingView(viewModel: ProfileSettingViewModel())
            .environmentObject(AppState()) 
    }
}



