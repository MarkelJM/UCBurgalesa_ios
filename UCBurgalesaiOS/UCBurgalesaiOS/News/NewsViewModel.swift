//
//  NewsViewModel.swift
//  UCBurgalesaiOS
//
//  Created by Markel Juaristi on 20/10/23.
//

import Foundation

class NewsViewModel: ObservableObject {
    @Published var newsItems: [NewsModel] = []
    private var firestoreManager = FirestoreManager()
    
    func fetchNews() {
        firestoreManager.fetchAllNews { (news, error) in
            if let news = news {
                self.newsItems = news
            } else if let error = error {
                print("Error fetching news: \(error.localizedDescription)")
            }
        }
    }
}
