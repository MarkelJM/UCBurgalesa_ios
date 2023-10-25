//
//  ProfileModel+Firebase.swift
//  UCBurgalesaiOS
//
//  Created by Markel Juaristi on 16/10/23.
//

import Foundation
import FirebaseFirestore

extension ProfileModel {
    init?(from firestoreData: [String: Any]) {
        guard let id = firestoreData["id"] as? String,
              let clubId = firestoreData["clubId"] as? String,
              let firstName = firestoreData["firstName"] as? String,
              let lastName1 = firestoreData["lastName1"] as? String,
              let lastName2 = firestoreData["lastName2"] as? String,
              let addressData = firestoreData["address"] as? [String: Any],
              let postalCode = addressData["postalCode"] as? String,
              let city = addressData["city"] as? String,
              let street = addressData["street"] as? String,
              let phone = firestoreData["phone"] as? String,
              let email = firestoreData["email"] as? String,
              let birthDateTimestamp = firestoreData["birthDate"] as? Timestamp,
              let federated = firestoreData["federated"] as? Bool,
              let volunteer = firestoreData["volunteer"] as? Bool,
              let routeTypeString = firestoreData["routeType"] as? String,
              let routeType = ProfileRouteType(rawValue: routeTypeString) else {
            return nil
        }
        
        let bikeBrand = firestoreData["bikeBrand"] as? String
        let rolesInClub = firestoreData["rolesInClub"] as? [String]
        let profilePhotoString = firestoreData["profilePhoto"] as? String
        let profilePhoto = profilePhotoString != nil ? URL(string: profilePhotoString!) : nil
        let photosStrings = firestoreData["photos"] as? [String]
        let photos = photosStrings?.compactMap { URL(string: $0) }
        let facebookName = firestoreData["facebookName"] as? String
        let stravaAccount = firestoreData["stravaAccount"] as? String
        
        self.id = id
        self.clubId = clubId
        self.firstName = firstName
        self.lastName1 = lastName1
        self.lastName2 = lastName2
        self.bikeBrand = bikeBrand
        self.address = Address(postalCode: postalCode, city: city, street: street)
        self.phone = phone
        self.email = email
        self.birthDate = birthDateTimestamp.dateValue()
        self.federated = federated
        self.volunteer = volunteer
        self.rolesInClub = rolesInClub
        self.profilePhoto = profilePhoto
        self.photos = photos
        self.routeType = routeType
        self.facebookName = facebookName
        self.stravaAccount = stravaAccount
    }
    
    func toFirestoreData() -> [String: Any] {
        var data: [String: Any] = [
            "id": id,
            "clubId": clubId,
            "firstName": firstName,
            "lastName1": lastName1,
            "lastName2": lastName2,
            "address": [
                "postalCode": address.postalCode,
                "city": address.city,
                "street": address.street
            ],
            "phone": phone,
            "email": email,
            "birthDate": Timestamp(date: birthDate),
            "federated": federated,
            "volunteer": volunteer,
            "routeType": routeType.rawValue
        ]
        
        if let bikeBrand = bikeBrand { data["bikeBrand"] = bikeBrand }
        if let rolesInClub = rolesInClub { data["rolesInClub"] = rolesInClub }
        if let profilePhoto = profilePhoto { data["profilePhoto"] = profilePhoto.absoluteString }
        if let photos = photos { data["photos"] = photos.map { $0.absoluteString } }
        if let facebookName = facebookName { data["facebookName"] = facebookName }
        if let stravaAccount = stravaAccount { data["stravaAccount"] = stravaAccount }
        
        return data
    }
}
