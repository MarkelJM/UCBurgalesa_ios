//
//  LogoAnimationView.swift
//  UCBurgalesaiOS
//
//  Created by Markel Juaristi on 27/11/23.
//

import SwiftUI

struct LogoAnimationView: View {
    @State private var imagePosition = CGPoint(x: 0, y: 0)
    let screenSize: CGSize

    var body: some View {
        Image("EscudoUCB")
            .resizable()
            .aspectRatio(contentMode: .fit)
            .frame(width: 150, height: 150)
            .position(imagePosition)
            .onAppear {
                // Primera animación: Mover a la derecha
                withAnimation(.easeInOut(duration: 1.0)) {
                    imagePosition = CGPoint(x: screenSize.width + 75, y: screenSize.height / 2)
                }
                // Encadenar la siguiente animación después de un retardo
                DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                    // Segunda animación: Mover al centro con efecto de rebote
                    withAnimation(.timingCurve(0.68, -0.6, 0.32, 1.6, duration: 1.0)) {
                        imagePosition = CGPoint(x: screenSize.width / 2, y: screenSize.height / 2)
                    }
                }
            }
    }

    init(screenSize: CGSize) {
        self.screenSize = screenSize
        _imagePosition = State(initialValue: CGPoint(x: -75, y: screenSize.height / 2))
    }
}
