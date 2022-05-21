//
//  RegistrationView.swift
//  twitter-clone
//
//  Created by JISU MIN on 2022/04/13.
//

import SwiftUI

struct RegistrationView: View {
  
  @Environment(\.presentationMode) var presentationMode
  @EnvironmentObject var viewModel: AuthViewModel
  
  @State private var email = ""
  @State private var username = ""
  @State private var fullname = ""
  @State private var password = ""
  
    var body: some View {
      ScrollView {
        VStack {
          
          NavigationLink(destination: ProfilePhotoSelectorView(), isActive: $viewModel.didAuthUser, label: {})

          AuthHeaderView(title1: "Get Started.",
                         title2: "Create your account")
          VStack(spacing: 40) {
            CustomInputField(imageName: "envelope",
                             placeholderText: "Email",
                             text: $email)
            CustomInputField(imageName: "lock",
                             placeholderText: "Username",
                             text: $username)
            CustomInputField(imageName: "envelope",
                             placeholderText: "Full name",
                             text: $fullname)
            CustomInputField(imageName: "lock",
                             placeholderText: "Password",
                             isSecure: true,
                             text: $password)
          }
          .padding(32)
          
          Button {
            viewModel.register(withEmail: email, password: password, fullname: fullname, username: username)
          } label: {
            Text("Sign Up")
              .font(.headline)
              .foregroundColor(.white)
              .frame(width: 300, height: 50)
              .background(Color(.systemBlue))
              .clipShape(Capsule())
              .padding()
          }
          
          Button {
            presentationMode.wrappedValue.dismiss()
          } label: {
            HStack {
              Text("Already have an account?")
                .font(.footnote)
              Text("Sign In")
                .font(.footnote)
                .fontWeight(.semibold)
            }
          }
          .padding(.bottom, 32)
          .foregroundColor(Color(.systemBlue))
        }
        
      }
      .ignoresSafeArea()
    }
}

struct RegistrationView_Previews: PreviewProvider {
    static var previews: some View {
        RegistrationView()
          .previewDevice(PreviewDevice(rawValue: "iPhone SE"))
    }
}
