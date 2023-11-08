//
//  CheckinSheetView.swift
//  UCBurgalesaiOS
//
//  Created by Markel Juaristi on 8/11/23.
//

import SwiftUI

struct CheckinSheetView: View {
    @ObservedObject var viewModel: CheckinViewModel
    
    var body: some View {
        VStack {
            Button("Check-in Salida") {
                viewModel.initiateCheckin(type: .start)
            }
            Button("Check-in Descanso") {
                viewModel.initiateCheckin(type: .rest)
            }
        }
    }
}


struct CheckinSheetView_Previews: PreviewProvider {
    static var previews: some View {
        // Aquí puedes crear un viewModel ficticio o usar uno real si es necesario
        CheckinSheetView(viewModel: CheckinViewModel())
    }
}
