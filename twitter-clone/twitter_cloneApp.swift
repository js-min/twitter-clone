//
//  twitter_cloneApp.swift
//  twitter-clone
//
//  Created by JISU MIN on 2022/04/10.
//

import SwiftUI
import Firebase

@main
struct twitter_cloneApp: App {
  
  @StateObject var viewModel = AuthViewModel()
  
  init() {
    FirebaseApp.configure()
  }
  
    var body: some Scene {
        WindowGroup {
          NavigationView {
            ContentView()
          }
          .environmentObject(viewModel)
        }
    }
}
