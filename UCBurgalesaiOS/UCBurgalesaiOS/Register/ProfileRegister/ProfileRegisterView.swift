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
    
    var body: some View {
        ZStack {
            // Fondo con diseño
            //DiagonalGradient1()
            //DiagonalShadedBackground()
            DiagonalSolidShadedBackground()
            
            
            ScrollView {
                VStack{
                    Text("Rellena tu perfil")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .padding(.top, 20)
                    
                    VStack {
                        TextField("First Name", text: $viewModel.firstName)
                            .textFieldStyle()
                        TextField("Last Name 1", text: $viewModel.lastName1)
                            .textFieldStyle()
                        TextField("Last Name 2", text: $viewModel.lastName2)
                            .textFieldStyle()
                        TextField("Bike Brand", text: Binding<String>(
                            get: { viewModel.bikeBrand ?? "" },
                            set: { viewModel.bikeBrand = $0.isEmpty ? nil : $0 }
                        ))
                        .textFieldStyle()
                    }
                    
                    VStack {
                        TextField("Postal Code", text: $viewModel.postalCode)
                            .textFieldStyle()
                        TextField("City", text: $viewModel.city)
                            .textFieldStyle()
                        TextField("Street", text: $viewModel.street)
                            .textFieldStyle()
                        TextField("Phone", text: $viewModel.phone)
                            .textFieldStyle()
                        TextField("Email", text: $viewModel.email)
                            .textFieldStyle()
                    }
                    
                    DatePicker("Birth Date", selection: $viewModel.birthDate)
                        .padding(.horizontal)
                        .background(Color.gray.opacity(0.2))
                        .cornerRadius(10)
                    
                    
                    VStack {
                        Toggle("Federated", isOn: $viewModel.federated)
                            .toggleStyle(SwitchToggleStyle(tint: .violet))
                        Toggle("Volunteer", isOn: $viewModel.volunteer)
                            .toggleStyle(SwitchToggleStyle(tint: .violet))
                        TextField("Facebook Name", text: Binding<String>(
                            get: { viewModel.facebookName ?? "" },
                            set: { viewModel.facebookName = $0.isEmpty ? nil : $0 }
                        ))
                        .textFieldStyle()
                        TextField("Strava Account", text: Binding<String>(
                            get: { viewModel.stravaAccount ?? "" },
                            set: { viewModel.stravaAccount = $0.isEmpty ? nil : $0 }
                        ))
                        .textFieldStyle()
                    }
                    
                    Button("Select Profile Photo") {
                        isImagePickerPresented = true
                    }
                    .deepOrangeButton()
                    
                    if let image = selectedImage {
                        Image(uiImage: image)
                            .resizable()
                            .scaledToFit()
                            .frame(width: 100, height: 100)
                    }
                    
                    Picker("Route Type", selection: $viewModel.routeType) {
                        Text("Short").tag(ProfileRouteType.short)
                        Text("Long").tag(ProfileRouteType.long)
                    }
                    .padding()
                    .background(Color.gray.opacity(0.2))
                    .cornerRadius(10)

                    
                    
                    Button(action: viewModel.saveProfile) {
                        Text("Save Profile")
                    }
                    .vibrantVioletButton()
                    
                }
                .padding()
                .background(Color.white.opacity(0.9))
                .cornerRadius(15)
                .shadow(radius: 10)
                .padding()
            }
            .sheet(isPresented: $isImagePickerPresented) {
                ImagePicker(image: $selectedImage) // para subir foto desde el móvil
            }
        }
    }
        
}


struct ProfileRegisterView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileRegisterView()
    }
}
