//
//  SponsorsViewModel.swift
//  UCBurgalesaiOS
//
//  Created by Markel Juaristi on 20/10/23.
//

import Foundation

class SponsorsViewModel: ObservableObject {
    @Published var sponsors: [SponsorModel] = []
    @Published var errorMessage: String = ""

    private var firestoreManager = FirestoreManager()

    func fetchSponsors() {
        firestoreManager.getSponsors { (sponsors, error) in
            if let error = error {
                self.errorMessage = error.localizedDescription
            } else if let sponsors = sponsors {
                self.sponsors = sponsors
            }
        }
    }
}
