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
    @State private var cancellable: AnyCancellable? = nil
    
    let url: URL
    
    var body: some View {
        Group {
            if let image = image {
                Image(uiImage: image)
                    .resizable()
            } else {
                ProgressView() // Muestra un indicador de carga mientras la imagen se está descargando
            }
        }
        .onAppear(perform: loadImage)
    }
    
    func loadImage() {
        cancellable = URLSession.shared.dataTaskPublisher(for: url)
            .map { UIImage(data: $0.data) }
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { _ in }, receiveValue: { self.image = $0 })
    }
}
