//
//  CheckinViewModel.swift
//  UCBurgalesaiOS
//
//  Created by Markel Juaristi on 1/11/23.
//
import Foundation
import FirebaseAuth
import CoreLocation

class CheckinViewModel: NSObject, ObservableObject, CLLocationManagerDelegate {
    @Published var isCheckinSuccessful: Bool = false
    @Published var showAlert: Bool = false
    @Published var alertMessage: String = ""
    @Published var selectedRouteType: RouteType? // Para almacenar la selección del usuario
    private var locationManager = CLLocationManager()
    private var firestoreManager = FirestoreManager()
    
    override init() {
        super.init()
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
    }
    
    func requestUserLocation() {
        locationManager.startUpdatingLocation()
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let userLocation = locations.last else { return }
        locationManager.stopUpdatingLocation()
        initiateCheckin(userLocation: userLocation)
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        alertMessage = "Error obteniendo la ubicación: \(error.localizedDescription)"
        showAlert = true
    }
    
    private func performCheckin(for ride: RideModel, userLocation: CLLocation) {
        guard let userId = Auth.auth().currentUser?.uid else {
            alertMessage = "No se pudo identificar al usuario."
            showAlert = true
            return
        }
        
        guard let selectedRouteType = selectedRouteType else {
            alertMessage = "Por favor, selecciona el tipo de ruta antes de hacer check-in."
            showAlert = true
            return
        }
        
        let checkinType = determineCheckinType(for: ride, userLocation: userLocation, selectedRouteType: selectedRouteType)
        let checkin = CheckingModel(checkinId: UUID().uuidString, profileId: userId, rideId: ride.rideId, checkinTime: Date(), checkinType: checkinType, pointsAwarded: ride.score)
        
        firestoreManager.saveCheckin(checkin: checkin) { [weak self] (success, error) in
            guard let self = self else { return }
            if let error = error {
                self.alertMessage = "Error performing checkin: \(error.localizedDescription)"
                self.showAlert = true
            } else {
                self.isCheckinSuccessful = true
            }
        }
    }
    
    private func initiateCheckin(userLocation: CLLocation) {
        let currentDate = Date()
        let dateString = DateFormatter.firestoreDateOnlyFormatter.string(from: currentDate)
        
        firestoreManager.fetchAllRides { [weak self] (rides, error) in
            guard let self = self else { return }
            
            if let error = error {
                self.alertMessage = "Error fetching rides: \(error.localizedDescription)"
                self.showAlert = true
                return
            }
            
            if let rides = rides {
                if let todayRide = rides.first(where: { DateFormatter.firestoreDateOnlyFormatter.string(from: $0.date) == dateString }) {
                    if self.canPerformCheckin(for: todayRide, userLocation: userLocation) {
                        self.performCheckin(for: todayRide, userLocation: userLocation)
                    } else {
                        self.alertMessage = "No estás en el lugar o tiempo correcto para hacer check-in."
                        self.showAlert = true
                    }
                } else {
                    self.alertMessage = "No hay salidas oficiales programadas para hoy."
                    self.showAlert = true
                }
            } else {
                self.alertMessage = "No se pudo obtener la información de las salidas."
                self.showAlert = true
            }
        }
    }
    
    private func determineCheckinType(for ride: RideModel, userLocation: CLLocation, selectedRouteType: RouteType) -> CheckType {
        let currentDate = Date()
        let startTime = ride.startTime
        let restTime = ride.minRestStopCheckinTime
        
        
        if currentDate >= startTime && currentDate < restTime {
            return .start
        } else {
            return .rest
        }
    }

    
    private func canPerformCheckin(for ride: RideModel, userLocation: CLLocation) -> Bool {
        let currentDate = Date()
        let startLocation = CLLocation(latitude: ride.startCoordinates.latitude, longitude: ride.startCoordinates.longitude)
        let restLocation = CLLocation(latitude: ride.restStopCoordinates.latitude, longitude: ride.restStopCoordinates.longitude)
        
        let isWithinStartRadius = userLocation.distance(from: startLocation) <= ride.startCheckinRadius
        let isWithinRestRadius = userLocation.distance(from: restLocation) <= ride.restStopCheckinRadius
        
        let startTime = ride.startTime
        let restTime = ride.minRestStopCheckinTime
        
        let isStartTime = currentDate >= startTime && isWithinStartRadius
        let isRestTime = currentDate >= restTime && isWithinRestRadius
        
        return isStartTime || isRestTime
    }
}


/*
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
    
    
    
    func verifyCheckinsAndAwardPoints(for ride: RideModel, userId: String, completion: @escaping (Bool) -> Void) {
        firestoreManager.getCheckins(for: userId) { (checkins, error) in
            if let error = error {
                print("Error fetching checkins: \(error.localizedDescription)")
                completion(false)
                return
            }
            
            guard let checkins = checkins else {
                completion(false)
                return
            }
            
            let hasStartCheckin = checkins.contains { $0.rideId == ride.rideId && $0.checkinType == .start }
            let hasRestCheckin = checkins.contains { $0.rideId == ride.rideId && $0.checkinType == .rest }
            
            if hasStartCheckin && hasRestCheckin {
                // Utiliza el score de RideModel para determinar los puntos a otorgar
                let pointsToAward = ride.score
                
                // Actualiza Firebase con los nuevos puntos
                self.firestoreManager.updatePoints(for: userId, with: pointsToAward, for: ride.rideId) { success in
                    completion(success)
                }
            } else {
                completion(false)
            }
        }
    }


}
*/
