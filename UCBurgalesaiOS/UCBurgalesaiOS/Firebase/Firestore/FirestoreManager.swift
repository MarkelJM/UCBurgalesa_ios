//
//  FirestoreManager.swift
//  UCBurgalesaiOS
//
//  Created by Markel Juaristi on 16/10/23.
//

import Foundation
import FirebaseFirestore

class FirestoreManager {
    private var db = Firestore.firestore()
    
    func createProfile(profile: ProfileModel, completion: @escaping (Bool, Error?) -> Void) {
        let data = profile.toFirestoreData()
        db.collection("Profiles").document(profile.id).setData(data) { error in
            if let error = error {
                completion(false, error)
                return
            }
            completion(true, nil)
        }
    }
    
    func getProfile(withId id: String, completion: @escaping (ProfileModel?, Error?) -> Void) {
        db.collection("Profiles").document(id).getDocument { (document, error) in
            if let error = error {
                completion(nil, error)
                return
            }
            
            if let document = document, document.exists, let data = document.data() {
                let profile = ProfileModel(from: data)
                completion(profile, nil)
            } else {
                completion(nil, nil)
            }
        }
    }
    
    func updateProfile(profile: ProfileModel, completion: @escaping (Bool, Error?) -> Void) {
        let data = profile.toFirestoreData()
        db.collection("Profiles").document(profile.id).updateData(data) { error in
            if let error = error {
                completion(false, error)
                return
            }
            completion(true, nil)
        }
    }
    ///Registration verification code
    func getVerifier(for identifier: Int, completion: @escaping (Verifier?, Error?) -> Void) {
        let documentId = "\(identifier - 1)"
        db.collection("Verificadores").document(documentId).getDocument { (document, error) in
            if let error = error {
                completion(nil, error)
                return
            }
            
            if let documentData = document?.data(),
               let identifierCiclista = documentData["IndetificadorCiclista"] as? String,
               let emailUser = documentData["emailUser"] as? String,
               let registered = documentData["registered"] as? Bool,
               let verifierCode = documentData["verificador"] as? String {
                
                let verifier = Verifier(identifierCiclista: identifierCiclista, emailUser: emailUser, registered: registered, verifierCode: verifierCode)
                completion(verifier, nil)
            } else {
                completion(nil, nil)
            }
        }
    }
    
    func updateEmail(for identifier: Int, email: String, completion: @escaping (Error?) -> Void) {
        let documentId = "\(identifier - 1)"
        db.collection("Verificadores").document(documentId).updateData(["emailUser": email]) { error in
            completion(error)
        }
    }
    
    func markAsRegistered(for identifier: Int, completion: @escaping (Error?) -> Void) {
        let documentId = "\(identifier - 1)"
        db.collection("Verificadores").document(documentId).updateData(["registered": true]) { error in
            completion(error)
        }
    }
}
