//
//  backgrounds.swift
//  UCBurgalesaiOS
//
//  Created by Markel Juaristi on 18/10/23.
//

import Foundation
import SwiftUI



struct Background1: View {
    var body: some View {
        ZStack {
            LinearGradient(gradient: Gradient(colors: [Color.brightOrange, Color.deepOrange, Color.Violet]), startPoint: .topLeading, endPoint: .bottomTrailing)
                .edgesIgnoringSafeArea(.all)
        }
    }
}

struct Background2: View {
    var body: some View {
        ZStack {
            LinearGradient(gradient: Gradient(colors: [Color.deepOrange, Color.brightOrange]), startPoint: .leading, endPoint: .trailing)
                .edgesIgnoringSafeArea(.all)
            LinearGradient(gradient: Gradient(colors: [Color.clear, Color.Violet.opacity(0.2)]), startPoint: .bottom, endPoint: .top)
                .edgesIgnoringSafeArea(.all)
        }
    }
}

struct Background3: View {
    var body: some View {
        ZStack {
            LinearGradient(gradient: Gradient(colors: [Color.Violet, Color.deepOrange]), startPoint: .topLeading, endPoint: .bottomTrailing)
                .edgesIgnoringSafeArea(.all)
        }
    }
}

struct Background4: View {
    var body: some View {
        ZStack {
            LinearGradient(gradient: Gradient(colors: [Color.deepOrange, Color.Violet, Color.brightOrange]), startPoint: .top, endPoint: .bottom)
                .edgesIgnoringSafeArea(.all)
        }
    }
}

struct Background5: View {
    var body: some View {
        ZStack {
            LinearGradient(gradient: Gradient(colors: [Color.brightOrange, Color.Violet]), startPoint: .leading, endPoint: .trailing)
                .edgesIgnoringSafeArea(.all)
        }
    }
}

struct Variant1: View {
    var body: some View {
        ZStack {
            LinearGradient(gradient: Gradient(colors: [Color.deepOrange, Color.brightOrange]), startPoint: .top, endPoint: .bottom)
                .edgesIgnoringSafeArea(.all)
            LinearGradient(gradient: Gradient(colors: [Color.clear, Color.Violet.opacity(0.2)]), startPoint: .bottom, endPoint: .top)
                .edgesIgnoringSafeArea(.all)
            RoundedRectangle(cornerRadius: 25)
                .fill(Color.clear)
                .frame(width: 350, height: 600)
                .shadow(color: Color.black.opacity(0.2), radius: 20, x: 0, y: 20)
        }
    }
}

struct Variant2: View {
    var body: some View {
        ZStack {
            LinearGradient(gradient: Gradient(colors: [Color.deepOrange, Color.brightOrange]), startPoint: .topLeading, endPoint: .bottomTrailing)
                .edgesIgnoringSafeArea(.all)
            RoundedRectangle(cornerRadius: 25)
                .fill(Color.clear)
                .frame(width: 350, height: 600)
                .shadow(color: Color.Violet.opacity(0.4), radius: 10, x: 10, y: 10)
        }
    }
}

struct Variant3: View {
    var body: some View {
        ZStack {
            Color.deepOrange
                .edgesIgnoringSafeArea(.all)
            RoundedRectangle(cornerRadius: 25)
                .fill(Color.Violet.opacity(0.2))
                .frame(width: 350, height: 600)
                .shadow(color: Color.black.opacity(0.3), radius: 15, x: 0, y: 15)
        }
    }
}

struct Variant4: View {
    var body: some View {
        ZStack {
            RadialGradient(gradient: Gradient(colors: [Color.deepOrange, Color.brightOrange]), center: .center, startRadius: 5, endRadius: 500)
                .edgesIgnoringSafeArea(.all)
        }
    }
}

struct Variant5: View {
    var body: some View {
        ZStack {
            LinearGradient(gradient: Gradient(colors: [Color.deepOrange, Color.brightOrange]), startPoint: .top, endPoint: .bottom)
                .edgesIgnoringSafeArea(.all)
            Circle()
                .fill(Color.Violet.opacity(0.2))
                .frame(width: 250, height: 250)
                .shadow(color: Color.black.opacity(0.3), radius: 15, x: 0, y: 15)
        }
    }
}

struct DiagonalGradientBackground: View {
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                Path { path in
                    path.move(to: CGPoint(x: 0, y: 0))
                    path.addLine(to: CGPoint(x: geometry.size.width, y: 0))
                    path.addLine(to: CGPoint(x: 0, y: geometry.size.height))
                    path.closeSubpath()
                }
                .fill(LinearGradient(gradient: Gradient(colors: [Color.brightOrange, Color.deepOrange]), startPoint: .topLeading, endPoint: .bottomTrailing))
                
