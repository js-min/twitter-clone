//
//  ProfileViewModel.swift
//  twitter-clone
//
//  Created by JISU MIN on 2022/04/23.
//

import Foundation

class ProfileViewModel: ObservableObject {
  @Published var tweets = [Tweet]()
  @Published var likedTweets = [Tweet]()
  
  let user: User
  private let service = TweetService()
  private let userService = UserService()
  
  var buttonTitle: String {
    return user.isCurrentUser ? "Edit Profile" : "Follow"
  }
  
  init(user: User) {
    self.user = user
    fetchUserTweets()
    fetchLikedTweets()
  }
  
  func tweets(forFilter filter: TweetFilterViewModel) -> [Tweet] {
    switch filter {
    case .tweets:
      return tweets
    case.replies:
      return tweets
    case .likes:
      return likedTweets
    }
  }
  
  func fetchUserTweets() {
    guard let uid = user.id else { return }
    service.fetchTweets(forUid: uid) { tweets in
      self.tweets = tweets
      for i in 0..<tweets.count {
        self.tweets[i].user = self.user
      }
    }
  }
  
  func fetchLikedTweets() {
    guard let uid = user.id else { return }
    service.fetchLikedTweets(forUid: uid) { tweets in
      self.likedTweets = tweets
      for i in 0..<tweets.count {
        self.userService.fetchUser(with: self.tweets[i].uid, completion: { user in
          self.likedTweets[i].user = user
        })
      }
    }
  }
}
