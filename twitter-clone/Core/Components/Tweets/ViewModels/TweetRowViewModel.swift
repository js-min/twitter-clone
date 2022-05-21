//
//  TweetRowViewModel.swift
//  twitter-clone
//
//  Created by JISU MIN on 2022/04/23.
//

import Foundation

class TweetRowViewModel: ObservableObject {
  private let service = TweetService()
  @Published var tweet: Tweet
  
  init(tweet: Tweet) {
    self.tweet = tweet
    checkIfUserLikedTweet()
  }
  
  func likeTweet() {
    service.likeTweet(tweet) { 
      self.tweet.didLike = true
    }
  }
  
  func unlikeTweet() {
    service.unlikeTweet(tweet) {
      self.tweet.didLike = false
    }
  }
  
  func checkIfUserLikedTweet() {
    service.checkIfUserLikedTweet(tweet) { didLike in
      if didLike {
        self.tweet.didLike = true
      }
    }
  }
}
