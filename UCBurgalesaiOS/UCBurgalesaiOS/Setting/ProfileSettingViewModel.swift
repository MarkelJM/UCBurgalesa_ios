//
//  SettingViewModel.swift
//  UCBurgalesaiOS
//
//  Created by Markel Juaristi on 20/10/23.
//

import Foundation
import FirebaseAuth
import FirebaseFirestore

class ProfileSettingViewModel: ObservableObject {
    @Published var id: String = ""
    @Published var clubId: String = ""
    @Published var firstName: String = ""
    @Published var lastName1: String = ""
    @Published var lastName2: String = ""
    @Published var bikeBrand: String?
    @Published var address: Address = Address(postalCode: "", city: "", street: "")
    @Published var phone: String = ""
    @Published var email: String = ""
    @Published var birthDate: Date = Date()
    @Published var federated: Bool = false
    @Published var volunteer: Bool = false
    @Published var rolesInClub: [String]?
    @Published var profilePhoto: URL?
    @Published var photos: [URL]?
    @Published var routeType: ProfileRouteType = .short
    @Published var facebookName: String?
    @Published var stravaAccount: String?

    private var firestoreManager = FirestoreManager()
    
    func loadProfile() {
        if let userId = Auth.auth().currentUser?.uid {
            firestoreManager.getProfile(for: userId) { (profile, error) in
                if let profile = profile {
                    self.firstName = profile.firstName
                    self.lastName1 = profile.lastName1
                    self.lastName2 = profile.lastName2
                    self.profilePhoto = profile.profilePhoto // <-- Agregado aquí
                    // ... Asigna todos los otros campos aquí
                } else if let error = error {
                    print("Error loading profile: \(error.localizedDescription)")
                }
            }
        }
    }
    
    func saveProfile() {
        if let userId = Auth.auth().currentUser?.uid {
            let profile = ProfileModel(
                id: userId,
                clubId: "clubId",
                firstName: firstName,
                lastName1: lastName1,
                lastName2: lastName2,
                bikeBrand: nil,
                address: Address(postalCode: "postalCode", city: "city", street: "street"),
                phone: "phone",
                email: "email",
                birthDate: Date(),
                federated: false,
                volunteer: false,
                rolesInClub: nil,
                profilePhoto: nil,
                photos: nil,
                routeType: .short,
                facebookName: nil,
                stravaAccount: nil 
            )
            
            firestoreManager.updateProfile(profile: profile) { (success, error) in
                if let error = error {
                    print("Error updating profile: \(error.localizedDescription)")
                } else if success {
                    print("Profile updated successfully!")
                }
            }
        }
    }

}
