////
////  ChangeEmailView.swift
////  TripPlanner3
////
////  Created by stlp on 9/14/24.
////
//import SwiftUI
//import FirebaseAuth
//
//struct ChangeEmailView: View {
//    @Environment(\.presentationMode) var presentationMode
//    @State private var currentPassword: String = ""
//    @State private var newEmail: String = ""
//    @State private var errorMessage: String?
//
//    var body: some View {
//        VStack(spacing: 20) {
//            Text("Change Email")
//                .font(.largeTitle)
//                .padding()
//
//            SecureField("Current Password", text: $currentPassword)
//                .textFieldStyle(RoundedBorderTextFieldStyle())
//                .padding(.horizontal)
//
//            TextField("New Email", text: $newEmail)
//                .keyboardType(.emailAddress)
//                .textFieldStyle(RoundedBorderTextFieldStyle())
//                .padding(.horizontal)
//
//            if let errorMessage = errorMessage {
//                Text(errorMessage)
//                    .foregroundColor(.red)
//                    .padding()
//            }
//
//            Button(action: changeEmail) {
//                Text("Update Email")
//                    .font(.headline)
//                    .padding()
//                    .frame(maxWidth: .infinity)
//                    .background(Color.blue)
//                    .foregroundColor(.white)
//                    .cornerRadius(10)
//            }
//            .padding()
//
//            Spacer()
//        }
//        .padding(.top)  // To provide padding from top without back button
//        .background(Color(.systemGroupedBackground))
//        .navigationTitle("Change Email")  // Use the default navigation title
//        .navigationBarTitleDisplayMode(.inline)  // Ensure the title is inline for consistency
//    }
//
//    private func changeEmail() {
//        guard let user = Auth.auth().currentUser else {
//            errorMessage = "User not authenticated."
//            print("User not authenticated.")
//            return
//        }
//        
//        guard !newEmail.isEmpty else {
//            errorMessage = "New email cannot be empty."
//            print("New email is empty.")
//            return
//        }
//        
//        // Re-authenticate the user with the current password
//        let credential = EmailAuthProvider.credential(withEmail: user.email ?? "", password: currentPassword)
//        user.reauthenticate(with: credential) { result, error in
//            if let error = error {
//                errorMessage = "Error: \(error.localizedDescription)"
//                print("Re-authentication failed: \(error.localizedDescription)")
//                return
//            }
//            
//            print("Re-authentication successful.")
//            
//            // Update to new email
//            user.updateEmail(to: newEmail) { error in
//                if let error = error {
//                    errorMessage = "Error: \(error.localizedDescription)"
//                    print("Error updating email: \(error.localizedDescription)")
//                } else {
//                    print("Email updated to \(newEmail)")
//                    // Send verification email
//                    user.sendEmailVerification { error in
//                        if let error = error {
//                            errorMessage = "Error sending verification email: \(error.localizedDescription)"
//                            print("Error sending verification email: \(error.localizedDescription)")
//                        } else {
//                            errorMessage = "Email updated successfully! A verification link has been sent to \(newEmail). Please verify it."
//                            print("Verification email sent successfully.")
//                        }
//                    }
//                }
//            }
//        }
//    }
//}



