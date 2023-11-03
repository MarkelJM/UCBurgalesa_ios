//
//  PointsModel+Firebase.swift
//  UCBurgalesaiOS
//
//  Created by Markel Juaristi on 3/11/23.
//

import Foundation
import FirebaseFirestore 

extension PointsModel {
    // Inicializador que crea un PointsModel a partir de un diccionario de Firestore
    init?(from dictionary: [String: Any]) {
        guard let rideId = dictionary["rideId"] as? String,
              let points = dictionary["points"] as? Int,
              let timestamp = dictionary["date"] as? Timestamp else { return nil }
        
        self.rideId = rideId
        self.points = points
        self.date = timestamp.dateValue()
    }

    // Método para convertir un PointsModel en un diccionario para Firestore
    var documentData: [String: Any] {
        return [
            "rideId": rideId,
            "points": points,
            "date": Timestamp(date: date)
        ]
    }
}

