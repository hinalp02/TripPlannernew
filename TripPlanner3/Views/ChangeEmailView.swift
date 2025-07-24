import SwiftUI
import FirebaseAuth
import FirebaseFirestore

struct ChangeEmailView: View {
    @Environment(\.presentationMode) var presentationMode
    @State private var currentPassword: String = ""
    @State private var newEmail: String = ""
    @State private var errorMessage: String?
    @State private var successMessage: String?

    // Screen dimensions for responsive layout
    let screenWidth = UIScreen.main.bounds.width
    let screenHeight = UIScreen.main.bounds.height

    var body: some View {
        ZStack {
            Color(.systemGroupedBackground) // Set background color to fill entire screen
                .ignoresSafeArea() // Extend background color to edges

            VStack(spacing: 15) { // Set a fixed spacing between elements
                Text("Change Email")
                    .font(.largeTitle)
                    .padding()

                SecureField("Current Password", text: $currentPassword)
                    .textFieldStyle(CustomTextFieldStyle())
                    .frame(width: screenWidth * 0.9) // Dynamic width based on screen size

                TextField("New Email", text: $newEmail)
                    .keyboardType(.emailAddress)
                    .textFieldStyle(CustomTextFieldStyle())
                    .frame(width: screenWidth * 0.9) // Dynamic width based on screen size

                // Conditional spacing for alert messages
                if let errorMessage = errorMessage {
                    Text(errorMessage)
                        .foregroundColor(.red)
                        .padding(.vertical, 5) // Equal padding above and below
                        .multilineTextAlignment(.center) // Center align for a cleaner look
                        .frame(width: screenWidth * 0.9) // Match width with text fields
                } else if let successMessage = successMessage {
                    Text(successMessage)
                        .foregroundColor(.green)
                        .padding(.vertical, 5) // Equal padding above and below
                        .multilineTextAlignment(.center)
                        .frame(width: screenWidth * 0.9) // Match width with text fields
                }

                Button(action: updateEmail) {
                    Text("Update Email")
                        .frame(maxWidth: .infinity, minHeight: 44) // Standard button height
                        .background(Color.teal)
                        .foregroundColor(.white)
                        .cornerRadius(8)
                }
                .buttonStyle(SelectableButtonStyle()) // Apply the teal style for consistency
                .padding(.top, 5) // Small top padding to ensure equal spacing
                .frame(width: screenWidth * 0.6) // Button width adjusted to fit smaller screens

                Spacer()
            }
            .padding(.top)
            .navigationBarTitleDisplayMode(.inline)
            .onAppear {
                let appearance = UINavigationBarAppearance()
                   appearance.configureWithTransparentBackground() // Makes the bar fully transparent
                   appearance.backgroundColor = .systemGroupedBackground // Ensure it blends with your screen
                   appearance.shadowColor = .clear // Removes any shadow (black line)
                   
                appearance.titleTextAttributes = [.foregroundColor: UIColor.black]
                appearance.largeTitleTextAttributes = [.foregroundColor: UIColor.black]

                UINavigationBar.appearance().standardAppearance = appearance
                UINavigationBar.appearance().scrollEdgeAppearance = appearance
                UINavigationBar.appearance().compactAppearance = appearance
                UINavigationBar.appearance().tintColor = .black

                DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                    UINavigationBar.appearance().tintColor = .black
                }
            }
            .onDisappear {
                // Reset back button color to default for other views
                let appearance = UINavigationBarAppearance()
                appearance.configureWithOpaqueBackground()
                appearance.backgroundColor = .clear
                appearance.titleTextAttributes = [.foregroundColor: UIColor.white] // Restore default white
                appearance.largeTitleTextAttributes = [.foregroundColor: UIColor.white]

                UINavigationBar.appearance().standardAppearance = appearance
                UINavigationBar.appearance().scrollEdgeAppearance = appearance
                UINavigationBar.appearance().compactAppearance = appearance
                UINavigationBar.appearance().tintColor = .white // **Reset back button to white**
            }
        }
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
            db.collection("users").whereField("UserEmail", isEqualTo: newEmail).getDocuments { (querySnapshot, error) in
                if let error = error {
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
                    self.errorMessage = "This email is already associated with an existing account."
                    return
                }

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

                    currentUser.sendEmailVerification(beforeUpdatingEmail: newEmail) { error in
                        if let error = error {
                            self.errorMessage = "Failed to send verification email: \(error.localizedDescription)"
                        } else {
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

