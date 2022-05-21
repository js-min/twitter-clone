//
//  AuthViewModel.swift
//  twitter-clone
//
//  Created by JISU MIN on 2022/04/16.
//

import SwiftUI
import Firebase

class AuthViewModel: ObservableObject {
  
  @Published var userSession: FirebaseAuth.User?
  @Published var didAuthUser = false
  @Published var currentUser: User?
  private var tempUserSession: FirebaseAuth.User?
  
  private let service = UserService()
  
  init() {
    userSession = Auth.auth().currentUser
  }
  
  func login(withEmail email: String, password: String) {
    Auth.auth().signIn(withEmail: email, password: password) { result, error in
      if let error = error {
        print("FAILED TO register \(error.localizedDescription)")
        return
      }
      
      guard let user = result?.user else { return }
      self.userSession = user
    }
  }
  
  func register(withEmail email: String, password: String, fullname: String, username: String) {
    Auth.auth().createUser(withEmail: email, password: password) { result, error in
      if let error = error {
        print("FAILED TO register \(error.localizedDescription)")
        return
      }
      
      guard let user = result?.user else { return }
      self.tempUserSession = user
      
      let data = ["email": email,
                  "username": username.lowercased(),
                  "fullname": fullname,
                  "uid": user.uid]
      Firestore.firestore().collection("users")
        .document(user.uid)
        .setData(data) { _ in
          self.didAuthUser = true
        }
    }
  }
  
  func signOut() {
    userSession = nil
    try? Auth.auth().signOut()
  }
  
  func uploadProfileImage(_ image: UIImage) {
    guard let uid = tempUserSession?.uid else { return }
    ImageUploader.upload(image: image) { imageUrl in
      Firestore.firestore().collection("users")
        .document(uid)
        .updateData(["profileImageUrl": imageUrl]) { _ in
          self.userSession = self.tempUserSession
          self.fetchUser()
        }
    }
  }
  
  func fetchUser() {
    guard let uid = self.userSession?.uid else { return }
    service.fetchUser(with: uid) { user in
      self.currentUser = user
    }
  }
}
