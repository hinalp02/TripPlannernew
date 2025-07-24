import SwiftUI
import FirebaseAuth

// Custom TextFieldStyle
struct CustomTextFieldStyle: TextFieldStyle {
    func _body(configuration: TextField<Self._Label>) -> some View {
        configuration
            .padding()
            .background(Color.white.opacity(0.35)) // Semi-transparent background
            .cornerRadius(10)
            .overlay(
                RoundedRectangle(cornerRadius: 10)
                    .stroke(Color.gray.opacity(0.2), lineWidth: 1) // Light border
            )
            .padding(.horizontal)
            .frame(width: UIScreen.main.bounds.width * 0.9) // Dynamic width for all screens
    }
}

// Custom ButtonStyle for teal background with opacity change on press
struct SelectableButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .font(.headline)
            .padding()
            .frame(width: UIScreen.main.bounds.width * 0.8, height: 50) // Dynamic width
            .background(configuration.isPressed ? Color.teal.opacity(0.3) : Color.teal)
            .foregroundColor(.white)
            .cornerRadius(10)
            .scaleEffect(configuration.isPressed ? 0.98 : 1.0) // Optional scaling for feedback
    }
}

// ChangePasswordView with "Update Password" button using SelectableButtonStyle
struct ChangePasswordView: View {
    @Environment(\.presentationMode) var presentationMode
    @State private var currentPassword: String = ""
    @State private var newPassword: String = ""
    @State private var confirmPassword: String = ""
    @State private var errorMessage: String?

    var body: some View {
        ZStack {
            Color(.systemGroupedBackground) // Background color that covers entire screen
                .ignoresSafeArea() // Extends background color to screen edges

            VStack(spacing: 15) { // Set fixed spacing between elements
                Text("Change Password")
                    .font(.largeTitle)
                    .padding()

                SecureField("Current Password", text: $currentPassword)
                    .textFieldStyle(CustomTextFieldStyle())

                SecureField("New Password", text: $newPassword)
                    .textFieldStyle(CustomTextFieldStyle())

                SecureField("Confirm New Password", text: $confirmPassword)
                    .textFieldStyle(CustomTextFieldStyle())

                // Add consistent spacing above and below the error message
                if let errorMessage = errorMessage {
                    Text(errorMessage)
                        .foregroundColor(.red)
                        .padding(.top, 5)  // Equal spacing above error message
                        .padding(.bottom, 5)  // Equal spacing below error message
                        .multilineTextAlignment(.center)
                        .frame(width: UIScreen.main.bounds.width * 0.9) // Dynamic width for alignment
                }

                Button(action: changePassword) {
                    Text("Update Password")
                }
                .buttonStyle(SelectableButtonStyle())  // Apply the teal style here

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

    // Password update logic
    private func changePassword() {
        // Check if any fields are empty
        guard !currentPassword.isEmpty, !newPassword.isEmpty, !confirmPassword.isEmpty else {
            errorMessage = "Please fill in all fields."
            return
        }
       
        // Check if newPassword and confirmPassword match
        guard newPassword == confirmPassword else {
            errorMessage = "New passwords do not match."
            return
        }

        guard let user = Auth.auth().currentUser else {
            errorMessage = "User not authenticated."
            return
        }

        let credential = EmailAuthProvider.credential(withEmail: user.email ?? "", password: currentPassword)
        user.reauthenticate(with: credential) { result, error in
            if let error = error {
                errorMessage = "Error: \(error.localizedDescription)"
                return
            }

            user.updatePassword(to: newPassword) { error in
                if let error = error {
                    errorMessage = "Error: \(error.localizedDescription)"
                } else {
                    errorMessage = "Password updated successfully!"
                }
            }
        }
    }
}