//import SwiftUI
//import FirebaseAuth
//struct ChangeEmailView: View {
//    @Environment(\.presentationMode) var presentationMode
//    @State private var currentPassword: String = ""
//    @State private var newEmail: String = ""
//    @State private var errorMessage: String?
//
//    var userUID: String  // This should match the argument passed from SettingsView
//
//    var body: some View {
//        VStack(spacing: 20) {
//            Text("Change Email")
//                .font(.largeTitle)
//                .padding()
//
//            SecureField("Current Password", text: $currentPassword)
//                .textFieldStyle(RoundedBorderTextFieldStyle())
//                .padding(.horizontal)
//
//            TextField("New Email", text: $newEmail)
//                .keyboardType(.emailAddress)
//                .textFieldStyle(RoundedBorderTextFieldStyle())
//                .padding(.horizontal)
//
//            if let errorMessage = errorMessage {
//                Text(errorMessage)
//                    .foregroundColor(.red)
//                    .padding()
//            }
//
//            Button(action: updateEmail) {
//                Text("Update Email")
//                    .font(.headline)
//                    .padding()
//                    .frame(maxWidth: .infinity)
//                    .background(Color.blue)
//                    .foregroundColor(.white)
//                    .cornerRadius(10)
//            }
//            .padding()
//
//            Spacer()
//        }
//        .padding(.top)
//        .background(Color(.systemGroupedBackground))
//        .navigationTitle("Change Email")
//        .navigationBarTitleDisplayMode(.inline)
//    }
//
//    private func updateEmail() {
//        guard !newEmail.isEmpty else {
//            errorMessage = "New email cannot be empty."
//            return
//        }
//
//        // Prepare the URL and request
////        let url = URL(string: "http://localhost:3000/update-email")!
//        
//        //run this commnd on your terminal
//        //cd ~/Desktop/TripPlanner4/firebase-admin-sdk-project
//       // node server.js
//
//        //for running on your computer
//        let url = URL(string: "http://10.19.41.72:3000/update-email")!
//        
//        //for running on iphone
//       // let url = URL(string: "http://10.19.41.72:3000/update-email")!
//
//        var request = URLRequest(url: url)
//        request.httpMethod = "POST"
//        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
//
//        // Create the JSON payload
//        let jsonPayload = [
//            "uid": userUID,  // Pass the actual UID here
//            "newEmail": newEmail
//        ]
//
//        // Convert to JSON data
//        guard let jsonData = try? JSONSerialization.data(withJSONObject: jsonPayload) else {
//            errorMessage = "Failed to create JSON payload"
//            return
//        }
//
//        // Send the request
//        URLSession.shared.uploadTask(with: request, from: jsonData) { data, response, error in
//            if let error = error {
//                DispatchQueue.main.async {
//                    errorMessage = "Error: \(error.localizedDescription)"
//                }
//                return
//            }
//
//            // Handle the response
//            if let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 {
//                DispatchQueue.main.async {
//                    errorMessage = "Email updated successfully!"
//                }
//            } else {
//                DispatchQueue.main.async {
//                    errorMessage = "Failed to update email"
//                }
//            }
//        }.resume()
//    }
//}


//import SwiftUI
//import FirebaseAuth
//
//struct ChangeEmailView: View {
//    @Environment(\.presentationMode) var presentationMode
//    @State private var currentPassword: String = ""
//    @State private var newEmail: String = ""
//    @State private var errorMessage: String?
//
//    var userUID: String  // This should match the argument passed from SettingsView
//
//    var body: some View {
//        VStack(spacing: 20) {
//            Text("Change Email")
//                .font(.largeTitle)
//                .padding()
//
//            SecureField("Current Password", text: $currentPassword)
//                .textFieldStyle(RoundedBorderTextFieldStyle())
//                .padding(.horizontal)
//
//            TextField("New Email", text: $newEmail)
//                .keyboardType(.emailAddress)
//                .textFieldStyle(RoundedBorderTextFieldStyle())
//                .padding(.horizontal)
//
//            if let errorMessage = errorMessage {
//                Text(errorMessage)
//                    .foregroundColor(.red)
//                    .padding()
//            }
//
//            Button(action: updateEmail) {
//                Text("Update Email")
//                    .font(.headline)
//                    .padding()
//                    .frame(maxWidth: .infinity)
//                    .background(Color.blue)
//                    .foregroundColor(.white)
//                    .cornerRadius(10)
//            }
//            .padding()
//
//            Spacer()
//        }
//        .padding(.top)
//        .background(Color(.systemGroupedBackground))
//        .navigationTitle("Change Email")
//        .navigationBarTitleDisplayMode(.inline)
//    }
//
//    private func updateEmail() {
//        guard !newEmail.isEmpty else {
//            errorMessage = "New email cannot be empty."
//            return
//        }
//
//        // Use the Render deployment URL here
//        let url = URL(string: "https://your-app-name.onrender.com/update-email")!
//
//        var request = URLRequest(url: url)
//        request.httpMethod = "POST"
//        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
//
//        // Create the JSON payload
//        let jsonPayload = [
//            "uid": userUID,  // Pass the actual UID here
//            "newEmail": newEmail
//        ]
//
//        // Convert to JSON data
//        guard let jsonData = try? JSONSerialization.data(withJSONObject: jsonPayload) else {
//            errorMessage = "Failed to create JSON payload"
//            return
//        }
//
//        // Send the request
//        URLSession.shared.uploadTask(with: request, from: jsonData) { data, response, error in
//            if let error = error {
//                DispatchQueue.main.async {
//                    errorMessage = "Error: \(error.localizedDescription)"
//                }
//                return
//            }
//
//            // Handle the response
//            if let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 {
//                DispatchQueue.main.async {
//                    errorMessage = "Email updated successfully!"
//                }
//            } else {
//                DispatchQueue.main.async {
//                    errorMessage = "Failed to update email"
//                }
//            }
//        }.resume()
//    }
//}


