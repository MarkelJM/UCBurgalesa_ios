//
//  EditProfileSettingView.swift
//  UCBurgalesaiOS
//
//  Created by Markel Juaristi on 1/11/23.
//

import SwiftUI
import FirebaseAnalytics
import FirebaseAuth

struct EditProfileSettingView: View {
    @ObservedObject var viewModel: ProfileSettingViewModel
    @State private var isImagePickerPresented: Bool = false
    @State private var showConfirmationAlert: Bool = false

    @EnvironmentObject var appState: AppState

    var body: some View {
        ZStack {
            DiagonalSolidShadedBackground()

            ScrollView {
                VStack(spacing: 20) {
                    backButton

                    VStack {
                        TextField("Nombre", text: $viewModel.firstName).textFieldStyle()
                        TextField("Primer apellido", text: $viewModel.lastName1).textFieldStyle()
                        TextField("Segundo apellido", text: $viewModel.lastName2).textFieldStyle()
                        TextField("Marca de bicicleta", text: Binding<String>(
                            get: { viewModel.bikeBrand ?? "" },
                            set: { viewModel.bikeBrand = $0.isEmpty ? nil : $0 }
                        )).textFieldStyle()
                        TextField("Código postal", text: $viewModel.address.postalCode).textFieldStyle()
                        TextField("Ciudad", text: $viewModel.address.city).textFieldStyle()
                        TextField("Calle", text: $viewModel.address.street).textFieldStyle()
                        TextField("Teléfono", text: $viewModel.phone).textFieldStyle()
                        TextField("Correo electrónico", text: $viewModel.email).textFieldStyle()
                    }

                    DatePicker("Fecha de nacimiento", selection: $viewModel.birthDate, displayedComponents: .date)
                        .padding(.horizontal)
                        .background(Color.gray.opacity(0.2))
                        .cornerRadius(10)

                    VStack {
                        Toggle("Federado", isOn: $viewModel.federated).toggleStyleCustom()
                        Toggle("Voluntario", isOn: $viewModel.volunteer).toggleStyleCustom()
                    }

                    Button("Seleccionar foto de perfil") {
                        isImagePickerPresented = true
                    }.deepOrangeButton().frame(maxHeight: 50)

                    if let image = viewModel.selectedImage {
                        Image(uiImage: image)
                            .resizable()
                            .scaledToFit()
                            .frame(width: 100, height: 100)
                            .cornerRadius(50)
                    }

                    Button("Guardar Cambios") {
                        showConfirmationAlert.toggle()
                        // Registro del evento de edición de perfil
                        Analytics.logEvent("profile_edit", parameters: [
                            "userID": Auth.auth().currentUser?.uid as NSObject? ?? "unknown" as NSObject,
                            "timestamp": Date().timeIntervalSince1970 as NSObject
                        ])
                    }
                    .vibrantVioletButton().padding(.top, 50)

                }
                .padding()
                .background(Color.white.opacity(0.9))
                .cornerRadius(15)
                .shadow(radius: 10)
            }
            .sheet(isPresented: $isImagePickerPresented) {
                ImagePicker(image: $viewModel.selectedImage)
            }
            .alert(isPresented: $showConfirmationAlert) {
                Alert(title: Text("Confirmación"),
                      message: Text("¿Estás seguro de que quieres guardar los cambios?"),
                      primaryButton: .default(Text("Guardar")) {
                        viewModel.saveProfile()
                      },
                      secondaryButton: .cancel())
            }
        }
    }

    private var backButton: some View {
        HStack {
            BackButton(destination: .home).environmentObject(appState)
            Spacer()
        }.padding(.horizontal)
    }
}

struct EditProfileSettingView_Previews: PreviewProvider {
    static var previews: some View {
        let sampleViewModel = ProfileSettingViewModel()
        sampleViewModel.firstName = "Juan"
        sampleViewModel.lastName1 = "Pérez"
        return EditProfileSettingView(viewModel: sampleViewModel).environmentObject(AppState())
    }
}



