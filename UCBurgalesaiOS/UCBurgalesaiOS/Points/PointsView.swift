//
//  PointsView.swift
//  UCBurgalesaiOS
//
//  Created by Markel Juaristi on 20/10/23.
//

import SwiftUI

struct PointsView: View {
    @StateObject var viewModel = PointsViewModel()
    @EnvironmentObject var appState: AppState

    var body: some View {
        VStack {
            
            HStack {
                BackButton(destination: .home) 
                Spacer()
                Text("Puntos Totales: \(viewModel.totalPoints)")
                    .font(.title)
            }
            Text("Puntos Totales: \(viewModel.totalPoints)")
                .font(.title)
            
            List(viewModel.ridePoints, id: \.rideId) { ridePoints in
                VStack(alignment: .leading) {
                    Text("Salida: \(ridePoints.rideId)")
                    Text("Puntos: \(ridePoints.points)")
                    Text("Fecha: \(ridePoints.date, formatter: itemFormatter)")
                }
            }
        }
        .navigationTitle("Mis Puntos")
        
        .onAppear {
            print("PointsView appeared")
            viewModel.fetchTotalPoints()
            viewModel.fetchRidePoints()
        }

         
    }
}

private let itemFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateStyle = .long
    formatter.timeStyle = .none
    return formatter
}()

struct PointsView_Previews: PreviewProvider {
    static var previews: some View {
        PointsView()
    }
}
