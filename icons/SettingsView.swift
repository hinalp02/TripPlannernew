import SwiftUI
import FirebaseAuth
import FirebaseFirestore
import FirebaseStorage
import Combine

struct SettingsView: View {
    @State private var username: String = ""
    @State private var profileImage: UIImage? = nil
    @State private var isEditing: Bool = false
    @State private var showingImagePicker = false
    @State private var loading: Bool = true
    @State private var showRemovePictureAlert = false
    @State private var isPictureHighlighted = false
    @FocusState private var isNameFocused: Bool
    @State private var selectedButton: String? = nil
    @State private var isEditProfilePressed = false
    @State private var isChangePasswordPressed = false
    @State private var isChangeEmailPressed = false
    @State private var isLogoutPressed = false
    @State private var isSaveChangesPressed = false
    @FocusState private var isNameFieldFocused: Bool
    @State private var isPressed: Bool = false

    let userUID: String

    let gradientStartColor = Color(UIColor(red: 141/255, green: 172/255, blue: 225/255, alpha: 1))
    let gradientEndColor = Color(UIColor(red: 41/255, green: 102/255, blue: 117/255, alpha: 1))
    let borderColor = Color(UIColor(red: 41/255, green: 102/255, blue: 117/255, alpha: 1))
    let textBoxBackgroundColor = Color(UIColor(white: 1, alpha: 0.85))

