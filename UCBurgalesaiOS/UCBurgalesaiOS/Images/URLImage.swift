//
//  URLImage.swift
//  UCBurgalesaiOS
//
//  Created by Markel Juaristi on 21/10/23.
//

import Foundation
import SwiftUI
import Combine

struct URLImage: View {
    @State private var image: UIImage? = nil
    @State private var isLoading: Bool = false
    @State private var error: Error? = nil
    @State private var cancellable: AnyCancellable?

    let url: URL

    var body: some View {
        Group {
            if let image = image {
                Image(uiImage: image)
                    .resizable()
            } else if isLoading {
                ProgressView() // Muestra un indicador de carga mientras la imagen se está descargando
            } else {
                Text("Error cargando imagen")
                    .foregroundColor(.red)
            }
        }
        .onAppear(perform: loadImage)
    }
    
    func loadImage() {
        isLoading = true
        cancellable = URLSession.shared.dataTaskPublisher(for: url)
            .map { UIImage(data: $0.data) }
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { completion in
                isLoading = false
                switch completion {
                case .finished:
                    break
                case .failure(let errorReceived):
                    self.error = errorReceived
                }
            }, receiveValue: { self.image = $0 })
    }
}
