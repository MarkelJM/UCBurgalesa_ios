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
        ZStack {
            DiagonalSolidShadedBackground()
            
            VStack {
                HStack {
                    BackButton(destination: .home)
                    Spacer()
                    Text("Puntos Totales: \(viewModel.totalPoints)")
                        .font(.whatTheFont(size: 20))
                        .foregroundColor(.black)
                }
                .padding()
                
                List(viewModel.ridePoints, id: \.rideId) { ridePoints in
                    VStack(alignment: .leading) {
                        Text("Salida: \(ridePoints.rideId)")
                            .font(.identifont(size: 16))
                            .foregroundColor(.black)
                        Text("Puntos: \(ridePoints.points)")
                            .font(.identifont(size: 14))
                            .foregroundColor(.black)
                        Text("Fecha: \(ridePoints.date, formatter: itemFormatter)")
                            .font(.identifont(size: 12))
                            .foregroundColor(.gray)
                    }
                    .padding()
                    .background(Color.white.opacity(0.7))
                    .cornerRadius(10)
                    .shadow(color: Color.gray.opacity(0.2), radius: 5, x: 0, y: 2)
                }
                .listStyle(PlainListStyle())
            }
            .padding()
            .background(Color.white.opacity(0.9))
            .cornerRadius(15)
            .shadow(radius: 10)
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
        PointsView().environmentObject(AppState())
    }
}



/*
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
*/
