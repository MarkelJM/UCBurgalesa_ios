//
//  backgrounds.swift
//  UCBurgalesaiOS
//
//  Created by Markel Juaristi on 18/10/23.
//

import Foundation
import SwiftUI



struct DiagonalShadedBackground: View {
    var body: some View {
        LinearGradient(gradient: Gradient(colors: [Color.brightOrange, Color.deepOrange]), startPoint: .topLeading, endPoint: .bottomTrailing)
            .overlay(
                RoundedRectangle(cornerRadius: 0)
                    .stroke(Color.violet.opacity(0.2), lineWidth: 5)
                    .blur(radius: 5)
            )
            .edgesIgnoringSafeArea(.all)
    }
}

struct DiagonalSolidShadedBackground: View {
    var body: some View {
        ZStack {
            Color.deepOrange.edgesIgnoringSafeArea(.all)
            
            LinearGradient(gradient: Gradient(colors: [Color.brightOrange, Color.brightOrange]),
                           startPoint: .topLeading,
                           endPoint: .bottomTrailing)
                .mask(
                    GeometryReader { geometry in
                        Path { path in
                            path.move(to: .zero)
                            path.addLine(to: CGPoint(x: 0, y: geometry.size.height))
                            path.addLine(to: CGPoint(x: geometry.size.width, y: 0))
                            path.closeSubpath()
                        }
                    }
                )
                .edgesIgnoringSafeArea(.all)
        }
    }
}


struct DiagonalGradient1: View {
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                Path { path in
                    path.move(to: .zero)
                    path.addLine(to: CGPoint(x: geometry.size.width, y: 0))
                    path.addLine(to: CGPoint(x: geometry.size.width, y: geometry.size.height))
                    path.closeSubpath()
                }
                .fill(LinearGradient(gradient: Gradient(colors: [Color.brightOrange, Color.violet]), startPoint: .topLeading, endPoint: .bottomTrailing))
                
                Path { path in
                    path.move(to: .zero)
                    path.addLine(to: CGPoint(x: 0, y: geometry.size.height))
                    path.addLine(to: CGPoint(x: geometry.size.width, y: geometry.size.height))
                    path.closeSubpath()
                }
                .fill(LinearGradient(gradient: Gradient(colors: [Color.deepOrange, Color.brightOrange]), startPoint: .bottomLeading, endPoint: .topTrailing))
            }
            .edgesIgnoringSafeArea(.all)
        }
    }
}
