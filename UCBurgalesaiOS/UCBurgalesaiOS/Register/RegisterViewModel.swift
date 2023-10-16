//
//  RegisterViewModel.swift
//  UCBurgalesaiOS
//
//  Created by Markel Juaristi on 16/10/23.
//

import Foundation
import SwiftUI
import Combine

class RegisterViewModel: ObservableObject {
    @Published var firstName: String = ""
    @Published var lastName1: String = ""
    // ... (otros campos del modelo)
    @Published var errorMessage: String = ""
    
    private var firestoreManager = FirestoreManager()
    private var cancellables = Set<AnyCancellable>()
    
    func registerProfile() {
        let profile = ProfileModel(
            id: UUID().uuidString,
            clubId: "", // Asume que tienes un valor predeterminado o lo obtienes de alguna manera
            firstName: firstName,
            lastName1: lastName1,
            // ... (otros campos del modelo)
        )
        
        firestoreManager.createProfile(profile: profile) { (success, error) in
            if let error = error {
                self.errorMessage = error.localizedDescription
            } else if success {
                // Navega a la siguiente vista o muestra un mensaje de éxito
            }
        }
    }
}
