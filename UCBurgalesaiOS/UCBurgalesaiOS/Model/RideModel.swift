//
//  RideModel.swift
//  UCBurgalesaiOS
//
//  Created by Markel Juaristi on 21/9/23.
//

import Foundation

struct RideModel {
    var rideId: String
    var date: Date
    var rideName: String
    var organizer: String // Could be a reference to a Profile id.
    var score: Int
    var restStopName: String
    var profileImage: URL // Altimetry or route profile image.
    var routeImage: URL
    var category: String // Could be an enum: .long, .short, .joint
    var kilometers: Double
    var startTime: Date
    var routePoints: [String] // Might be more detailed depending on the info of each point.
    var startCoordinates: Coordinate
    var startCheckinRadius: Double
    var minRestStopCheckinTime: Date
    var restStopCoordinates: Coordinate
    var restStopCheckinRadius: Double
}

struct Coordinate {
    var latitude: Double
    var longitude: Double
}
