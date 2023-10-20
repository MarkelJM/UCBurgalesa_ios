//
//  HomeView.swift
//  UCBurgalesaiOS
//
//  Created by Markel Juaristi on 20/10/23.
//
import SwiftUI

struct HomeView: View {
    @StateObject var viewModel = HomeViewModel()
    
    var body: some View {
        NavigationView {
            VStack(spacing: 20) {
                // Primer fila de botones
                HStack(spacing: 20) {
                    ForEach(0..<2) { index in
                        navigationButton(index: index)
                    }
                }
                
                // Segunda fila de botones
                HStack(spacing: 20) {
                    ForEach(2..<4) { index in
                        navigationButton(index: index)
                    }
                }
                
                // Tercera fila de botones
                HStack(spacing: 20) {
                    ForEach(4..<6) { index in
                        navigationButton(index: index)
                    }
                }
                
                Spacer()
            }
            .padding()
            .navigationBarTitle("Home", displayMode: .inline)
        }
        .tabItem {
            Image(systemName: "house.fill")
            Text("Home")
        }
    }
    
    func navigationButton(index: Int) -> some View {
        NavigationLink(destination: ForgotPasswordView()) {
            Button(action: {}) {
                Image("yourImageName") // <-- Cambia "yourImageName" por el nombre de tu imagen
                    .resizable()
                    .scaledToFit()
                    .frame(width: 150, height: 150)
                    .cornerRadius(15) // Radio en los bordes
            }
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}

/*
 
 struct HomeView: View {
     @StateObject var viewModel = HomeViewModel()
     
     var body: some View {
         NavigationView {
             VStack {
                 // 6 botones cuadrados
                 LazyVGrid(columns: Array(repeating: .init(), count: 2), spacing: 20) {
                     ForEach(0..<6) { index in
                         NavigationLink(destination: destinationView(for: index)) {
                             Button(action: {}) {
                                 Image("yourImageName_\(index)") // <-- Cambia "yourImageName" por el nombre base de tus imágenes y añade el índice para diferenciarlas
                                     .resizable()
                                     .scaledToFit()
                                     .frame(width: 150, height: 150)
                             }
                         }
                     }
                 }
                 Spacer()
             }
             .padding()
             .navigationBarTitle("Home", displayMode: .inline)
         }
         .tabItem {
             Image(systemName: "house.fill")
             Text("Home")
         }
     }
     
     // Función para determinar a qué vista navegar
     func destinationView(for index: Int) -> some View {
         switch index {
         case 0:
             return AnyView(FirstView()) // Reemplaza "FirstView()" con tu primera vista
         case 1:
             return AnyView(SecondView()) // Reemplaza "SecondView()" con tu segunda vista
         // ... y así sucesivamente para cada vista
         default:
             return AnyView(Text("View not found"))
         }
     }
 }

 */
