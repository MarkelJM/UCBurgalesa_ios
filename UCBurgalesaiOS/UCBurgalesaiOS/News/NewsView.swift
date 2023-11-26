//
//  NewsView.swift
//  UCBurgalesaiOS
//
//  Created by Markel Juaristi on 20/10/23.
//
import SwiftUI

struct NewsView: View {
    @ObservedObject var viewModel = NewsViewModel()
    @EnvironmentObject var appState: AppState
    
    var body: some View {
        ZStack {
            DiagonalSolidShadedBackground()
                .edgesIgnoringSafeArea(.all)

            ScrollView {
                VStack(spacing: 20) {
                    headerView
                    newsListView
                }
                .padding([.leading, .trailing], 10)
                .padding(.top, 20)
                .background(Color.white.opacity(0.9))
                .cornerRadius(15)
                .shadow(radius: 10)
            }
        }
        .onAppear {
            viewModel.fetchNews()
        }
    }

    var headerView: some View {
        HStack {
            BackButton(destination: .home)
                .environmentObject(appState)
            Spacer()
            Text("Noticias")
                .font(.title)
            Spacer()
        }
    }

    var newsListView: some View {
        ForEach(viewModel.newsItems) { newsItem in
            VStack(alignment: .leading) {
                if let title = newsItem.title {
                    Text(title)
                        .font(.headline)
                        .padding(.bottom, 2)
                }
                if let content = newsItem.content {
                    Text(content)
                        .font(.subheadline)
                        .padding(.bottom, 5)
                }
                if let imageUrl = newsItem.imageUrl {
                    URLImage(url: imageUrl)
                        .aspectRatio(contentMode: .fit)
                        .frame(maxWidth: UIScreen.main.bounds.width - 50, maxHeight: 200)
                        .cornerRadius(10)
                }
            }
            .padding()
            .background(Color.gray.opacity(0.2))
            .cornerRadius(10)
            .padding(.bottom, 10)
        }
    }
}

struct NewsView_Previews: PreviewProvider {
    static var previews: some View {
        NewsView().environmentObject(AppState())
    }
}
