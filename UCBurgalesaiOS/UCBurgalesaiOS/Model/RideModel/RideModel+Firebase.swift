//
//  RideModel+Firebase.swift
//  UCBurgalesaiOS
//
//  Created by Markel Juaristi on 10/10/23.
//

import Foundation
import FirebaseFirestore

extension RideModel {
    init?(from firestoreData: [String: Any]) {
        guard let rideId = firestoreData["rideId"] as? String,
              let dateString = firestoreData["date"] as? String,
              let date = DateFormatter.firestoreDateFormatter.date(from: dateString),
              let rideName = firestoreData["rideName"] as? String,
              let organizer = firestoreData["organizer"] as? String,
              let score = firestoreData["score"] as? Int,
              let restStopName = firestoreData["restStopName"] as? String,
              let profileImageString = firestoreData["profileImage"] as? String,
              let profileImage = URL(string: profileImageString),
              let routeImageString = firestoreData["routeImage"] as? String,
              let routeImage = URL(string: routeImageString),
              let categoryString = firestoreData["category"] as? String,
              let category = RouteType(rawValue: categoryString),
              let kilometers = firestoreData["kilometers"] as? Double,
              let startTimeString = firestoreData["startTime"] as? String,
              let startTime = DateFormatter.firestoreDateFormatter.date(from: startTimeString),
              let routePoints = firestoreData["routePoints"] as? [String],
              let startLat = firestoreData["startLat"] as? Double,
              let startLong = firestoreData["startLong"] as? Double,
              let startCheckinRadius = firestoreData["startCheckinRadius"] as? Double,
              let minRestStopCheckinTimeString = firestoreData["minRestStopCheckinTime"] as? String,
              let minRestStopCheckinTime = DateFormatter.firestoreDateFormatter.date(from: minRestStopCheckinTimeString),
              let restStopLat = firestoreData["restStopLat"] as? Double,
              let restStopLong = firestoreData["restStopLong"] as? Double,
              let restStopCheckinRadius = firestoreData["restStopCheckinRadius"] as? Double else {
            return nil
        }
        
        self.rideId = rideId
        self.date = date
        self.rideName = rideName
        self.organizer = organizer
        self.score = score
        self.restStopName = restStopName
        self.profileImage = profileImage
        self.routeImage = routeImage
        self.category = category
        self.kilometers = kilometers
        self.startTime = startTime
        self.routePoints = routePoints
        self.startCoordinates = Coordinate(latitude: startLat, longitude: startLong)
        self.startCheckinRadius = startCheckinRadius
        self.minRestStopCheckinTime = minRestStopCheckinTime
        self.restStopCoordinates = Coordinate(latitude: restStopLat, longitude: restStopLong)
        self.restStopCheckinRadius = restStopCheckinRadius
    }
    
    func toFirestoreData() -> [String: Any] {
        return [
            "rideId": rideId,
            "date": DateFormatter.firestoreDateFormatter.string(from: date),
            "rideName": rideName,
            "organizer": organizer,
            "score": score,
            "restStopName": restStopName,
            "profileImage": profileImage.absoluteString,
            "routeImage": routeImage.absoluteString,
            "category": category.rawValue,
            "kilometers": kilometers,
            "startTime": DateFormatter.firestoreDateFormatter.string(from: startTime),
            "routePoints": routePoints,
            "startLat": startCoordinates.latitude,
            "startLong": startCoordinates.longitude,
            "startCheckinRadius": startCheckinRadius,
            "minRestStopCheckinTime": DateFormatter.firestoreDateFormatter.string(from: minRestStopCheckinTime),
            "restStopLat": restStopCoordinates.latitude,
            "restStopLong": restStopCoordinates.longitude,
            "restStopCheckinRadius": restStopCheckinRadius
        ]
    }
}

extension DateFormatter {
    static let firestoreDateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd/MM/yyyy HH:mm:ss"
        return formatter
    }()
}
