//
//  ImageUploader.swift
//  twitter-clone
//
//  Created by JISU MIN on 2022/04/18.
//

import Firebase
import UIKit

struct ImageUploader {
  static func upload(image: UIImage, completion: @escaping(String) -> Void) {
    guard let imageData = image.jpegData(compressionQuality: 0.5) else { return }
    let fileName = UUID().uuidString
    let ref = Storage.storage().reference(withPath: "/profile_image/\(fileName)")
    ref.putData(imageData, metadata: nil) { _, error in
      if let error = error {
        print("DEBUG: Failed to upload \(error.localizedDescription)")
        return
      }
      
      ref.downloadURL { imageUrl, _ in
        guard let imageUrl = imageUrl?.absoluteString else { return }
        completion(imageUrl)
      }
    }
  }
}
