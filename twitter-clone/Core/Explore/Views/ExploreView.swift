//
//  ExploreView.swift
//  twitter-clone
//
//  Created by JISU MIN on 2022/04/10.
//

import SwiftUI

struct ExploreView: View {
  @ObservedObject var viewModel = ExploreViewModel()
  
    var body: some View {
      VStack {
        SearchBar(text: $viewModel.searchText)
          .padding()
        ScrollView {
          LazyVStack {
            ForEach(viewModel.users, id: \.self.id) { user in
              NavigationLink {
                ProfileView(user: user)
              } label: {
                UserRowView(user: user)
              }
            }
          }
        }
      }
      .navigationTitle("Explore")
      .navigationBarTitleDisplayMode(.inline)
    }
}

struct ExploreView_Previews: PreviewProvider {
    static var previews: some View {
        ExploreView()
        .previewDisplayName("iPhone 13")
    }
}