    var body: some View {
        NavigationView {
            ZStack {
                Color.white.edgesIgnoringSafeArea(.all)
               
                VStack(spacing: 0) {
                    ZStack(alignment: .top) {
                        RoundedRectangle(cornerRadius: UIScreen.main.bounds.width * 0.08, style: .continuous)
                            .fill(
                                LinearGradient(
                                    gradient: Gradient(colors: [gradientStartColor, gradientEndColor]),
                                    startPoint: .top,
                                    endPoint: .bottom
                                )
                            )
                            .frame(height: UIScreen.main.bounds.height * 0.4)
                            .padding(.top, -UIScreen.main.bounds.height * 0.05)
                            .padding(.bottom, UIScreen.main.bounds.height * 0.02)
                            .edgesIgnoringSafeArea(.top)
                       
                        VStack(spacing: UIScreen.main.bounds.height * 0.01) {
                            Spacer().frame(height: UIScreen.main.bounds.height * 0.02)

                            if isEditing {
                                HStack {
                                    TextField("Name", text: $username)
                                        .font(.system(size: UIScreen.main.bounds.width * 0.045))
                                        .padding(.horizontal, UIScreen.main.bounds.width * 0.04)
                                        .padding(.vertical, UIScreen.main.bounds.height * 0.01)
                                        .foregroundColor(.black)
                                        .background(Color(UIColor(red: 230/255, green: 240/255, blue: 250/255, alpha: 1)))
                                        .cornerRadius(UIScreen.main.bounds.width * 0.02)
                                        .focused($isNameFieldFocused)
                                        .onAppear {
                                            isNameFieldFocused = true
                                        }
                                        .multilineTextAlignment(.center)
                                        .fixedSize(horizontal: true, vertical: false)
                                        .textInputAutocapitalization(.never)
                                        .autocorrectionDisabled(true)
                                        .keyboardType(.default)
                                        .focused($isNameFocused)
                                    Image(systemName: "pencil.circle.fill")
                                        .foregroundColor(.gray)
                                        .font(.system(size: UIScreen.main.bounds.width * 0.05))
                                        .padding(.trailing, UIScreen.main.bounds.width * 0.03)
                                        .onTapGesture {
                                            isNameFocused = true
                                            isNameFieldFocused = true
                                        }
                                }
                                .background(Color(UIColor(red: 230/255, green: 240/255, blue: 250/255, alpha: 1)))
                                .cornerRadius(UIScreen.main.bounds.width * 0.02)
                                .overlay(RoundedRectangle(cornerRadius: UIScreen.main.bounds.width * 0.02)
                                    .stroke(borderColor, lineWidth: 2))
                                .padding(.bottom, UIScreen.main.bounds.height * 0.02)
                            } else {
                                Text(username.isEmpty ? "Guest" : username)
                                    .font(.system(size: UIScreen.main.bounds.width * 0.07, weight: .bold))
                                    .foregroundColor(.white)
                                    .onTapGesture {
                                        isEditing = true
                                        isNameFieldFocused = true
                                    }
                                    .padding(.top, -UIScreen.main.bounds.height * 0.04)
                            }

                            ZStack {
                                if let image = profileImage {
                                    Image(uiImage: image)
                                        .resizable()
                                        .aspectRatio(contentMode: .fill)
                                        .frame(width: UIScreen.main.bounds.width * 0.25,
                                               height: UIScreen.main.bounds.width * 0.25)
                                        .clipShape(Circle())
                                        .overlay(Circle().stroke(isPictureHighlighted ? Color(red: 96/255, green: 131/255, blue: 153/255) : Color.white, lineWidth: UIScreen.main.bounds.width * 0.008))
                                        .onTapGesture {
                                            isPictureHighlighted.toggle()
                                            showingImagePicker = true
                                        }
                                        .offset(y: isEditing ? -UIScreen.main.bounds.height * 0.02 : 0)
                                        .padding(.top, UIScreen.main.bounds.height * 0.0005)
                                   
                                    if isEditing {
                                        Image(systemName: "pencil.circle.fill")
                                            .foregroundColor(.white)
                                            .font(.system(size: UIScreen.main.bounds.width * 0.07))
                                            .background(Circle().fill(Color.black.opacity(0.6)))
                                            .offset(x: UIScreen.main.bounds.width * 0.1,
                                                    y: UIScreen.main.bounds.width * 0.1)
                                            .onTapGesture {
                                                showingImagePicker = true
                                            }
                                    }
                                } else {
                                    Text(initials(for: username))
                                        .font(.largeTitle)
                                        .foregroundColor(.white)
                                        .frame(width: UIScreen.main.bounds.width * 0.2, height: UIScreen.main.bounds.width * 0.2)
                                        .background(Circle().fill(Color.gray))
                                        .overlay(Circle().stroke(isPictureHighlighted ? Color(red: 96/255, green: 131/255, blue: 153/255) : Color.white, lineWidth: 3))
                                        .onTapGesture {
                                            isPictureHighlighted.toggle()
                                            showingImagePicker = true
                                        }
                                   
                                    if isEditing {
                                        Image(systemName: "pencil.circle.fill")
                                            .foregroundColor(.white)
                                            .font(.system(size: UIScreen.main.bounds.width * 0.06))
                                            .background(Circle().fill(Color.black.opacity(0.6)))
                                            .offset(x: UIScreen.main.bounds.width * 0.075, y: UIScreen.main.bounds.width * 0.075)
                                            .onTapGesture {
                                                showingImagePicker = true
                                            }
                                    }
                                }
                            }

                            if isEditing {
                                Button(action: {
                                    showRemovePictureAlert = true
                                    profileImage = nil
                                }) {
                                    Text("Remove Profile Picture")
                                }
                                .buttonStyle(PressableButtonStyle())
                                .padding(.top, UIScreen.main.bounds.height * 0.1)
                                .padding(.bottom, UIScreen.main.bounds.height * 0.01)
                            }

                        }
                        .offset(y: -10)
                    }
                   
                    ScrollView {
                        VStack(alignment: .center, spacing: UIScreen.main.bounds.width * 0.05) {
                            if isEditing {
                                Button(action: saveProfileChanges) {
                                    Text("Save Changes")
                                }
                                .buttonStyle(PressableButtonStyle())
                                .onLongPressGesture(minimumDuration: 0.1, pressing: { isPressing in
                                    isSaveChangesPressed = isPressing
                                }) {
                                    saveProfileChanges()
                                }
                                .padding(.horizontal, UIScreen.main.bounds.width * 0.05)
                                .onTapGesture {
                                    isEditing = false
                                    isNameFocused = true
                                }
                            } else {
                                Button(action: {
                                    isEditing.toggle()
                                    isNameFocused = isEditing
                                    selectedButton = "Edit Profile"
                                    isNameFieldFocused = isEditing
                                }) {
                                    Text("Edit Profile")
                                }
                                .modifier(CustomButtonStyle(isSelected: isEditProfilePressed))
                                .onLongPressGesture(minimumDuration: 0.1, pressing: { isPressing in
                                    isEditProfilePressed = isPressing
                                }) {}
                                .padding(.horizontal, UIScreen.main.bounds.width * 0.05)
                            }

                            NavigationLink(destination: ChangePasswordView()) {
                                Text("Change Password")
                            }
                            .modifier(CustomButtonStyle(isSelected: isChangePasswordPressed))
                            .onLongPressGesture(minimumDuration: 0.1, pressing: { isPressing in
                                isChangePasswordPressed = isPressing
                            }) {}
                            .padding(.horizontal, UIScreen.main.bounds.width * 0.05)

                            NavigationLink(destination: ChangeEmailView()) {
                                Text("Change Email")
                            }
                            .modifier(CustomButtonStyle(isSelected: isChangeEmailPressed))
                            .onLongPressGesture(minimumDuration: 0.1, pressing: { isPressing in
                                isChangeEmailPressed = isPressing
                            }) {}
                            .padding(.horizontal, UIScreen.main.bounds.width * 0.05)

                            Button(action: logout) {
                                Text("Logout")
                            }
                            .modifier(CustomButtonStyle(isSelected: isLogoutPressed))
                            .onLongPressGesture(minimumDuration: 0.1, pressing: { isPressing in
                                isLogoutPressed = isPressing
                            }) {}
                            .padding(.horizontal, UIScreen.main.bounds.width * 0.05)
                        }
                    }
                }
                .ignoresSafeArea(.keyboard, edges: .bottom)
                .alert(isPresented: $showRemovePictureAlert) {
                    Alert(
                        title: Text("Remove Profile Picture"),
                        message: Text("Are you sure you want to remove your profile picture?"),
                        primaryButton: .destructive(Text("Remove")) {
                            profileImage = nil
                            let db = Firestore.firestore()
                            db.collection("users").document(userUID).updateData([
                                "profileImageUrl": FieldValue.delete()
                            ]) { error in
                                if let error = error {
                                    print("Error removing profile image URL: \(error.localizedDescription)")
                                } else {
                                    print("Profile image URL removed successfully.")
                                }
                            }
                        },
                        secondaryButton: .cancel()
                    )
                }
            }
            .navigationViewStyle(StackNavigationViewStyle())
            .sheet(isPresented: $showingImagePicker) {
                ImagePicker(selectedImage: $profileImage)
            }
            .onAppear(perform: loadUserData)
        }
    }

