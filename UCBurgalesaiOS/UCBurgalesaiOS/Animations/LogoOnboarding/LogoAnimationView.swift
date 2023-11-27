//
//  LogoAnimationView.swift
//  UCBurgalesaiOS
//
//  Created by Markel Juaristi on 27/11/23.
//

import SwiftUI

struct LogoAnimationView: View {
    @State private var imagePosition = CGPoint(x: 0, y: 0)
    let animationDuration: Double
    let screenSize: CGSize

    var body: some View {
        Image("EscudoUCB")
            .resizable()
            .aspectRatio(contentMode: .fit)
            .frame(width: 150, height: 150)
            .position(imagePosition)
            .onAppear {
                withAnimation(.easeInOut(duration: animationDuration)) {
                    imagePosition = CGPoint(x: screenSize.width / 2, y: screenSize.height / 2)
                }
            }
    }

    init(screenSize: CGSize, animationDuration: Double = 2.0) {
        self.screenSize = screenSize
        self.animationDuration = animationDuration
        _imagePosition = State(initialValue: CGPoint(x: -150, y: screenSize.height / 2))
    }
}
