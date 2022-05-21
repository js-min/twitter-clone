//
//  TweetService.swift
//  twitter-clone
//
//  Created by JISU MIN on 2022/04/21.
//

import Firebase

struct TweetService {
  
  func uploadTweet(caption: String, completion: @escaping(Bool) -> Void) {
    guard let uid = Auth.auth().currentUser?.uid else { return }
    let data: [String: Any] = [
      "uid": uid,
      "caption": caption,
      "likes": 0,
      "timestamp": Timestamp(date: Date())
    ]
    
    Firestore.firestore().collection("tweets").document()
      .setData(data) { error in
        completion(error == nil)
      }
  }
  
  func fetchTweets(completion: @escaping([Tweet]) -> Void) {
    Firestore.firestore().collection("tweets")
      .order(by: "timestamp", descending: true)
      .getDocuments { snapshot, _ in
        guard let documents = snapshot?.documents else { return }
        let tweets = documents.compactMap({ try? $0.data(as: Tweet.self)})
        completion(tweets)
      }
  }
  
  func fetchTweets(forUid uid: String, completion: @escaping([Tweet]) -> Void) {
    Firestore.firestore().collection("tweets")
      .whereField("uid", isEqualTo: uid)
      .getDocuments { snapshot, _ in
        guard let documents = snapshot?.documents else { return }
        let tweets = documents.compactMap({ try? $0.data(as: Tweet.self)})
        completion(tweets.sorted(by: { $0.timestamp.dateValue() > $1.timestamp.dateValue()}))
      }
  }
  
  func likeTweet(_ tweet: Tweet, completion: @escaping() -> Void) {
    guard
      let uid = Auth.auth().currentUser?.uid,
      let tweetId = tweet.id
    else { return }
    let userLikeRef = Firestore.firestore().collection("users").document(uid).collection("user-likes")
    Firestore.firestore().collection("tweets").document(tweetId)
      .updateData(["likes": tweet.likes + 1]) {_ in
        userLikeRef.document(tweetId).setData([:]) { _ in
          completion()
        }
      }
  }
  
  func unlikeTweet(_ tweet: Tweet, completion: @escaping() -> Void) {
    guard
      let uid = Auth.auth().currentUser?.uid,
      let tweetId = tweet.id,
      tweet.likes > 0
    else { return }
    let userLikeRef = Firestore.firestore().collection("users").document(uid).collection("user-likes")
    Firestore.firestore().collection("tweets").document(tweetId)
      .updateData(["likes": tweet.likes - 1]) {_ in
        userLikeRef.document(tweetId).delete() { _ in
          completion()
        }
      }
  }
  
  func checkIfUserLikedTweet(_ tweet: Tweet, completion: @escaping(Bool) -> Void) {
    guard
      let uid = Auth.auth().currentUser?.uid,
      let tweetId = tweet.id
    else { return }
    Firestore.firestore().collection("users")
      .document(uid)
      .collection("user-likes")
      .document(tweetId)
      .getDocument { snapshot, _ in
        completion(snapshot?.exists ?? false)
    }
  }
  
  func fetchLikedTweets(forUid uid: String, completion: @escaping([Tweet]) -> Void) {
    var tweets = [Tweet]()
    Firestore.firestore().collection("users")
      .document(uid)
      .collection("user-likes")
      .getDocuments { snapshot, _ in
        guard let documents = snapshot?.documents else { return }
        documents.forEach { doc in
          let tweetId = doc.documentID
          Firestore.firestore().collection("tweets")
            .document(tweetId)
            .getDocument { tweetSnapshot, _ in
              guard let tweet = try? tweetSnapshot?.data(as: Tweet.self) else { return }
              tweets.append(tweet)
            }
        }
        completion(tweets)
      }
  }
}
