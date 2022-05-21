//
//  Tweet.swift
//  twitter-clone
//
//  Created by JISU MIN on 2022/04/23.
//

import FirebaseFirestoreSwift
import Firebase

struct Tweet: Identifiable, Decodable {
  @DocumentID var id: String?
  let caption: String
  let timestamp: Timestamp
  let uid: String
  var likes: Int
  
  var user: User?
  var didLike: Bool? = false
}


