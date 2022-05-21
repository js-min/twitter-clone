//
//  TweetFilterViewModel.swift
//  twitter-clone
//
//  Created by JISU MIN on 2022/04/11.
//

import Foundation

enum TweetFilterViewModel: Int, CaseIterable {
  case tweets
  case replies
  case likes
  
  var title: String {
    switch (self) {
    case .tweets: return "Tweets"
    case .replies: return "Replies"
    case .likes: return "Likes"
    }
  }
}
