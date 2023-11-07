//
//  Styles.swift
//  UCBurgalesaiOS
//
//  Created by Markel Juaristi on 18/10/23.
//

import Foundation
import SwiftUI


extension Button where Label == Text {
    func buttonStyle() -> some View {
        self
            .padding()
            .foregroundColor(.white)
            .cornerRadius(10)
            .shadow(color: Color.gray.opacity(0.2), radius: 5, x: 0, y: 2)
    }
}


extension Button where Label == Text {
    func brightOrangeButton() -> some View {
        self
            .buttonStyle()
            .background(Color.brightOrange)
            .cornerRadius(10)
        
    }
    
    func deepOrangeButton() -> some View {
        self
            .buttonStyle()
            .background(Color.deepOrange)
            .cornerRadius(10)
    }
    
    func vibrantVioletButton() -> some View {
        self
            .buttonStyle()
            .background(Color.violet)
            .cornerRadius(10)
    }
}

extension Toggle where Label == Text {
    func toggleStyleCustom() -> some View {
        self
            .toggleStyle(SwitchToggleStyle(tint: Color.brightOrange))
            .padding()
            .background(Color.gray.opacity(0.2))
            .cornerRadius(10)
    }
}

extension DatePicker {
    func datePickerStyleCustom() -> some View {
        self
            .datePickerStyle(GraphicalDatePickerStyle())
            .padding()
            .background(Color.gray.opacity(0.2))
            .cornerRadius(10)
    }
}

extension TextField {
    func textFieldStyle() -> some View {
        self
            .padding()
            .background(Color.gray.opacity(0.2))
            .cornerRadius(10)
    }
}
//flecha para volver atras.
struct BackButton: View {
    @EnvironmentObject var appState: AppState // Accede a appState desde el entorno
    var destination: AppState.AppView

    var body: some View {
        Button(action: {
            appState.currentView = destination
        }) {
            Image(systemName: "arrow.left")
        }
    }
}

/*
struct BackButton: View {
    @EnvironmentObject var appState: AppState
    var destination: AppState.AppView
    
    var body: some View {
        Image(systemName: "arrow.left")
            .resizable()
            .scaledToFit()
            .frame(width: 20, height: 20)
            .onTapGesture {
                appState.currentView = destination
            }
    }
}
*/





