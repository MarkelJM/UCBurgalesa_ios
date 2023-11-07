//
//  PointsViewModel.swift
//  UCBurgalesaiOS
//
//  Created by Markel Juaristi on 20/10/23.
//

import Foundation
import FirebaseAuth

class PointsViewModel: ObservableObject {
    @Published var totalPoints: Int = 0
    @Published var ridePoints: [PointsModel] = []
    private var firestoreManager = FirestoreManager()
    private var userId: String? {
        Auth.auth().currentUser?.uid
    }

    init() {
        fetchTotalPoints()
        fetchRidePoints()
    }

    func fetchTotalPoints() {
        guard let userId = userId else {
            print("No user ID available, skipping fetchTotalPoints")
            return
        }
        print("Fetching total points for user: \(userId)")
        firestoreManager.getTotalPoints(for: userId) { points in
            DispatchQueue.main.async {
                self.totalPoints = points
                print("Total points fetched: \(points)")
            }
        }
    }

    func fetchRidePoints() {
        print("Fetching ride points for user: \(userId)")
        guard let userId = userId else {
            print("No user ID available, skipping fetchRidePoints")
            return
        }
        firestoreManager.getRidePoints(for: userId) { rides in
            DispatchQueue.main.async {
                self.ridePoints = rides
                print("Ride points fetched: \(rides.count) entries")
            }
        }
    }

}



