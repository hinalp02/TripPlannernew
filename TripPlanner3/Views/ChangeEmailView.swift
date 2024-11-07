//
//  ChangeEmailView.swift
//  TripPlanner3
//
//  Created by stlp on 9/14/24.
//
//import SwiftUI
//import FirebaseAuth
//import FirebaseFirestore
//
//struct ChangeEmailView: View {
//    @Environment(\.presentationMode) var presentationMode
//    @State private var currentPassword: String = ""
//    @State private var newEmail: String = ""
//    @State private var errorMessage: String?
//    @State private var successMessage: String?
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
//            if let successMessage = successMessage {
//                Text(successMessage)
//                    .foregroundColor(.green)
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
//        let db = Firestore.firestore()
//        guard let userID = Auth.auth().currentUser?.uid,
//              let userEmail = Auth.auth().currentUser?.email?.lowercased(),
//              let currentUser = Auth.auth().currentUser else {
//            self.errorMessage = "Unable to get user information."
//            return
//        }
//
//        let newEmail = self.newEmail.trimmingCharacters(in: .whitespacesAndNewlines).lowercased()
//        let currentPassword = self.currentPassword.trimmingCharacters(in: .whitespacesAndNewlines)
//
//        guard !newEmail.isEmpty, !currentPassword.isEmpty else {
//            self.errorMessage = "Please fill in all fields."
//            return
//        }
//
//        if newEmail != userEmail {
//            let credential = EmailAuthProvider.credential(withEmail: userEmail, password: currentPassword)
//
//            currentUser.reauthenticate(with: credential) { result, error in
//                if let error = error {
//                    if let authError = AuthErrorCode(rawValue: error._code) {
//                        switch authError {
//                        case .wrongPassword:
//                            self.errorMessage = "Incorrect password. Please try again."
//                        case .invalidCredential:
//                            self.errorMessage = "The provided credentials are invalid. Please check your password."
//                        case .userNotFound:
//                            self.errorMessage = "User not found. Please check your email."
//                        default:
//                            self.errorMessage = "Re-authentication failed: \(error.localizedDescription)"
//                        }
//                    }
//                    return
//                }
//
//                // Send verification email before updating the email
//                currentUser.sendEmailVerification(beforeUpdatingEmail: newEmail) { error in
//                    if let error = error {
//                        self.errorMessage = "Failed to send verification email: \(error.localizedDescription)"
//                    } else {
//                        // Use setData with merge to ensure document is created or updated
//                        db.collection("users").document(userID).setData([
//                            "UserEmail": newEmail
//                        ], merge: true) { err in
//                            if let err = err {
//                                self.errorMessage = "Failed to update Firestore: \(err.localizedDescription)"
//                            } else {
//                                self.successMessage = "A verification email has been sent to your new address. Please verify to complete the update."
//                                self.errorMessage = nil
//                            }
//                        }
//                    }
//                }
//            }
//        } else {
//            self.errorMessage = "New email is the same as the current email."
//        }
//    }
//}

