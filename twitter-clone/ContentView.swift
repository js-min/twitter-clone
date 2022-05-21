//
//  ContentView.swift
//  twitter-clone
//
//  Created by JISU MIN on 2022/04/10.
//

import SwiftUI
import Kingfisher

struct ContentView: View {
  @State private var showMenu = false
  @EnvironmentObject var viewModel: AuthViewModel
  
    var body: some View {
      Group {
        if viewModel.userSession == nil {
          LoginView()
        } else {
          mainView
        }
      }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}


extension ContentView {
  var mainView: some View {
    ZStack(alignment: .topLeading) {
      MainTabView()
        .navigationBarHidden(showMenu)
      
      if showMenu {
        ZStack {
          Color(.black)
            .opacity(0.25)
            .onTapGesture {
              withAnimation(.easeInOut) {
                showMenu = false
              }
            }
            .ignoresSafeArea()
        }
      }
      
      SideMenuView()
        .frame(width: 300)
        .offset(x: showMenu ? 0 : -300, y: 0)
        .background(showMenu ? .white : .clear)
        .environmentObject(viewModel)
    }
    .navigationTitle("Home")
    .navigationBarTitleDisplayMode(.inline)
    .toolbar {
      ToolbarItem(placement: .navigationBarLeading) {
        if let user = viewModel.currentUser {
          Button{
            withAnimation(.easeInOut) {
              showMenu.toggle()
            }
          } label: {
            KFImage(URL(string: user.profileImageUrl))
              .resizable()
              .scaledToFill()
              .clipShape(Circle())
              .frame(width: 32, height: 32)
          }
        }
      }
    }
    .onAppear {
      showMenu = false
    }
  }
}
