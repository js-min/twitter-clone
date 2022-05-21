//
//  User.swift
//  twitter-clone
//
//  Created by JISU MIN on 2022/04/19.
//

import FirebaseFirestoreSwift
import Firebase

struct User: Identifiable, Decodable {
  @DocumentID var id: String?
  let username: String
  let fullname: String
  let profileImageUrl: String
  let email: String
  
  var isCurrentUser: Bool {
    return Auth.auth().currentUser?.uid == id
  }
}
