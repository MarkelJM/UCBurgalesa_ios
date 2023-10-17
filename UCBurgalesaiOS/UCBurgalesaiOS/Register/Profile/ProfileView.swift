//
//  ProfileView.swift
//  UCBurgalesaiOS
//
//  Created by Markel Juaristi on 17/10/23.
//

import SwiftUI

struct ProfileView: View {
    @StateObject var viewModel = ProfileViewModel()
    @State private var isImagePickerPresented: Bool = false
    @State private var selectedImage: UIImage?
    
    var body: some View {
        VStack {
            VStack {
                TextField("First Name", text: $viewModel.firstName)
                TextField("Last Name 1", text: $viewModel.lastName1)
                TextField("Last Name 2", text: $viewModel.lastName2)
                TextField("Bike Brand", text: Binding<String>(
                    get: { viewModel.bikeBrand ?? "" },
                    set: { viewModel.bikeBrand = $0.isEmpty ? nil : $0 }
                ))
            }
            
            VStack {
                TextField("Postal Code", text: $viewModel.postalCode)
                TextField("City", text: $viewModel.city)
                TextField("Street", text: $viewModel.street)
                TextField("Phone", text: $viewModel.phone)
                TextField("Email", text: $viewModel.email)
            }
            
            DatePicker("Birth Date", selection: $viewModel.birthDate)
            
            VStack {
                Toggle("Federated", isOn: $viewModel.federated)
                Toggle("Volunteer", isOn: $viewModel.volunteer)
                TextField("Facebook Name", text: Binding<String>(
                    get: { viewModel.facebookName ?? "" },
                    set: { viewModel.facebookName = $0.isEmpty ? nil : $0 }
                ))
                TextField("Strava Account", text: Binding<String>(
                    get: { viewModel.stravaAccount ?? "" },
                    set: { viewModel.stravaAccount = $0.isEmpty ? nil : $0 }
                    /* stravaAccount es opcional (String?). Sin embargo, TextField espera un valor no opcional (String). El Binding personalizado actúa como un puente entre estos dos, convirtiendo el valor opcional en no opcional para el TextField y viceversa.*/
                ))
            }
            
            Button("Select Profile Photo") {
                isImagePickerPresented = true
            }

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
            
            Button(action: viewModel.saveProfile) {
                Text("Save Profile")
            }
        }
        .padding()
        .sheet(isPresented: $isImagePickerPresented) {
            ImagePicker(image: $selectedImage)//to uoload photo from mobile
        }
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
    }
}