import SwiftUI
import FirebaseAuth
import FirebaseFirestore

struct ChangeEmailView: View {
    @Environment(\.presentationMode) var presentationMode
    @State private var currentPassword: String = ""
    @State private var newEmail: String = ""
    @State private var errorMessage: String?
    @State private var successMessage: String?

    var body: some View {
        VStack(spacing: 20) {
            Text("Change Email")
                .font(.largeTitle)
                .padding()

            SecureField("Current Password", text: $currentPassword)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding(.horizontal)

            TextField("New Email", text: $newEmail)
                .keyboardType(.emailAddress)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding(.horizontal)

            if let errorMessage = errorMessage {
                Text(errorMessage)
                    .foregroundColor(.red)
                    .padding()
            }
            
            if let successMessage = successMessage {
                Text(successMessage)
                    .foregroundColor(.green)
                    .padding()
            }

            Button(action: updateEmail) {
                Text("Update Email")
                    .font(.headline)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }
            .padding()

            Spacer()
        }
        .padding(.top)
        .background(Color(.systemGroupedBackground))
        .navigationTitle("Change Email")
        .navigationBarTitleDisplayMode(.inline)
    }

    private func updateEmail() {
        let db = Firestore.firestore()
        guard let userID = Auth.auth().currentUser?.uid,
              let userEmail = Auth.auth().currentUser?.email?.lowercased(), // Unwrap and lowercase
              let currentUser = Auth.auth().currentUser else {
            self.errorMessage = "Unable to get user information."
            return
        }

        // Trim and lowercase the new email for consistency
        let newEmail = self.newEmail.trimmingCharacters(in: .whitespacesAndNewlines).lowercased()
        let currentPassword = self.currentPassword.trimmingCharacters(in: .whitespacesAndNewlines)

        guard !newEmail.isEmpty, !currentPassword.isEmpty else {
            self.errorMessage = "Please fill in all fields."
            return
        }

        // Update Firestore if the new email is different from the current one
        if newEmail != userEmail {
            let credential = EmailAuthProvider.credential(withEmail: userEmail, password: currentPassword)

            // Re-authenticate the user
            currentUser.reauthenticate(with: credential) { result, error in
                if let error = error {
                    self.errorMessage = "Re-authentication failed: \(error.localizedDescription)"
                    return
                }

                // Proceed to update the email
                currentUser.updateEmail(to: newEmail) { error in
                    if let error = error {
                        self.errorMessage = "Failed to update email: \(error.localizedDescription)"
                    } else {
                        // Update Firestore document with the new email
                        db.collection("Users").document(userID).updateData([
                            "UserEmail": newEmail
                        ]) { err in
                            if let err = err {
                                self.errorMessage = "Failed to update Firestore: \(err.localizedDescription)"
                            } else {
                                self.successMessage = "Email updated successfully!"
                                self.errorMessage = nil
                            }
                        }
                    }
                }
            }
        } else {
            self.errorMessage = "New email is the same as the current email."
        }
    }

}
