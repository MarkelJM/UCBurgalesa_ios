//
//  ProfileViewModel.swift
//  UCBurgalesaiOS
//
//  Created by Markel Juaristi on 17/10/23.
//

import Foundation
import Combine

class ProfileViewModel: ObservableObject {
    @Published var firstName: String = ""
    @Published var lastName1: String = ""
    @Published var lastName2: String = ""
    @Published var bikeBrand: String?
    @Published var postalCode: String = ""
    @Published var city: String = ""
    @Published var street: String = ""
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
    @Published var errorMessage: String = ""
    
    private var firestoreManager = FirestoreManager()
    private var cancellables = Set<AnyCancellable>()
    
    func saveProfile() {
        let profile = ProfileModel(
            id: UUID().uuidString,
            clubId: "", // Asume que tienes un valor predeterminado o lo obtienes de alguna manera
            firstName: firstName,
            lastName1: lastName1,
            lastName2: lastName2,
            bikeBrand: bikeBrand,
            address: Address(postalCode: postalCode, city: city, street: street),
            phone: phone,
            email: email,
            birthDate: birthDate,
            federated: federated,
            volunteer: volunteer,
            rolesInClub: rolesInClub,
            profilePhoto: profilePhoto,
            photos: photos,
            routeType: routeType,
            facebookName: facebookName,
            stravaAccount: stravaAccount
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
