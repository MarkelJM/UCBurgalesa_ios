//
//  SponsorModel+Firebase.swift
//  UCBurgalesaiOS
//
//  Created by Markel Juaristi on 25/10/23.
//

import Foundation

extension SponsorModel {
    init?(from document: [String: Any]) {
        guard let sponsorURL = document["sponsor"] as? String else { return nil }
        self.sponsorURL = sponsorURL
    }
}
