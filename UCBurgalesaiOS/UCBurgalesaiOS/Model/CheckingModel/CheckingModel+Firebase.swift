//
//  CheckingModel+Firebase.swift
//  UCBurgalesaiOS
//
//  Created by Markel Juaristi on 1/11/23.
//

import Foundation

extension CheckingModel {
    init?(documentData: [String: Any]) {
        guard let checkinId = documentData["checkinId"] as? String,
              let profileId = documentData["profileId"] as? String,
              let rideId = documentData["rideId"] as? String,
              let checkinTime = documentData["checkinTime"] as? Date,
              let checkinTypeString = documentData["checkinType"] as? String,
              let checkinType = CheckType(rawValue: checkinTypeString),
              let pointsAwarded = documentData["pointsAwarded"] as? Int else {
            return nil
        }
        
        self.checkinId = checkinId
        self.profileId = profileId
        self.rideId = rideId
        self.checkinTime = checkinTime
        self.checkinType = checkinType
        self.pointsAwarded = pointsAwarded
    }
    
    var documentData: [String: Any] {
        return [
            "checkinId": checkinId,
            "profileId": profileId,
            "rideId": rideId,
            "checkinTime": checkinTime,
            "checkinType": checkinType.rawValue,
            "pointsAwarded": pointsAwarded
        ]
    }
}
