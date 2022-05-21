//
//  UploadTweetViewModel.swift
//  twitter-clone
//
//  Created by JISU MIN on 2022/04/21.
//

import Foundation

class UploadTweetViewModel: ObservableObject {
  @Published var didUploadTweet = false
  let service = TweetService()
  
  func uploadTweet(withCaption caption: String) {
    service.uploadTweet(caption: caption) { success in
      self.didUploadTweet = success
    }
  }
}
