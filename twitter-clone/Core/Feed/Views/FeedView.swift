//
//  FeedView.swift
//  twitter-clone
//
//  Created by JISU MIN on 2022/04/10.
//

import SwiftUI

struct FeedView: View {
  @State private var showNewTweetView = false
  @ObservedObject var viewModel = FeedViewModel()
  
  
    var body: some View {
      ZStack(alignment: .bottomTrailing) {
        ScrollView {
          LazyVStack {
            ForEach(viewModel.tweets, id: \.id) { tweet in
              TweetRowView(tweet: tweet)
            }
          }
        }
        
        Button {
          showNewTweetView.toggle()
        } label: {
          Image(systemName: "pencil")
            .frame(width: 36, height: 36)
            .padding()
        }
        .background(Color(.systemBlue))
        .foregroundColor(.white)
        .clipShape(Circle())
        .padding()
        .fullScreenCover(isPresented: $showNewTweetView) {
          NewTweetView()
        }
      }
      .navigationBarTitleDisplayMode(.inline)
    }
}

struct FeedView_Previews: PreviewProvider {
    static var previews: some View {
        FeedView()
    }
}
