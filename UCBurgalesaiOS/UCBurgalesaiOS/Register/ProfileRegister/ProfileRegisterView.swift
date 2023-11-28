//
//  ProfileView.swift
//  UCBurgalesaiOS
//
//  Created by Markel Juaristi on 17/10/23.
//
import SwiftUI

struct ProfileRegisterView: View {
    @StateObject var viewModel = ProfileRegisterViewModel()
    @State private var isImagePickerPresented: Bool = false
    @State private var selectedImage: UIImage?
    @EnvironmentObject var appState: AppState

    
    var body: some View {
        ZStack {
            DiagonalSolidShadedBackground()
            
            ScrollView {
                HStack{
                    
                    Text("Registrándote")
                        .font(.title)
                        .foregroundColor(Color.white)
                }
                VStack(spacing: 20) {

                    Text("Completa tu perfil")
                        .font(.whatTheFont(size: 24))
                        .foregroundColor(.black)
                        .fontWeight(.bold)
                        .padding(.top, 20)
                    
                    VStack {
                        TextField("Nombre", text: $viewModel.firstName)
                            .textFieldStyle()
                        TextField("Primer apellido", text: $viewModel.lastName1)
                            .textFieldStyle()
                        TextField("Segundo apellido", text: $viewModel.lastName2)
                            .textFieldStyle()
                        TextField("Marca de bicicleta", text: Binding<String>(
                            get: { viewModel.bikeBrand ?? "" },
                            set: { viewModel.bikeBrand = $0.isEmpty ? nil : $0 }
                        ))
                        .textFieldStyle()
                    }
                    
                    VStack {
                        TextField("Código postal", text: $viewModel.postalCode)
                            .textFieldStyle()
                        TextField("Ciudad", text: $viewModel.city)
                            .textFieldStyle()
                        TextField("Calle", text: $viewModel.street)
                            .textFieldStyle()
                        TextField("Teléfono", text: $viewModel.phone)
                            .textFieldStyle()
                        TextField("Correo electrónico", text: $viewModel.email)
                            .textFieldStyle()
                    }
                    
                    DatePicker("Fecha de nacimiento", selection: $viewModel.birthDate, displayedComponents: .date)
                        .padding(.horizontal)
                        .background(Color.gray.opacity(0.2))
                        .cornerRadius(10)
                    
                    VStack {
                        Toggle("Federado", isOn: $viewModel.federated)
                            .toggleStyleCustom()
                        Toggle("Voluntario", isOn: $viewModel.volunteer)
                            .toggleStyleCustom()
                        TextField("Nombre en Facebook", text: Binding<String>(
                            get: { viewModel.facebookName ?? "" },
                            set: { viewModel.facebookName = $0.isEmpty ? nil : $0 }
                        ))
                        .textFieldStyle()
                        TextField("Cuenta de Strava", text: Binding<String>(
                            get: { viewModel.stravaAccount ?? "" },
                            set: { viewModel.stravaAccount = $0.isEmpty ? nil : $0 }
                        ))
                        .textFieldStyle()
                    }
                    
                    Button("Seleccionar foto de perfil") {
                        isImagePickerPresented = true
                    }
                    .deepOrangeButton()
                    .frame(maxHeight: 50)
                    
                    if let image = selectedImage {
                        Image(uiImage: image)
                            .resizable()
                            .scaledToFit()
                            .frame(width: 100, height: 100)
                            .cornerRadius(50)
                    }
                    HStack{
                        Picker("Tipo de ruta", selection: $viewModel.routeType) {
                            Text("Corta").tag(ProfileRouteType.short)
                            Text("Larga").tag(ProfileRouteType.long)
                        }
                        .frame(maxHeight: 50)
                        .background(Color.brightOrange)
                        .cornerRadius(10)
                        .padding(.horizontal)

                        
                    }
                    
                    
                    Button("Guardar perfil") {
                        viewModel.saveProfile()
                    }
                    .vibrantVioletButton()
                    .padding(.top, 100)
                }
                .padding()
                .background(Color.white.opacity(0.9))
                .cornerRadius(15)
                .shadow(radius: 10)
                .padding()
            }
            .sheet(isPresented: $isImagePickerPresented) {
                ImagePicker(image: $selectedImage)
            }
        }
    }
}

struct ProfileRegisterView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileRegisterView()
    }
}

