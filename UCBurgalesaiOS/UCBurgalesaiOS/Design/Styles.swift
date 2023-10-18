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
    }
    
    func deepOrangeButton() -> some View {
        self
            .buttonStyle()
            .background(Color.deepOrange)
    }
    
    func vibrantVioletButton() -> some View {
        self
            .buttonStyle()
            .background(Color.Violet)
    }
}

extension Toggle where Label == Text {
    func toggleStyle() -> some View {
        self
            .toggleStyle(SwitchToggleStyle(tint: Color.brightOrange))
            .padding()
            .background(Color.gray.opacity(0.2))
            .cornerRadius(10)
    }
}

extension DatePicker {
    func datePickerStyle() -> some View {
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



