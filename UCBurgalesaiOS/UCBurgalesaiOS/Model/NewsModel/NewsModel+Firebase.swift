//
//  NewsModel+Firebase.swift
//  UCBurgalesaiOS
//
//  Created by Markel Juaristi on 30/10/23.
//

import Foundation

extension NewsModel {
    
    init?(from data: [String: Any]) {
        guard let title = data["title"] as? String,
              let content = data["content"] as? String,
              let imageUrlString = data["imageUrl"] as? String,
              let imageUrl = URL(string: imageUrlString) else {
            return nil
        }
        
        self.id = data["id"] as? String ?? UUID().uuidString
        self.title = title
        self.content = content
        self.imageUrl = imageUrl
    }
    
    func toFirestoreData() -> [String: Any] {
        return [
            "id": id,
            "title": title,
            "content": content,
            "imageUrl": imageUrl.absoluteString
        ]
    }
}