    private func initials(for name: String) -> String {
        let components = name.split(separator: " ")
        let initials = components.compactMap { $0.first }.map { String($0) }.joined()
        return String(initials.prefix(2)).uppercased()
    }

    private func logout() {
        do {
            try Auth.auth().signOut()
            if let window = UIApplication.shared.windows.first {
                let navController = UINavigationController(rootViewController: LoginController())
                window.rootViewController = navController
                window.makeKeyAndVisible()
            }
        } catch {
            print("Error signing out: \(error.localizedDescription)")
        }
    }

    private func saveProfileChanges() {
        guard let userUID = Auth.auth().currentUser?.uid else { return }
        let db = Firestore.firestore()
        db.collection("users").document(userUID).updateData([
            "username": username
        ]) { error in
            if let error = error {
                print("Error saving profile data: \(error.localizedDescription)")
                return
            }
            print("Profile data saved successfully.")
            if let newImage = profileImage {
                uploadProfileImage(newImage)
            } else {
                self.isEditing = false
                loadUserData()
            }
        }
    }

    private func uploadProfileImage(_ image: UIImage) {
        guard let userUID = Auth.auth().currentUser?.uid else { return }
        let storageRef = Storage.storage().reference().child("profile_images/\(userUID)/profile.jpg")
        guard let imageData = image.jpegData(compressionQuality: 0.75) else { return }
        storageRef.putData(imageData, metadata: nil) { metadata, error in
            if let error = error {
                print("Error uploading image: \(error.localizedDescription)")
                return
            }
            storageRef.downloadURL { url, error in
                if let error = error {
                    print("Error getting download URL: \(error.localizedDescription)")
                    return
                }
                if let urlString = url?.absoluteString {
                    self.updateUserProfileImageUrl(urlString)
                    self.isEditing = false
                    loadUserData()
                }
            }
        }
    }

    private func updateUserProfileImageUrl(_ urlString: String) {
        guard let userUID = Auth.auth().currentUser?.uid else { return }
        let db = Firestore.firestore()
        db.collection("users").document(userUID).updateData([
            "profileImageUrl": urlString
        ]) { error in
            if let error = error {
                print("Error updating profile image URL: \(error.localizedDescription)")
                return
            }
            print("Profile image URL updated successfully.")
        }
    }

    private func loadUserData() {
        guard let userUID = Auth.auth().currentUser?.uid else { return }
        let db = Firestore.firestore()
        db.collection("users").document(userUID).getDocument { document, error in
            if let error = error {
                print("Failed to load user data: \(error.localizedDescription)")
                self.loading = false
                return
            }
            if let document = document, document.exists {
                let data = document.data()
                self.username = data?["username"] as? String ?? ""
                self.loading = false
                if let profileImageUrl = data?["profileImageUrl"] as? String, !profileImageUrl.isEmpty {
                    loadProfileImage(from: profileImageUrl)
                } else {
                    self.profileImage = nil
                }
            } else {
                print("User data not found.")
                self.loading = false
            }
        }
    }

    private func loadProfileImage(from urlString: String) {
        guard !urlString.isEmpty, let url = URL(string: urlString) else { return }
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                print("Error loading profile image: \(error.localizedDescription)")
                return
            }
            if let data = data, let uiImage = UIImage(data: data) {
                DispatchQueue.main.async {
                    self.profileImage = uiImage
                }
            }
        }.resume()
    }
}

struct CustomButtonStyle: ViewModifier {
    var isSelected: Bool

    func body(content: Content) -> some View {
        content
            .font(.headline)
            .padding()
            .frame(width: UIScreen.main.bounds.width * 0.8,  height: UIScreen.main.bounds.height * 0.06)
            .background(isSelected ? Color.teal.opacity(0.3) : Color.teal)
            .foregroundColor(isSelected ? .black : .white)
            .cornerRadius(UIScreen.main.bounds.height * 0.02)
    }
}

struct PressableButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .font(.headline)
            .padding()
            .frame(width: UIScreen.main.bounds.width * 0.8, height: UIScreen.main.bounds.height * 0.06)
            .background(configuration.isPressed ? Color(red: 96/255, green: 131/255, blue: 153/255) : Color(red: 200/255, green: 228/255, blue: 250/255))
            .foregroundColor(configuration.isPressed ? .white : .black)
            .cornerRadius(UIScreen.main.bounds.height * 0.02)
    }
}
