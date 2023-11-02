//
//  CheckinViewModel.swift
//  UCBurgalesaiOS
//
//  Created by Markel Juaristi on 1/11/23.
//

import Foundation
import FirebaseAuth
import CoreLocation

class CheckinViewModel: ObservableObject {
    @Published var isCheckinSuccessful: Bool = false
    private var firestoreManager = FirestoreManager()
    
    func performCheckin(for ride: RideModel, type: CheckType) {
        guard let userId = Auth.auth().currentUser?.uid else { return }
        
        let checkin = CheckingModel(checkinId: UUID().uuidString, profileId: userId, rideId: ride.rideId, checkinTime: Date(), checkinType: type, pointsAwarded: 10) // Puedes ajustar los puntos otorgados según tus necesidades
        
        firestoreManager.saveCheckin(checkin: checkin) { (success, error) in
            if let error = error {
                print("Error performing checkin: \(error.localizedDescription)")
            } else {
                self.isCheckinSuccessful = true
            }
        }
    }
    
    func isUserWithinRadius(userLocation: CLLocation, targetLocation: Coordinate, radius: Double) -> Bool {
        let targetCLLocation = CLLocation(latitude: targetLocation.latitude, longitude: targetLocation.longitude)
        return userLocation.distance(from: targetCLLocation) <= radius
    }

    func canPerformCheckin(for ride: RideModel, type: CheckType, userLocation: CLLocation) -> Bool {
        let currentDate = Date()
        
        switch type {
        case .start:
            return isUserWithinRadius(userLocation: userLocation, targetLocation: ride.startCoordinates, radius: ride.startCheckinRadius) && currentDate <= ride.startTime
        case .rest:
            return isUserWithinRadius(userLocation: userLocation, targetLocation: ride.restStopCoordinates, radius: ride.restStopCheckinRadius) && currentDate >= ride.minRestStopCheckinTime
        }
    }
}

