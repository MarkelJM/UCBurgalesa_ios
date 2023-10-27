//
//  RoutesViewModel.swift
//  UCBurgalesaiOS
//
//  Created by Markel Juaristi on 20/10/23.
//

import Foundation
import SwiftUI

class RoutesListViewModel: ObservableObject {
    @Published var rides: [RideModel] = []
    @Published var isLoading: Bool = false
    @Published var error: Error?
    @Published var shouldNavigateBackToHome: Bool = false

    
    private var firestoreManager = FirestoreManager()
    
    @EnvironmentObject var appState: AppState
    
    func fetchRides() {
        isLoading = true
        print("Fetching rides...")
        firestoreManager.fetchAllRides { [weak self] (rides, error) in
            DispatchQueue.main.async {
                self?.isLoading = false
                print("accediendo a ride")
                if let rides = rides {
                    print("Rides fetched: \(rides.count)")
                    self?.rides = rides
                } else if let error = error {
                    print("Error fetching rides: \(error.localizedDescription)")
                    self?.error = error
                }
            }
        }
    }

    

    func navigateBackToHome() {
        shouldNavigateBackToHome = true
    }


}

/*
//prueba por que no muestra nada la preview
extension RoutesListViewModel {
    static var mock: RoutesListViewModel {
        let viewModel = RoutesListViewModel(appState: AppState())
        viewModel.rides = [
            RideModel(rideId: "1", date: Date(), rideName: "Test Ride", organizer: "John Doe", score: 5, restStopName: "Test Stop", profileImage: URL(string: "https://example.com/image1.jpg")!, routeImage: URL(string: "https://example.com/route1.jpg")!, category: .all, kilometers: 50.0, startTime: Date(), routePoints: ["Point 1", "Point 2"], startCoordinates: Coordinate(latitude: 0, longitude: 0), startCheckinRadius: 500, minRestStopCheckinTime: Date(), restStopCoordinates: Coordinate(latitude: 1, longitude: 1), restStopCheckinRadius: 500)
        ]
        return viewModel
    }
}
*/
