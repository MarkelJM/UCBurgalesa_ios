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

