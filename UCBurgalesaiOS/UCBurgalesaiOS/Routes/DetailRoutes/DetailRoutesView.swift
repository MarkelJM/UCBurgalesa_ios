//
//  DetailRoutesView.swift
//  UCBurgalesaiOS
//
//  Created by Markel Juaristi on 30/10/23.
//

import SwiftUI
import MapKit

struct DetailRoutesView: View {
    @ObservedObject var viewModel: DetailRoutesViewModel
    @EnvironmentObject var appState: AppState


    var body: some View {
        ScrollView {
            VStack(alignment: .leading) {
                HStack {
                    BackButton(destination: .routesList)
                        .environmentObject(appState)
                        .padding(.bottom, 20)
                    Spacer()
                }
                VStack {
                    Text(viewModel.ride.rideName).font(.largeTitle)
                    Text("Organizer: \(viewModel.ride.organizer)")
                    Text("Date: \(DateFormatter.firestoreDateOnlyFormatter.string(from: viewModel.ride.date))")
                    Text("Score: \(viewModel.ride.score)")
                    Text("Rest Stop Name: \(viewModel.ride.restStopName)")
                    Text("Category: \(viewModel.ride.category.rawValue.capitalized)")
                }
                
                VStack {
                    Text("Kilometers: \(viewModel.ride.kilometers, specifier: "%.2f") km")
                    Text("Start Time: \(DateFormatter.firestoreDateTimeFormatter.string(from: viewModel.ride.startTime))")
                    Text("Route Points: \(viewModel.ride.routePoints.joined(separator: ", "))")
                    Text("Profile Image: \(viewModel.ride.profileImage)")
                    Text("Route Image: \(viewModel.ride.routeImage)")
                }
                
                VStack {
                    MapView(startCoordinate: viewModel.ride.startCoordinates, restStopCoordinate: viewModel.ride.restStopCoordinates)
                }
            }
            .padding()
        }
    }
}

struct MapView: View {
    var startCoordinate: Coordinate
    var restStopCoordinate: Coordinate
    
    var body: some View {
        Map(coordinateRegion: .constant(MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: startCoordinate.latitude, longitude: startCoordinate.longitude), span: MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05))), annotationItems: [startCoordinate, restStopCoordinate]) { coordinate in
            MapAnnotation(coordinate: CLLocationCoordinate2D(latitude: coordinate.latitude, longitude: coordinate.longitude)) {
                if coordinate == startCoordinate {
                    Image(systemName: "arrow.up.circle.fill") // Puedes cambiar esto por tu imagen de inicio
                        .foregroundColor(.blue)
                } else {
                    Image(systemName: "house.fill") // Puedes cambiar esto por tu imagen de café
                        .foregroundColor(.red)
                }
            }
        }
    }
}

struct DetailRoutesView_Previews: PreviewProvider {
    static var previews: some View {
        let ride = RideModel(rideId: "1", date: Date(), rideName: "Test Ride", organizer: "John Doe", score: 5, restStopName: "Test Stop", profileImage: URL(string: "https://example.com/image.jpg")!, routeImage: URL(string: "https://example.com/route.jpg")!, category: .all, kilometers: 100.0, startTime: Date(), routePoints: ["Point 1", "Point 2"], startCoordinates: Coordinate(latitude: 42.357264, longitude: -3.680006), startCheckinRadius: 500, minRestStopCheckinTime: Date(), restStopCoordinates: Coordinate(latitude: 42.211664, longitude: -3.460269), restStopCheckinRadius: 500)
        let viewModel = DetailRoutesViewModel(ride: ride)
        
        return DetailRoutesView(viewModel: viewModel)
            .environmentObject(AppState()) 
    }
}


