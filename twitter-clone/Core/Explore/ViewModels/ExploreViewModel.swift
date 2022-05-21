//
//  ExploreViewModel.swift
//  twitter-clone
//
//  Created by JISU MIN on 2022/04/20.
//

import Foundation

class ExploreViewModel: ObservableObject {
  @Published var users = [User]()
  @Published var searchText = ""
  
  var searchableUsers: [User] {
    if searchText.isEmpty {
      return users
    } else {
      let lowerCasedQuery = searchText.lowercased()
      return users.filter({ $0.username.contains(lowerCasedQuery) || $0.fullname.lowercased().contains(lowerCasedQuery) })
    }
  }
  let userService = UserService()
  
  init() {
    fetchUsers()
  }
  
  func fetchUsers() {
    userService.fetchUsers { users in
      self.users = users
    }
  }
}