//import SwiftUI
//import FirebaseAuth
//import FirebaseFirestore
//
//struct ChangeEmailView: View {
//    @Environment(\.presentationMode) var presentationMode
//    @State private var currentPassword: String = ""
//    @State private var newEmail: String = ""
//    @State private var errorMessage: String?
//    @State private var successMessage: String?
//
//    var body: some View {
//        VStack(spacing: 20) {
//            Text("Change Email")
//                .font(.largeTitle)
//                .padding()
//
//            SecureField("Current Password", text: $currentPassword)
//                .textFieldStyle(CustomTextFieldStyle()) // Use the custom style
//
//            TextField("New Email", text: $newEmail)
//                .keyboardType(.emailAddress)
//                .textFieldStyle(CustomTextFieldStyle()) // Use the custom style
//
//            if let errorMessage = errorMessage {
//                Text(errorMessage)
//                    .foregroundColor(.red)
//                    .padding()
//            }
//           
//            if let successMessage = successMessage {
//                Text(successMessage)
//                    .foregroundColor(.green)
//                    .padding()
//            }
//
//            Button(action: updateEmail) {
//                Text("Update Email")
//            }
//            .buttonStyle(SelectableButtonStyle()) // Apply the teal style for consistency
//            .padding()
//
//            Spacer()
//        }
//        .padding(.top)
//        .background(Color(.systemGroupedBackground))
//        .navigationBarTitleDisplayMode(.inline)
//    }
//
//    private func updateEmail() {
//        let db = Firestore.firestore()
//        guard let userID = Auth.auth().currentUser?.uid,
//              let userEmail = Auth.auth().currentUser?.email?.lowercased(),
//              let currentUser = Auth.auth().currentUser else {
//            self.errorMessage = "Unable to get user information."
//            return
//        }
//
//        let newEmail = self.newEmail.trimmingCharacters(in: .whitespacesAndNewlines).lowercased()
//        let currentPassword = self.currentPassword.trimmingCharacters(in: .whitespacesAndNewlines)
//
//        guard !newEmail.isEmpty, !currentPassword.isEmpty else {
//            self.errorMessage = "Please fill in all fields."
//            return
//        }
//
//        if newEmail != userEmail {
//            // First, check if the new email is already associated with another account
//            db.collection("users").whereField("UserEmail", isEqualTo: newEmail).getDocuments { (querySnapshot, error) in
//                if let error = error {
//                    // Check if it's a permissions error and set a custom error message
//                    if let firestoreError = error as NSError?,
//                       firestoreError.domain == "FIRFirestoreErrorDomain",
//                       firestoreError.code == FirestoreErrorCode.permissionDenied.rawValue {
//                        self.errorMessage = "This email is already associated with an existing account."
//                    } else {
//                        self.errorMessage = "Error checking email: \(error.localizedDescription)"
//                    }
//                    return
//                }
//
//                if let documents = querySnapshot?.documents, !documents.isEmpty {
//                    // Email is already in use
//                    self.errorMessage = "This email is already associated with an existing account."
//                    return
//                }
//
//                // Proceed with re-authentication if the email is not in use
//                let credential = EmailAuthProvider.credential(withEmail: userEmail, password: currentPassword)
//
//                currentUser.reauthenticate(with: credential) { result, error in
//                    if let error = error {
//                        if let authError = AuthErrorCode(rawValue: error._code) {
//                            switch authError {
//                            case .wrongPassword:
//                                self.errorMessage = "Incorrect password. Please try again."
//                            case .invalidCredential:
//                                self.errorMessage = "The provided credentials are invalid. Please check your password."
//                            case .userNotFound:
//                                self.errorMessage = "User not found. Please check your email."
//                            default:
//                                self.errorMessage = "Re-authentication failed: \(error.localizedDescription)"
//                            }
//                        }
//                        return
//                    }
//
//                    // Send verification email before updating the email
//                    currentUser.sendEmailVerification(beforeUpdatingEmail: newEmail) { error in
//                        if let error = error {
//                            self.errorMessage = "Failed to send verification email: \(error.localizedDescription)"
//                        } else {
//                            // Update the Firestore database with the new email
//                            db.collection("users").document(userID).setData([
//                                "UserEmail": newEmail
//                            ], merge: true) { err in
//                                if let err = err {
//                                    self.errorMessage = "Failed to update Firestore: \(err.localizedDescription)"
//                                } else {
//                                    self.successMessage = "A verification email has been sent to your new address. Please verify to complete the update."
//                                    self.errorMessage = nil
//                                }
//                            }
//                        }
//                    }
//                }
//            }
//        } else {
//            self.errorMessage = "New email is the same as the current email."
//        }
//    }
//}
//


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
        VStack(spacing: 15) { // Set a fixed spacing between elements
            Text("Change Email")
                .font(.largeTitle)
                .padding()

            SecureField("Current Password", text: $currentPassword)
                .textFieldStyle(CustomTextFieldStyle()) // Use the custom style

            TextField("New Email", text: $newEmail)
                .keyboardType(.emailAddress)
                .textFieldStyle(CustomTextFieldStyle()) // Use the custom style

            // Conditional spacing for alert messages
            if let errorMessage = errorMessage {
                Text(errorMessage)
                    .foregroundColor(.red)
                    .padding(.vertical, 5) // Equal padding above and below
                    .multilineTextAlignment(.center) // Center align for a cleaner look
            } else if let successMessage = successMessage {
                Text(successMessage)
                    .foregroundColor(.green)
                    .padding(.vertical, 5) // Equal padding above and below
                    .multilineTextAlignment(.center)
            }

            Button(action: updateEmail) {
                Text("Update Email")
            }
            .buttonStyle(SelectableButtonStyle()) // Apply the teal style for consistency
            .padding(.top, 5) // Small top padding to ensure equal spacing

            Spacer()
        }
        .padding(.top)
        .background(Color(.systemGroupedBackground))
        .navigationBarTitleDisplayMode(.inline)
    }

    private func updateEmail() {
        let db = Firestore.firestore()
        guard let userID = Auth.auth().currentUser?.uid,
              let userEmail = Auth.auth().currentUser?.email?.lowercased(),
              let currentUser = Auth.auth().currentUser else {
            self.errorMessage = "Unable to get user information."
            return
        }

        let newEmail = self.newEmail.trimmingCharacters(in: .whitespacesAndNewlines).lowercased()
        let currentPassword = self.currentPassword.trimmingCharacters(in: .whitespacesAndNewlines)

        guard !newEmail.isEmpty, !currentPassword.isEmpty else {
            self.errorMessage = "Please fill in all fields."
            return
        }

        if newEmail != userEmail {
            // First, check if the new email is already associated with another account
            db.collection("users").whereField("UserEmail", isEqualTo: newEmail).getDocuments { (querySnapshot, error) in
                if let error = error {
                    // Check if it's a permissions error and set a custom error message
                    if let firestoreError = error as NSError?,
                       firestoreError.domain == "FIRFirestoreErrorDomain",
                       firestoreError.code == FirestoreErrorCode.permissionDenied.rawValue {
                        self.errorMessage = "This email is already associated with an existing account."
                    } else {
                        self.errorMessage = "Error checking email: \(error.localizedDescription)"
                    }
                    return
                }

                if let documents = querySnapshot?.documents, !documents.isEmpty {
                    // Email is already in use
                    self.errorMessage = "This email is already associated with an existing account."
                    return
                }

                // Proceed with re-authentication if the email is not in use
                let credential = EmailAuthProvider.credential(withEmail: userEmail, password: currentPassword)

                currentUser.reauthenticate(with: credential) { result, error in
                    if let error = error {
                        if let authError = AuthErrorCode(rawValue: error._code) {
                            switch authError {
                            case .wrongPassword:
                                self.errorMessage = "Incorrect password. Please try again."
                            case .invalidCredential:
                                self.errorMessage = "The provided credentials are invalid. Please check your password."
                            case .userNotFound:
                                self.errorMessage = "User not found. Please check your email."
                            default:
                                self.errorMessage = "Re-authentication failed: \(error.localizedDescription)"
                            }
                        }
                        return
                    }

                    // Send verification email before updating the email
                    currentUser.sendEmailVerification(beforeUpdatingEmail: newEmail) { error in
                        if let error = error {
                            self.errorMessage = "Failed to send verification email: \(error.localizedDescription)"
                        } else {
                            // Update the Firestore database with the new email
                            db.collection("users").document(userID).setData([
                                "UserEmail": newEmail
                            ], merge: true) { err in
                                if let err = err {
                                    self.errorMessage = "Failed to update Firestore: \(err.localizedDescription)"
                                } else {
                                    self.successMessage = "A verification email has been sent to your new address. Please verify to complete the update."
                                    self.errorMessage = nil
                                }
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
