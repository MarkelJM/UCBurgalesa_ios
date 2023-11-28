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
        ZStack {
            DiagonalSolidShadedBackground()
                .edgesIgnoringSafeArea(.all)

            ScrollView {
                VStack(spacing: 20) {
                    headerView
                    routeDetails
                    mapView
                }
                .padding()
                .background(Color.white.opacity(0.9))
                .cornerRadius(15)
                .shadow(radius: 10)
            }
        }
    }

    var headerView: some View {
        HStack {
            BackButton(destination: .routesList)
                .environmentObject(appState)
            Spacer()
            Text(viewModel.ride.rideName)
                .font(.whatTheFont(size: 24))
            Spacer()
        }
    }

    var routeDetails: some View {
        VStack(alignment: .leading, spacing: 10) {
            detailText("Organizer: \(viewModel.ride.organizer)")
            detailText("Date: \(DateFormatter.firestoreDateOnlyFormatter.string(from: viewModel.ride.date))")
            detailText("Score: \(viewModel.ride.score)")
            detailText("Rest Stop Name: \(viewModel.ride.restStopName)")
            detailText("Category: \(viewModel.ride.category.rawValue.capitalized)")
            detailText("Kilometers: \(String(format: "%.2f km", viewModel.ride.kilometers))")
            detailText("Start Time: \(DateFormatter.firestoreDateTimeFormatter.string(from: viewModel.ride.startTime))")
            detailText("Route Points: \(viewModel.ride.routePoints.joined(separator: ", "))")
        }
    }


    var mapView: some View {
        MapView(startCoordinate: viewModel.ride.startCoordinates, restStopCoordinate: viewModel.ride.restStopCoordinates)
            .frame(height: 300)
    }

    func detailText(_ text: String) -> some View {
        Text(text)
            .font(.identifont(size: 18))
            .foregroundColor(Color.black)
            .padding(5)
    }
}

struct MapView: View {
    var startCoordinate: Coordinate
    var restStopCoordinate: Coordinate

    var body: some View {
        Map(coordinateRegion: .constant(MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: startCoordinate.latitude, longitude: startCoordinate.longitude), span: MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05))), annotationItems: [startCoordinate, restStopCoordinate]) { coordinate in
            MapAnnotation(coordinate: CLLocationCoordinate2D(latitude: coordinate.latitude, longitude: coordinate.longitude)) {
                Image(systemName: coordinate == startCoordinate ? "arrow.up.circle.fill" : "house.fill")
                    .foregroundColor(coordinate == startCoordinate ? .blue : .red)
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
