//
//  NewsView.swift
//  UCBurgalesaiOS
//
//  Created by Markel Juaristi on 20/10/23.
//

import SwiftUI

struct NewsView: View {
    @ObservedObject var viewModel = NewsViewModel()
    
    var body: some View {
        List(viewModel.newsItems) { newsItem in
            VStack(alignment: .leading) {
                Text(newsItem.title).font(.headline)
                Text(newsItem.content).font(.subheadline)
                URLImage(url: newsItem.imageUrl)
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 300, height: 200)
            }
        }
        .onAppear {
            viewModel.fetchNews()
        }
    }
}




struct NewsView_Previews: PreviewProvider {
    static var previews: some View {
        NewsView()
    }
}
