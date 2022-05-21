//
//  SideMenuViewModel.swift
//  twitter-clone
//
//  Created by JISU MIN on 2022/04/12.
//

import Foundation

enum SideMenuViewModel: Int, CaseIterable {
  case profile
  case listz
  case bookmarks
  case logout
  
  var title: String {
    switch self {
    case .profile: return "Profile"
    case .listz: return "Lists"
    case .bookmarks: return "Bookmarks"
    case .logout: return "Logout"
    }
  }
  
  var imageName: String {
    switch self {
    case .profile: return "person"
    case .listz: return "list.bullet"
    case .bookmarks: return "bookmark"
    case .logout: return "arrow.left.square"
    }
  }
}
