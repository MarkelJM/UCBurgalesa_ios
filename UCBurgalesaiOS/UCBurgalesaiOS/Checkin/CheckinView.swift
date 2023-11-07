//
//  CheckinView.swift
//  UCBurgalesaiOS
//
//  Created by Markel Juaristi on 1/11/23.
//

import SwiftUI

struct CheckinView: View {
    @ObservedObject var viewModel: CheckinViewModel
    var ride: RideModel
    @EnvironmentObject var appState: AppState
    
    var body: some View {
        VStack {
            // Aquí puedes mostrar la información de la ruta y otros detalles relevantes
            
            Button("Checkin at Start") {
                viewModel.performCheckin(for: ride, type: .start)
            }
            
            Button("Checkin at Rest") {
                viewModel.performCheckin(for: ride, type: .rest)
            }
            
            if viewModel.isCheckinSuccessful {
                Text("Checkin successful!")
            }
        }
        .navigationBarTitle("Check-in", displayMode: .inline)
        .navigationBarItems(trailing: Button("Cerrar") {
            // Aquí manejas el cierre de la vista de check-in
            appState.currentView = .home 
        })
    }
}


struct CheckinView_Previews: PreviewProvider {
    static var previews: some View {
        let rideModel = RideModel(
            rideId: "testRideId",
            date: Date(),
            rideName: "Test Ride",
            organizer: "Test Organizer",
            score: 5,
            restStopName: "Test Rest Stop",
            profileImage: URL(string: "https://firebasestorage.googleapis.com/v0/b/ucburgalesa-e9b42.appspot.com/o/pruebaPerfilTodos2-3.png?alt=media&token=783b3ac9-aa13-49dc-8410-25a2e38e6af7&_gl=1*g3dslh*_ga*Njk5MTM4NzQzLjE2OTMzODY4NTg.*_ga_CW55HF8NVT*MTY5NjkzMjc2OS45LjEuMTY5NjkzMzAyMS4yNy4wLjA.")!,
            routeImage: URL(string: "https://firebasestorage.googleapis.com/v0/b/ucburgalesa-e9b42.appspot.com/o/pruebaPerfilTodos2-3.png?alt=media&token=783b3ac9-aa13-49dc-8410-25a2e38e6af7&_gl=1*g3dslh*_ga*Njk5MTM4NzQzLjE2OTMzODY4NTg.*_ga_CW55HF8NVT*MTY5NjkzMjc2OS45LjEuMTY5NjkzMzAyMS4yNy4wLjA.")!,
            category: .all,
            kilometers: 100.0,
            startTime: Date(),
            routePoints: ["Point1", "Point2"],
            startCoordinates: Coordinate(latitude: 42.0, longitude: -3.0),
            startCheckinRadius: 500.0,
            minRestStopCheckinTime: Date().addingTimeInterval(3600),
            restStopCoordinates: Coordinate(latitude: 42.1, longitude: -3.1),
            restStopCheckinRadius: 500.0
        )
        
        return CheckinView(viewModel: CheckinViewModel(), ride: rideModel)
            .previewLayout(.sizeThatFits)
    }
}

