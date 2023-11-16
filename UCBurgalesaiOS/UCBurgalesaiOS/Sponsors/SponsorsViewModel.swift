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
        firestoreManager.getSponsors { [weak self] (sponsors, error) in
            DispatchQueue.main.async {
                if let error = error {
                    self?.errorMessage = "Error al cargar patrocinadores: \(error.localizedDescription)"
                } else if let sponsors = sponsors {
                    self?.sponsors = sponsors
                } else {
                    self?.errorMessage = "No se encontraron patrocinadores"
                }
            }
        }
    }
}

