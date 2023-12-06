//
//  LogoAnimationView.swift
//  UCBurgalesaiOS
//
//  Created by Markel Juaristi on 27/11/23.
//

import SwiftUI

struct LogoAnimationView: View {
    @State private var imagePosition = CGPoint(x: 0, y: 0)
    @State private var rotationAngle: Double = 0
    let screenSize: CGSize

    var body: some View {
        Image("EscudoUCB")
            .resizable()
            .aspectRatio(contentMode: .fit)
            .frame(width: 150, height: 150)
            .rotationEffect(Angle(degrees: rotationAngle))
            .position(imagePosition)
            .onAppear {
                // Primera animación: Mover a la derecha con rotación
                withAnimation(.linear(duration: 1.0)) {
                    imagePosition = CGPoint(x: screenSize.width + 75, y: screenSize.height / 2)
                    rotationAngle += 360 * 2 // Ajustar para el número deseado de rotaciones
                }
                // Segunda animación: Mover al centro y detener la rotación
                DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                    withAnimation(.easeInOut(duration: 1.0)) {
                        imagePosition = CGPoint(x: screenSize.width / 2, y: screenSize.height / 2)
                        rotationAngle = 0 // Detener la rotación
                    }
                }
            }
    }

    init(screenSize: CGSize) {
        self.screenSize = screenSize
        _imagePosition = State(initialValue: CGPoint(x: -75, y: screenSize.height / 2))
    }
    
    
}
