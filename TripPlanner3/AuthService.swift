//
//   AuthService.swift
//  TripPlanner3
//
//  Created by stlp on 8/7/24.
//

//import Foundation
//import FirebaseAuth
//import FirebaseFirestore
//
//class AuthService {
//    
//    public static let shared = AuthService()
//    private init() {}
//    
//    /// A method to register the user
//    /// - Parameters:
//    ///   - userRequest: The users information (email, password, username)
//    ///   - completion: A completion with two values...
//    ///   - Bool: wasRegistered - Determines if the user was registered and saved in the database correctly
//    ///   - Error?: An optional error if firebase provides once
//    public func registerUser(with userRequest: RegiserUserRequest, completion: @escaping (Bool, Error?)->Void) {
//        let username = userRequest.username
//        let email = userRequest.email
//        let password = userRequest.password
//        
//        Auth.auth().createUser(withEmail: email, password: password) { result, error in
//            if let error = error {
//                completion(false, error)
//                return
//            }
//            
//            guard let resultUser = result?.user else {
//                completion(false, nil)
//                return
//            }
//            
//            let db = Firestore.firestore()
//            db.collection("users")
//                .document(resultUser.uid)
//                .setData([
//                    "username": username,
//                    "email": email
//                ]) { error in
//                    if let error = error {
//                        completion(false, error)
//                        return
//                    }
//                    
//                    completion(true, nil)
//                }
//        }
//    }
//    
//    public func signIn(with userRequest: LoginUserRequest, completion: @escaping (Error?)->Void) {
//        Auth.auth().signIn(
//            withEmail: userRequest.email,
//            password: userRequest.password
//        ) { result, error in
//            if let error = error {
//                completion(error)
//                return
//            } else {
//                completion(nil)
//            }
//        }
//    }
//    
//    public func signOut(completion: @escaping (Error?)->Void) {
//        do {
//            try Auth.auth().signOut()
//            completion(nil)
//        } catch let error {
//            completion(error)
//        }
//    }
//    
//    public func forgotPassword(with email: String, completion: @escaping (Error?) -> Void) {
//        Auth.auth().sendPasswordReset(withEmail: email) { error in
//            completion(error)
//        }
//    }
//    
//    public func fetchUser(completion: @escaping (User?, Error?) -> Void) {
//        guard let userUID = Auth.auth().currentUser?.uid else { return }
//        
//        let db = Firestore.firestore()
//        
//        db.collection("users")
//            .document(userUID)
//            .getDocument { snapshot, error in
//                if let error = error {
//                    completion(nil, error)
//                    return
//                }
//                
//                if let snapshot = snapshot,
//                   let snapshotData = snapshot.data(),
//                   let username = snapshotData["username"] as? String,
//                   let email = snapshotData["email"] as? String {
//                    let user = User(username: username, email: email, userUID: userUID)
//                    completion(user, nil)
//                }
//                
//            }
//    }
//}

import Foundation
import FirebaseAuth
import FirebaseFirestore
import FirebaseStorage // Import Firebase Storage to use `Storage`

class AuthService {
    
    public static let shared = AuthService()
    private init() {}
    
    // Registers a user with Firebase Authentication and stores their data in Firestore.
    public func registerUser(with userRequest: RegiserUserRequest, completion: @escaping (Bool, Error?) -> Void) {
        let username = userRequest.username
        let email = userRequest.email
        let password = userRequest.password
        
        Auth.auth().createUser(withEmail: email, password: password) { result, error in
            if let error = error {
                completion(false, error)
                return
            }
            
            guard let resultUser = result?.user else {
                completion(false, nil)
                return
            }
            
            let db = Firestore.firestore()
            db.collection("users")
                .document(resultUser.uid)
                .setData([
                    "username": username,
                    "email": email,
                    "profileImageUrl": ""  // Initialize with an empty string for profile image URL
                ]) { error in
                    if let error = error {
                        completion(false, error)
                        return
                    }
                    completion(true, nil)
                }
        }
    }
    
