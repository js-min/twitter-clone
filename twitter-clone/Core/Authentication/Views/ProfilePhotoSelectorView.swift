//
//  ProfilePhotoSelectorView.swift
//  twitter-clone
//
//  Created by JISU MIN on 2022/04/16.
//

import SwiftUI

struct ProfilePhotoSelectorView: View {
  @EnvironmentObject var viewModel: AuthViewModel
  
  @State private var showImagePicker = false
  @State private var selectedImage: UIImage?
  @State private var profileImage: Image?
  
    var body: some View {
      VStack {
        AuthHeaderView(title1: "Create your account", title2: "Add a profile photo")
        
        Button {
          showImagePicker.toggle()
        } label: {
          if let profileImage = profileImage {
             profileImage
              .resizable()
              .modifier(ProfileImageModifier())
          } else {
            Image(systemName: "person.badge.plus.fill")
              .renderingMode(.template)
              .modifier(ProfileImageModifier())
          }
        }
        .sheet(isPresented: $showImagePicker,
               onDismiss: loadImage) {
          ImagePicker(selectedImage: $selectedImage)
        }
        .padding(.top, 44)
        
        if let selectedImage = selectedImage {
          Button {
            viewModel.uploadProfileImage(selectedImage)
          } label: {
            Text("Continue")
              .font(.headline)
              .foregroundColor(.white)
              .frame(width: 300, height: 50)
              .background(Color(.systemBlue))
              .clipShape(Capsule())
              .padding()
          }
        }
        Spacer()
      }
      .ignoresSafeArea()
    }
  
  func loadImage() {
    guard let selectedImage = selectedImage else { return }
    profileImage = Image(uiImage: selectedImage)

  }
}

private struct ProfileImageModifier: ViewModifier {
  func body(content: Content) -> some View {
    content
      .foregroundColor(Color(.systemBlue))
      .frame(width: 180, height: 180)
      .clipShape(Circle())
  }
}

struct ProfilePhotoSelectorView_Previews: PreviewProvider {
    static var previews: some View {
        ProfilePhotoSelectorView()
    }
}
