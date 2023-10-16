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
              let bikeBrand = firestoreData["bikeBrand"] as? String,
              let addressData = firestoreData["address"] as? [String: Any],
              let postalCode = addressData["postalCode"] as? String,
              let city = addressData["city"] as? String,
              let street = addressData["street"] as? String,
              let phone = firestoreData["phone"] as? String,
              let email = firestoreData["email"] as? String,
              let birthDateString = firestoreData["birthDate"] as? String,
              let birthDate = DateFormatter.firestoreDateFormatter.date(from: birthDateString),
              let federated = firestoreData["federated"] as? Bool,
              let volunteer = firestoreData["volunteer"] as? Bool,
              let rolesInClub = firestoreData["rolesInClub"] as? [String],
              let profilePhotoString = firestoreData["profilePhoto"] as? String,
              let profilePhoto = URL(string: profilePhotoString),
              let photosStrings = firestoreData["photos"] as? [String],
              let routeTypeString = firestoreData["routeType"] as? String,
              let routeType = ProfileRouteType(rawValue: routeTypeString),
              let facebookName = firestoreData["facebookName"] as? String,
              let stravaAccount = firestoreData["stravaAccount"] as? String else {
            return nil
        }
        
        let photos = photosStrings.compactMap { URL(string: $0) }
        
        self.id = id
        self.clubId = clubId
        self.firstName = firstName
        self.lastName1 = lastName1
        self.lastName2 = lastName2
        self.bikeBrand = bikeBrand
        self.address = Address(postalCode: postalCode, city: city, street: street)
        self.phone = phone
        self.email = email
        self.birthDate = birthDate
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
        return [
            "id": id,
            "clubId": clubId,
            "firstName": firstName,
            "lastName1": lastName1,
            "lastName2": lastName2,
            "bikeBrand": bikeBrand,
            "address": [
                "postalCode": address.postalCode,
                "city": address.city,
                "street": address.street
            ],
            "phone": phone,
            "email": email,
            "birthDate": DateFormatter.firestoreDateFormatter.string(from: birthDate),
            "federated": federated,
            "volunteer": volunteer,
            "rolesInClub": rolesInClub,
            "profilePhoto": profilePhoto.absoluteString,
            "photos": photos.map { $0.absoluteString },
            "routeType": routeType.rawValue,
            "facebookName": facebookName,
            "stravaAccount": stravaAccount
        ]
    }
}

