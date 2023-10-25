//
//  ProfileModel.swift
//  UCBurgalesaiOS
//
//  Created by Markel Juaristi on 21/9/23.
//

import Foundation

struct ProfileModel {
    var id: String
    var clubId: String
    var firstName: String
    var lastName1: String
    var lastName2: String
    var bikeBrand: String?
    var address: Address
    var phone: String
    var email: String
    var birthDate: Date
    var federated: Bool
    var volunteer: Bool
    var rolesInClub: [String]?
    var profilePhoto: URL?
    var photos: [URL]?
    var routeType: ProfileRouteType
    var facebookName: String?
    var stravaAccount: String?
}


struct Address {
    var postalCode: String
    var city: String
    var street: String
}

enum ProfileRouteType: String {
    case short
    case long
}
