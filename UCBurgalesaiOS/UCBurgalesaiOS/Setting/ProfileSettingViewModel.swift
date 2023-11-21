//
//  SettingViewModel.swift
//  UCBurgalesaiOS
//
//  Created by Markel Juaristi on 20/10/23.
//

import Foundation
import FirebaseAuth
import FirebaseFirestore
import SwiftUI

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
    @Published var selectedImage: UIImage?

    private var firestoreManager = FirestoreManager()
    
    func loadProfile() {
        if let userId = Auth.auth().currentUser?.uid {
            firestoreManager.getProfile(for: userId) { (profile, error) in
                if let profile = profile {
                    self.firstName = profile.firstName
                    self.lastName1 = profile.lastName1
                    self.lastName2 = profile.lastName2
                    self.bikeBrand = profile.bikeBrand
                    self.address = profile.address
                    self.phone = profile.phone
                    self.email = profile.email
                    self.birthDate = profile.birthDate
                    self.federated = profile.federated
                    self.volunteer = profile.volunteer
                    self.rolesInClub = profile.rolesInClub
                    self.profilePhoto = profile.profilePhoto
                    self.photos = profile.photos
                    self.routeType = profile.routeType
                    self.facebookName = profile.facebookName
                    self.stravaAccount = profile.stravaAccount
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
                clubId: self.clubId,
                firstName: self.firstName,
                lastName1: self.lastName1,
                lastName2: self.lastName2,
                bikeBrand: self.bikeBrand,
                address: self.address,
                phone: self.phone,
                email: self.email,
                birthDate: self.birthDate,
                federated: self.federated,
                volunteer: self.volunteer,
                rolesInClub: self.rolesInClub,
                profilePhoto: self.profilePhoto,
                photos: self.photos,
                routeType: self.routeType,
                facebookName: self.facebookName,
                stravaAccount: self.stravaAccount
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
