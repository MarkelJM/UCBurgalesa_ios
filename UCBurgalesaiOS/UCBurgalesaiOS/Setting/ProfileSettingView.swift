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
        ZStack {
            DiagonalSolidShadedBackground()

            VStack(spacing: 20) {
                backButton
                ScrollView {
                    VStack(alignment: .leading, spacing: 15) {
                        profilePhotoView
                        group1
                        group2
                        group3
                        group4
                        
                    }
                    .padding()
                    .background(Color.white.opacity(0.9))
                    .cornerRadius(15)
                    .shadow(radius: 10)
                }
                editButton
            }
        }
        .onAppear {
            viewModel.loadProfile()
        }
    }

    private var backButton: some View {
        HStack {
            BackButton(destination: .home).environmentObject(appState)
            Spacer()
        }
        .padding(.horizontal)
    }

    private var group1: some View {
        VStack(alignment: .leading, spacing: 15) {
            Text("Nombre: \(viewModel.firstName)").font(.identifont(size: 18))
            Text("Primer Apellido: \(viewModel.lastName1)").font(.identifont(size: 18))
            Text("Segundo Apellido: \(viewModel.lastName2)").font(.identifont(size: 18))
        }
        .foregroundColor(Color.black)
    }

    private var group2: some View {
        VStack(alignment: .leading, spacing: 15) {
            Text("Marca de Bicicleta: \(viewModel.bikeBrand ?? "N/A")").font(.identifont(size: 18))
            Text("Dirección: \(viewModel.address.street), \(viewModel.address.city), \(viewModel.address.postalCode)").font(.identifont(size: 18))
        }
        .foregroundColor(Color.black)
    }

    private var group3: some View {
        VStack(alignment: .leading, spacing: 15) {
            Text("Teléfono: \(viewModel.phone)").font(.identifont(size: 18))
            Text("Email: \(viewModel.email)").font(.identifont(size: 18))
            Text("Fecha de Nacimiento: \(formattedDate(viewModel.birthDate))").font(.identifont(size: 18))
        }
        .foregroundColor(Color.black)
    }

    private var group4: some View {
        VStack(alignment: .leading, spacing: 15) {
            Text("Federado: \(viewModel.federated ? "Sí" : "No")").font(.identifont(size: 18))
            Text("Voluntario: \(viewModel.volunteer ? "Sí" : "No")").font(.identifont(size: 18))
            Text("Roles en el Club: \(viewModel.rolesInClub?.joined(separator: ", ") ?? "N/A")").font(.identifont(size: 18))
            Text("Tipo de Ruta: \(viewModel.routeType.rawValue)").font(.identifont(size: 18))
            Text("Facebook: \(viewModel.facebookName ?? "N/A")").font(.identifont(size: 18))
            Text("Strava: \(viewModel.stravaAccount ?? "N/A")").font(.identifont(size: 18))
        }
        .foregroundColor(Color.black)
    }

    private var profilePhotoView: some View {
        VStack {
            if let photoURL = viewModel.profilePhoto {
                AsyncImage(url: photoURL) { image in
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 150, height: 150)
                        .cornerRadius(75)
                } placeholder: {
                    ProgressView()
                }
            } else {
                Image(systemName: "person.crop.circle.fill")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 100, height: 100)
                    .cornerRadius(75)
                    .padding(.top, 20)
            }
        }
    }



    private var editButton: some View {
        Button(action: {
            showEditView.toggle()
        }) {
            Text("Editar")
                .font(.identifont(size: 18))
                .foregroundColor(.white)
                .padding()
                .frame(maxWidth: .infinity)
                .background(Color.violet5)
                .cornerRadius(10)
        }
        .padding(.horizontal)
        .padding(.bottom, 20)
        .sheet(isPresented: $showEditView) {
            EditProfileSettingView(viewModel: viewModel)
        }
    }

    private func formattedDate(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd/MM/yyyy"
        return formatter.string(from: date)
    }
}


struct ProfileSettingView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileSettingView(viewModel: ProfileSettingViewModel())
            .environmentObject(AppState())
    }
}




/*
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


*/