                Path { path in
                    path.move(to: CGPoint(x: geometry.size.width, y: 0))
                    path.addLine(to: CGPoint(x: 0, y: geometry.size.height))
                    path.addLine(to: CGPoint(x: geometry.size.width, y: geometry.size.height))
                    path.closeSubpath()
                }
                .fill(LinearGradient(gradient: Gradient(colors: [Color.Violet.opacity(0.2), Color.Violet]), startPoint: .topTrailing, endPoint: .bottomLeading))
            }
            .edgesIgnoringSafeArea(.all)
        }
    }
}

struct DiagonalShadedBackground: View {
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                Color.brightOrange
                Path { path in
                    path.move(to: CGPoint(x: 0, y: 0))
                    path.addLine(to: CGPoint(x: geometry.size.width, y: 0))
                    path.addLine(to: CGPoint(x: 0, y: geometry.size.height))
                    path.closeSubpath()
                }
                .fill(Color.Violet.opacity(0.3))
                .shadow(color: Color.black.opacity(0.3), radius: 15, x: 10, y: 10)
                
                Path { path in
                    path.move(to: CGPoint(x: geometry.size.width, y: 0))
                    path.addLine(to: CGPoint(x: 0, y: geometry.size.height))
                    path.addLine(to: CGPoint(x: geometry.size.width, y: geometry.size.height))
                    path.closeSubpath()
                }
                .fill(Color.deepOrange)
                .shadow(color: Color.black.opacity(0.3), radius: -15, x: -10, y: -10)
            }
            .edgesIgnoringSafeArea(.all)
        }
    }
}

struct DiagonalSolidShadedBackground: View {
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                Color.brightOrange
                
                Path { path in
                    path.move(to: CGPoint(x: 0, y: 0))
                    path.addLine(to: CGPoint(x: geometry.size.width, y: 0))
                    path.addLine(to: CGPoint(x: 0, y: geometry.size.height))
                    path.closeSubpath()
                }
                .fill(Color.Violet.opacity(0.3))
                
                Path { path in
                    path.move(to: CGPoint(x: geometry.size.width, y: 0))
                    path.addLine(to: CGPoint(x: 0, y: geometry.size.height))
                    path.addLine(to: CGPoint(x: geometry.size.width, y: geometry.size.height))
                    path.closeSubpath()
                }
                .fill(Color.deepOrange)
            }
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
                .fill(LinearGradient(gradient: Gradient(colors: [Color.brightOrange, Color.Violet.opacity(0.2)]), startPoint: .topLeading, endPoint: .bottomTrailing))
                
                Path { path in
                    path.move(to: .zero)
                    path.addLine(to: CGPoint(x: 0, y: geometry.size.height))
                    path.addLine(to: CGPoint(x: geometry.size.width, y: geometry.size.height))
                    path.closeSubpath()
                }
                .fill(LinearGradient(gradient: Gradient(colors: [Color.Violet.opacity(0.2), Color.deepOrange]), startPoint: .bottomLeading, endPoint: .topTrailing))
            }
        }
        .edgesIgnoringSafeArea(.all)
    }
}

struct DiagonalShadow1: View {
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                Path { path in
                    path.move(to: .zero)
                    path.addLine(to: CGPoint(x: geometry.size.width, y: 0))
                    path.addLine(to: CGPoint(x: geometry.size.width, y: geometry.size.height))
                    path.closeSubpath()
                }
                .fill(Color.brightOrange)
                .shadow(color: Color.Violet.opacity(0.2), radius: 10, x: -10, y: -10)
                
                Path { path in
                    path.move(to: .zero)
                    path.addLine(to: CGPoint(x: 0, y: geometry.size.height))
                    path.addLine(to: CGPoint(x: geometry.size.width, y: geometry.size.height))
                    path.closeSubpath()
                }
                .fill(Color.deepOrange)
                .shadow(color: Color.Violet.opacity(0.2), radius: 10, x: 10, y: 10)
            }
        }
        .edgesIgnoringSafeArea(.all)
    }
}

struct DiagonalGradient2: View {
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                Path { path in
                    path.move(to: .zero)
                    path.addLine(to: CGPoint(x: geometry.size.width, y: 0))
                    path.addLine(to: CGPoint(x: geometry.size.width, y: geometry.size.height))
                    path.closeSubpath()
                }
                .fill(LinearGradient(gradient: Gradient(colors: [Color.brightOrange, Color.deepOrange]), startPoint: .topLeading, endPoint: .bottomTrailing))
                
                Path { path in
                    path.move(to: .zero)
                    path.addLine(to: CGPoint(x: 0, y: geometry.size.height))
                    path.addLine(to: CGPoint(x: geometry.size.width, y: geometry.size.height))
                    path.closeSubpath()
                }
                .fill(LinearGradient(gradient: Gradient(colors: [Color.deepOrange, Color.brightOrange]), startPoint: .bottomLeading, endPoint: .topTrailing))
            }
        }
        .edgesIgnoringSafeArea(.all)
    }
}