    // Signs in a user with Firebase Authentication.
    public func signIn(with userRequest: LoginUserRequest, completion: @escaping (Error?) -> Void) {
        Auth.auth().signIn(withEmail: userRequest.email, password: userRequest.password) { result, error in
            if let error = error {
                completion(error)
                return
            }
            completion(nil)
        }
    }

    // Saves profile image to Firebase Storage and updates Firestore with the image URL.
    public func saveProfileImage(image: UIImage, userUID: String, completion: @escaping (String?, Error?) -> Void) {
        guard let imageData = image.jpegData(compressionQuality: 0.8) else {
            completion(nil, NSError(domain: "ImageConversionError", code: -1, userInfo: [NSLocalizedDescriptionKey: "Unable to convert image to data"]))
            return
        }
        let storageRef = Storage.storage().reference().child("profile_images/\(userUID)/profile.jpg")
        
        storageRef.putData(imageData, metadata: nil) { metadata, error in
            if let error = error {
                print("Error uploading image: \(error.localizedDescription)")
                completion(nil, error)
                return
            }
            
            storageRef.downloadURL { url, error in
                if let error = error {
                    print("Error getting download URL: \(error.localizedDescription)")
                    completion(nil, error)
                    return
                }
                
                if let url = url {
                    let urlString = url.absoluteString
                    // Save the profile image URL to Firestore
                    self.updateUserProfileData(userUID: userUID, username: "", profileImageUrl: urlString) { error in
                        if let error = error {
                            print("Error saving profile image URL: \(error.localizedDescription)")
                            completion(nil, error)
                        } else {
                            print("Profile image URL saved successfully.")
                            completion(urlString, nil)
                        }
                    }
                }
            }
        }
    }

    // Signs out the current user.
    public func signOut(completion: @escaping (Error?) -> Void) {
        do {
            try Auth.auth().signOut()
            completion(nil)
        } catch let error {
            completion(error)
        }
    }
    
    // Sends a password reset email to the user.
    public func forgotPassword(with email: String, completion: @escaping (Error?) -> Void) {
        Auth.auth().sendPasswordReset(withEmail: email) { error in
            completion(error)
        }
    }
    
    // Fetches the current user's data from Firestore.
    public func fetchUser(completion: @escaping (User?, Error?) -> Void) {
        guard let userUID = Auth.auth().currentUser?.uid else {
            completion(nil, NSError(domain: "AuthError", code: -1, userInfo: [NSLocalizedDescriptionKey: "User not authenticated"]))
            return
        }
        
        let db = Firestore.firestore()
        db.collection("users")
            .document(userUID)
            .getDocument { snapshot, error in
                if let error = error {
                    completion(nil, error)
                    return
                }
                
                if let snapshot = snapshot,
                   let snapshotData = snapshot.data(),
                   let username = snapshotData["username"] as? String,
                   let email = snapshotData["email"] as? String,
                   let profileImageUrl = snapshotData["profileImageUrl"] as? String {  // Fetch profileImageUrl
                    let user = User(username: username, email: email, userUID: userUID, profileImageUrl: profileImageUrl)
                    completion(user, nil)
                } else {
                    print("No data found for user in Firestore.")
                    completion(nil, nil)
                }
            }
    }
    
    // Updates the current user's profile data in Firestore.
    public func updateUserProfileData(userUID: String, username: String?, profileImageUrl: String?, completion: @escaping (Error?) -> Void) {
        let db = Firestore.firestore()
        var data: [String: Any] = [:]
        
        if let username = username, !username.isEmpty {
            data["username"] = username
        }
        
        if let imageUrl = profileImageUrl {
            data["profileImageUrl"] = imageUrl
        }
        
        db.collection("users").document(userUID).updateData(data) { error in
            if let error = error {
                print("Error updating user data in Firestore: \(error.localizedDescription)")
                completion(error)
                return
            }
            print("User data updated successfully in Firestore.")
            completion(nil)
        }
    }
}
