//
//  DetailsRoutesViewModel.swift
//  UCBurgalesaiOS
//
//  Created by Markel Juaristi on 30/10/23.
//

import Foundation

class DetailRoutesViewModel: ObservableObject {
    @Published var ride: RideModel

    init(ride: RideModel) {
        self.ride = ride
    }

    
}
