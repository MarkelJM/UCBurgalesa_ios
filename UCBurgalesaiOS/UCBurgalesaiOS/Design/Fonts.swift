//
//  Fonts.swift
//  UCBurgalesaiOS
//
//  Created by Markel Juaristi on 17/10/23.
//

import Foundation
import SwiftUI

extension Font {
    static func whatTheFont(size: CGFloat) -> Font {
        return Font.custom("WhatTheFont-Regular", size: size) // Asegúrate de usar el nombre correcto de la fuente.
    }
    
    static func identifont(size: CGFloat) -> Font {
        return Font.custom("Identifont-Regular", size: size) // Asegúrate de usar el nombre correcto de la fuente.
    }
}
