//
//  ProfileViewModel.swift
//  UCBurgalesaiOS
//
//  Created by Markel Juaristi on 17/10/23.
//

import Foundation
import Combine
import FirebaseStorage
import FirebaseFirestore
import FirebaseAuth
import SwiftUI

class ProfileRegisterViewModel: ObservableObject {
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
    
    @Published var selectedImage: UIImage?//to upload photo
    
    @EnvironmentObject var appState: AppState
    
    func fetchUserEmail() {
        //para guardar todos los datos que rellena el usuario en firestore--> traemos el email
        if let user = Auth.auth().currentUser {
            self.email = user.email ?? ""
        }
    }

    
    func savePhoto() {
        // Subir la imagen primero
        if let image = selectedImage {
            let storage = Storage.storage()
            let storageRef = storage.reference().child("profile_photos/\(UUID().uuidString).png")

            if let uploadData = image.pngData() {
                storageRef.putData(uploadData, metadata: nil) { (metadata, error) in
                    if let error = error {
                        print(error)
                        return
                    }

                    storageRef.downloadURL { (url, error) in
                        if let error = error {
                            print(error)
                            return
                        }

                        if let profilePhotoURL = url {
                            self.profilePhoto = profilePhotoURL
                            self.saveProfile()
                        }
                    }
                }
            }
        } else {
            saveProfile()
        }
    }
    
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
                // Navegar a la vista principal (home)
                self.appState.currentView = .home
            }
        }
    }
    
    func loadProfile() {
        if let userId = Auth.auth().currentUser?.uid {
            firestoreManager.getProfile(for: userId) { (profile, error) in
                if let profile = profile {
                    // Asignar los datos del perfil a las propiedades del ViewModel
                    self.firstName = profile.firstName
                    self.lastName1 = profile.lastName1
                    self.lastName2 = profile.lastName2
                    self.bikeBrand = profile.bikeBrand
                    self.postalCode = profile.address.postalCode
                    self.city = profile.address.city
                    self.street = profile.address.street
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
                    // Puedes manejar el error aquí, por ejemplo, mostrando un mensaje al usuario
                    print("Error loading profile: \(error.localizedDescription)")
                }
            }
        }
    }

}
