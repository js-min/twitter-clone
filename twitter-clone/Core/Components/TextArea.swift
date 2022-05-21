//
//  TextArea.swift
//  twitter-clone
//
//  Created by JISU MIN on 2022/04/13.
//

import SwiftUI

struct TextArea: View {
  
  let placeholder: String
  @Binding var text: String
  
  init(_ placeholder: String, text: Binding<String>) {
    self.placeholder = placeholder
    self._text = text
    UITextView.appearance().backgroundColor = .clear
  }
  
    var body: some View {
      ZStack(alignment: .topLeading) {
        if text.isEmpty {
          Text(placeholder)
          .foregroundColor(Color(.placeholderText))
          .padding(.horizontal, 8)
          .padding(.vertical, 12)
        } else {
          TextEditor(text: $text)
            .padding(4)
        }
        
      }
      .font(.body)
    }
}
