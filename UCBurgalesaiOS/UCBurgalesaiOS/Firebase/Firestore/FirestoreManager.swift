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
}
