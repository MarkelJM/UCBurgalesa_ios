//
//  RideModel+Firebase.swift
//  UCBurgalesaiOS
//
//  Created by Markel Juaristi on 10/10/23.
//

import Foundation
import FirebaseFirestore

extension DateFormatter {
    static let firestoreDateOnlyFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.timeZone = TimeZone(abbreviation: "CET") // Central European Time
        formatter.dateFormat = "MM/dd/yyyy"
        return formatter
    }()
    
    static let firestoreDateTimeFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.timeZone = TimeZone(abbreviation: "CET") // Central European Time
        formatter.dateFormat = "MM/dd/yyyy HH:mm:ss"
        return formatter
    }()
}



extension RideModel {
    init?(from firestoreData: [String: Any]) {
        guard let rideId = firestoreData["rideId"] as? String else {
            print("Error: Missing rideId")
            return nil
        }
        guard let dateString = firestoreData["date"] as? String else {
            print("Error: Missing dateString")
            return nil
        }
        guard let date = DateFormatter.firestoreDateOnlyFormatter.date(from: dateString) else {
            print("Error: Invalid date format for dateString: \(dateString)")
            return nil
        }

        guard let rideName = firestoreData["rideName"] as? String else {
            print("Error: Missing rideName")
            return nil
        }
        guard let organizer = firestoreData["organizer"] as? String else {
            print("Error: Missing organizer")
            return nil
        }
        guard let score = firestoreData["score"] as? Int else {
            print("Error: Missing or invalid score")
            return nil
        }
        guard let restStopName = firestoreData["restStopName"] as? String else {
            print("Error: Missing restStopName")
            return nil
        }
        guard let profileImageString = firestoreData["profileImage"] as? String,
              let profileImage = URL(string: profileImageString) else {
            print("Error: Invalid profileImage or profileImageString")
            return nil
        }
        guard let routeImageString = firestoreData["routeImage"] as? String,
              let routeImage = URL(string: routeImageString) else {
            print("Error: Invalid routeImage or routeImageString")
            return nil
        }
        guard let categoryString = firestoreData["category"] as? String,
              let category = RouteType(rawValue: categoryString) else {
            print("Error: Invalid category or categoryString")
            return nil
        }
        guard let kilometers = firestoreData["kilometers"] as? Double else {
            print("Error: Missing or invalid kilometers")
            return nil
        }
        guard let startTimeString = firestoreData["startTime"] as? String,
              let startTime = DateFormatter.firestoreDateTimeFormatter.date(from: startTimeString) else {
            print("Error: Invalid startTime or startTimeString")
            return nil
        }
        guard let routePoints = firestoreData["routePoints"] as? [String] else {
            print("Error: Missing or invalid routePoints")
            return nil
        }
        guard let startLat = firestoreData["startLat"] as? Double,
              let startLong = firestoreData["startLong"] as? Double else {
            print("Error: Missing or invalid startLat or startLong")
            return nil
        }
        guard let startCheckinRadius = firestoreData["startCheckinRadius"] as? Double else {
            print("Error: Missing or invalid startCheckinRadius")
            return nil
        }
        guard let minRestStopCheckinTimeString = firestoreData["minRestStopCheckinTime"] as? String,
              let minRestStopCheckinTime = DateFormatter.firestoreDateTimeFormatter.date(from: minRestStopCheckinTimeString) else {
            print("Error: Invalid minRestStopCheckinTime or minRestStopCheckinTimeString")
            return nil
        }
        guard let restStopLat = firestoreData["restStopLat"] as? Double,
              let restStopLong = firestoreData["restStopLong"] as? Double else {
            print("Error: Missing or invalid restStopLat or restStopLong")
            return nil
        }
        guard let restStopCheckinRadius = firestoreData["restStopCheckinRadius"] as? Double else {
            print("Error: Missing or invalid restStopCheckinRadius")
            return nil
        }
        
        // Asigna las propiedades
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
            "date": DateFormatter.firestoreDateOnlyFormatter.string(from: date),
            "rideName": rideName,
            "organizer": organizer,
            "score": score,
            "restStopName": restStopName,
            "profileImage": profileImage.absoluteString,
            "routeImage": routeImage.absoluteString,
            "category": category.rawValue,
            "kilometers": kilometers,
            "startTime": DateFormatter.firestoreDateTimeFormatter.string(from: startTime),
            "routePoints": routePoints,
            "startLat": startCoordinates.latitude,
            "startLong": startCoordinates.longitude,
            "startCheckinRadius": startCheckinRadius,
            "minRestStopCheckinTime": DateFormatter.firestoreDateTimeFormatter.string(from: minRestStopCheckinTime),
            "restStopLat": restStopCoordinates.latitude,
            "restStopLong": restStopCoordinates.longitude,
            "restStopCheckinRadius": restStopCheckinRadius
        ]
    }
}

/*
 
 
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

 */
