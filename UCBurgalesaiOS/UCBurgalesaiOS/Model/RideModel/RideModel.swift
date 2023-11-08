//
//  RideModel.swift
//  UCBurgalesaiOS
//
//  Created by Markel Juaristi on 21/9/23.
//

import Foundation

struct RideModel: Identifiable {
    var id: String { rideId } 
    var rideId: String
    var date: Date
    var rideName: String
    var organizer: String
    var score: Int
    var restStopName: String
    var profileImage: URL
    var routeImage: URL
    var category: RouteType
    var kilometers: Double
    var startTime: Date
    var routePoints: [String]
    var startCoordinates: Coordinate
    var startCheckinRadius: Double
    var minRestStopCheckinTime: Date
    var restStopCoordinates: Coordinate
    var restStopCheckinRadius: Double
}

enum RouteType: String, CaseIterable {
    case long
    //case joint
    case short
    case all
}

struct Coordinate: Identifiable {
    var id = UUID()
    var latitude: Double
    var longitude: Double
    
    static func ==(lhs: Coordinate, rhs: Coordinate) -> Bool {
        return lhs.latitude == rhs.latitude && lhs.longitude == rhs.longitude
    }
}
