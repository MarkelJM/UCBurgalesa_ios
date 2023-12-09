//
//  CheckinViewModel.swift
//  UCBurgalesaiOS
//
//  Created by Markel Juaristi on 1/11/23.
//
import Foundation
import FirebaseAuth
import CoreLocation
import FirebaseAnalytics

class CheckinViewModel: NSObject, ObservableObject, CLLocationManagerDelegate {
    @Published var isCheckinSuccessful: Bool = false
    @Published var showAlert: Bool = false
    @Published var alertMessage: String = ""
    @Published var selectedRouteType: RouteType? // Para almacenar la selección del usuario
    private var locationManager = CLLocationManager()
    private var firestoreManager = FirestoreManager()
    @Published var isCheckinAvailable: Bool = false
    
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
                    let checkinType = self.determineCheckinType(for: todayRide, userLocation: userLocation, selectedRouteType: self.selectedRouteType ?? .all)
                    if self.canPerformCheckin(for: todayRide, userLocation: userLocation, checkType: checkinType) {
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

    
    private func canPerformCheckin(for ride: RideModel, userLocation: CLLocation, checkType: CheckType) -> Bool {
        let currentDate = Date()
        let startLocation = CLLocation(latitude: ride.startCoordinates.latitude, longitude: ride.startCoordinates.longitude)
        let restLocation = CLLocation(latitude: ride.restStopCoordinates.latitude, longitude: ride.restStopCoordinates.longitude)
        
        let isWithinStartRadius = userLocation.distance(from: startLocation) <= ride.startCheckinRadius
        let isWithinRestRadius = userLocation.distance(from: restLocation) <= ride.restStopCheckinRadius
        
        let startTime = ride.startTime
        let restTime = ride.minRestStopCheckinTime
        
        switch checkType {
        case .start:
            return currentDate >= startTime && currentDate < restTime && isWithinStartRadius
        case .rest:
            return currentDate >= restTime && isWithinRestRadius
        }
    }

    
    func checkForTodaysRide() {
        let currentDate = Date()
        let dateString = DateFormatter.firestoreDateOnlyFormatter.string(from: currentDate)
        
        firestoreManager.fetchAllRides { [weak self] (rides, error) in
            guard let self = self else { return }
            
            if let error = error {
                DispatchQueue.main.async {
                    self.alertMessage = "Error fetching rides: \(error.localizedDescription)"
                    self.showAlert = true
                }
                return
            }
            
            if let rides = rides {
                let todaysRides = rides.filter { DateFormatter.firestoreDateOnlyFormatter.string(from: $0.date) == dateString }
                if let selectedRide = todaysRides.first(where: { $0.category == self.selectedRouteType || self.selectedRouteType == .all }) {
                    DispatchQueue.main.async {
                        self.isCheckinAvailable = true
                    }
                } else {
                    DispatchQueue.main.async {
                        self.alertMessage = "No hay salidas \(self.selectedRouteType?.rawValue ?? "") programadas para hoy."
                        self.showAlert = true
                    }
                }
            } else {
                DispatchQueue.main.async {
                    self.alertMessage = "No se pudo obtener la información de las salidas."
                    self.showAlert = true
                }
            }
        }
    }
    
    func initiateCheckin(type: CheckType) {
        guard let userLocation = locationManager.location else {
            alertMessage = "No se pudo obtener la ubicación actual."
            showAlert = true
            return
        }
        
        let currentDate = Date()
        let dateString = DateFormatter.firestoreDateOnlyFormatter.string(from: currentDate)
        
        firestoreManager.fetchAllRides { [weak self] (rides, error) in
            guard let self = self else { return }
            
            if let error = error {
                DispatchQueue.main.async {
                    self.alertMessage = "Error fetching rides: \(error.localizedDescription)"
                    self.showAlert = true
                }
                return
            }
            
            guard let rides = rides, let todayRide = rides.first(where: { DateFormatter.firestoreDateOnlyFormatter.string(from: $0.date) == dateString }) else {
                DispatchQueue.main.async {
                    self.alertMessage = "No hay salidas programadas para hoy."
                    self.showAlert = true
                }
                return
            }
            
            let canCheckin = self.canPerformCheckin(for: todayRide, userLocation: userLocation, checkType: type)
            
            if canCheckin {
                self.performCheckin(for: todayRide, userLocation: userLocation)
            } else {
                DispatchQueue.main.async {
                    self.alertMessage = "No estás en el lugar o tiempo correcto para hacer check-in de \(type == .start ? "salida" : "descanso")."
                    self.showAlert = true
                }
            }
        }
        // Registro del evento de check-in
        Analytics.logEvent("checkin", parameters: [
            "type": type.rawValue as NSObject,
            "timestamp": Date().timeIntervalSince1970 as NSObject
        ])
    }

}

