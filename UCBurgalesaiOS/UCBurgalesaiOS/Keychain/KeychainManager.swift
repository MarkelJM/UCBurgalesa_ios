//
//  KeychainManager.swift
//  UCBurgalesaiOS
//
//  Created by Markel Juaristi on 6/11/23.
//

import Foundation
import KeychainSwift

class KeychainManager {
    private let keychain = KeychainSwift()

    private let tokenKey = "authToken"

    func saveToken(_ token: String) {
        keychain.set(token, forKey: tokenKey)
    }

    func getToken() -> String? {
        return keychain.get(tokenKey)
    }

    func deleteToken() {
        keychain.delete(tokenKey)
    }
}
