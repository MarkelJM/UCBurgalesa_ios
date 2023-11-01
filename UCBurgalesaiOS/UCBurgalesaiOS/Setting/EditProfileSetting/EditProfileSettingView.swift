//
//  EditProfileSettingView.swift
//  UCBurgalesaiOS
//
//  Created by Markel Juaristi on 1/11/23.
//

import SwiftUI

struct EditProfileSettingView: View {
    @ObservedObject var viewModel: ProfileSettingViewModel
    @State private var showConfirmationAlert: Bool = false
    
    @EnvironmentObject var appState: AppState

    
    var body: some View {
        VStack {
            HStack {
                BackButton(destination: .home)
                    .environmentObject(appState)
                Spacer()
                
            }
            
            VStack(alignment: .leading) {
                TextField("First Name", text: $viewModel.firstName)
                TextField("Last Name 1", text: $viewModel.lastName1)
                // ... Agrega todos los otros campos aquí para editar
            }
            .padding()
            
            Button(action: {
                showConfirmationAlert.toggle()
            }) {
                Text("Guardar Cambios")
            }
            .alert(isPresented: $showConfirmationAlert) {
                Alert(title: Text("Confirmación"),
                      message: Text("¿Estás seguro de que quieres guardar los cambios?"),
                      primaryButton: .default(Text("Guardar")) {
                        viewModel.saveProfile()
                      },
                      secondaryButton: .cancel())
            }
            .padding()
        }
    }
}

struct EditProfileSettingView_Previews: PreviewProvider {
    static var previews: some View {
        EditProfileSettingView(viewModel: ProfileSettingViewModel())
    }
}

