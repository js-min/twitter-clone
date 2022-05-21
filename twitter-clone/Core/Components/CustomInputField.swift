//
//  CustomInputField.swift
//  twitter-clone
//
//  Created by JISU MIN on 2022/04/14.
//

import SwiftUI

struct CustomInputField: View {
  let imageName: String
  let placeholderText: String
  var isSecure: Bool? = false
  @Binding var text: String
  
  var body: some View {
    VStack {
      HStack {
        Image(systemName: imageName)
          .resizable()
          .scaledToFit()
          .frame(width: 20, height: 20)
          .foregroundColor(Color(.darkGray))
        
        if isSecure ?? false {
          SecureField(placeholderText, text: $text)
        } else {
          TextField(placeholderText, text: $text)
        }
        
      }
      
      Divider()
        .background(Color(.darkGray))
    }
  }
}

struct CustomInputField_Previews: PreviewProvider {
    static var previews: some View {
      CustomInputField(
        imageName: "envelope",
        placeholderText: "Email",
        isSecure: false,
        text: .constant(""))
    }
}
