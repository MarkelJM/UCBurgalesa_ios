//
//  FirebaseAuthManager.swift
//  UCBurgalesaiOS
//
//  Created by Markel Juaristi on 16/10/23.
//

import Foundation
import FirebaseAuth

class FirebaseAuthManager {
    
    func login(email: String, password: String, completion: @escaping (Bool, Error?) -> Void) {
        Auth.auth().signIn(withEmail: email, password: password) { (result, error) in
            if let error = error {
                completion(false, error)
                return
            }
            completion(true, nil)
        }
    }
    
    func register(email: String, password: String, completion: @escaping (Bool, Error?) -> Void) {
        Auth.auth().createUser(withEmail: email, password: password) { (result, error) in
            if let error = error {
                completion(false, error)
                return
            }
            self.sendVerificationEmail(completion: completion)
        }
    }
    
    func sendVerificationEmail(completion: @escaping (Bool, Error?) -> Void) {
        Auth.auth().currentUser?.sendEmailVerification(completion: { (error) in
            if let error = error {
                completion(false, error)
                return
            }
            completion(true, nil)
        })
    }
    
    func isEmailVerified() -> Bool {
        return Auth.auth().currentUser?.isEmailVerified ?? false
    }

}

