//
//  CheckingModel.swift
//  UCBurgalesaiOS
//
//  Created by Markel Juaristi on 21/9/23.
//

import Foundation

struct CheckingModel {
    var checkinId: String
    var profileId: String
    var rideId: String
    var checkinTime: Date
    var checkinType: CheckType
    var pointsAwarded: Int
}

enum CheckType {
    case start
    case rest
}
