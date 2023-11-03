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
    private var userId: String {
        Auth.auth().currentUser?.uid ?? ""
    }

    init() {
        fetchTotalPoints()
        fetchRidePoints()
    }

    func fetchTotalPoints() {
        firestoreManager.getTotalPoints(for: userId) { points in
            DispatchQueue.main.async {
                self.totalPoints = points
            }
        }
    }

    func fetchRidePoints() {
        firestoreManager.getRidePoints(for: userId) { rides in
            DispatchQueue.main.async {
                self.ridePoints = rides
            }
        }
    }
}



// Necesitarás implementar las extensiones para convertir PointsModel a y desde un formato de Firestore
