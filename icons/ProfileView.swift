////
////import SwiftUI
////import FirebaseAuth
////import FirebaseFirestore
////import FirebaseStorage
////
////struct ProfileView: View {
////    @State private var username: String = ""
////    @State private var email: String = ""
////    @State private var bio: String = "This is a default bio. Edit to tell more about yourself."  // Default bio
////    @State private var profileImage: UIImage? = nil
////    @State private var isEditing: Bool = false
////    @State private var showingImagePicker = false
////    @State private var loading: Bool = true
////    @State private var errorMessage: String? = nil
////    @State private var showRemovePictureAlert = false  // State for showing the remove picture alert
////    
////    var userUID: String
////
////    let gradientStartColor = Color(UIColor(red: 141/255, green: 172/255, blue: 225/255, alpha: 1))
////    let gradientEndColor = Color(UIColor(red: 41/255, green: 102/255, blue: 117/255, alpha: 1))
////    let borderColor = Color(UIColor(red: 41/255, green: 102/255, blue: 117/255, alpha: 1))
////
////    var body: some View {
////        ZStack {
////            Color.white
////                .edgesIgnoringSafeArea(.all)
////
////            VStack(spacing: 0) {
////                // Gradient Background Box at the Top with No Space Above
////                ZStack(alignment: .top) {  // Use alignment to ensure the box starts from the top
////                    RoundedRectangle(cornerRadius: 30, style: .continuous)
////                        .fill(
////                            LinearGradient(
////                                gradient: Gradient(colors: [gradientStartColor, gradientEndColor]),
////                                startPoint: .top,
////                                endPoint: .bottom
////                            )
////                        )
////                        .frame(height: 300)
////                        .edgesIgnoringSafeArea(.top)  // Ensure the gradient box touches the top
////
////                    VStack {
////                        Spacer().frame(height: 70)  // Adjust spacing to align profile picture
////
////                        ZStack {
////                            if let image = profileImage {
////                                Image(uiImage: image)
////                                    .resizable()
////                                    .aspectRatio(contentMode: .fill)
////                                    .frame(width: 100, height: 100)
////                                    .clipShape(Circle())
////                                    .overlay(Circle().stroke(Color.white, lineWidth: 2))
////                                    .onTapGesture {  // Allow adding profile picture when tapped
////                                        showingImagePicker = true
////                                    }
////
////                                // "Remove Profile Picture" Text
////                                if isEditing {
////                                    Text("Remove Profile Picture")
////                                        .font(.footnote)
////                                        .fontWeight(.medium)
////                                        .foregroundColor(.red)
////                                        .underline()
////                                        .padding(.top, 10)  // Adjusted padding for alignment
////                                        .offset(y: 60) // Move it further down
////                                        .onTapGesture {
////                                            showRemovePictureAlert = true
////                                        }
////                                }
////                            } else {
////                                Text(initials(for: username))
////                                    .font(.largeTitle)
////                                    .foregroundColor(.white)
////                                    .frame(width: 100, height: 100)
////                                    .background(Circle().fill(Color.gray))
////                                    .overlay(Circle().stroke(Color.white, lineWidth: 2))
////                                    .onTapGesture {  // Allow adding profile picture when tapped
////                                        showingImagePicker = true
////                                    }
////                            }
////
////                            if isEditing {
////                                Button(action: {
////                                    showingImagePicker = true
////                                }) {
////                                    Image(systemName: "pencil.circle.fill")
////                                        .font(.system(size: 24))
////                                        .foregroundColor(.blue)
////                                        .background(Circle().fill(Color.white))
////                                        .offset(x: 40, y: -30)
////                                }
////                            }
////                        }
////                    }
////                }
////
////                Spacer().frame(height: 30)
////
////                if loading {
////                    ProgressView("Loading...")
////                        .progressViewStyle(CircularProgressViewStyle())
////                } else {
////                    VStack(alignment: .leading, spacing: 20) {  // Adjusted alignment for labels
////                        PersonalInfoRow(
////                            icon: "person.fill",
////                            label: "Name",
////                            text: $username,
////                            editable: isEditing,
////                            headerColor: Color.blue,
////                            inputTextColor: gradientEndColor,
////                            borderColor: borderColor,
////                            fieldHeight: 40
////                        )
////                        
////                        PersonalInfoRow(
////                            icon: "envelope.fill",
////                            label: "E-Mail",
////                            text: $email,
////                            editable: isEditing,
////                            headerColor: Color.blue,
////                            inputTextColor: gradientEndColor,
////                            borderColor: borderColor,
////                            fieldHeight: 40
////                        )
////                        
////                        PersonalInfoRow(
////                            icon: "info.circle.fill",
////                            label: "Bio",
////                            text: $bio,
////                            editable: isEditing,
////                            headerColor: Color.blue,
////                            inputTextColor: gradientEndColor,
////                            borderColor: borderColor,
////                            fieldHeight: 80  // Increased height for Bio
////                        )
////                    }
////                    .padding(.horizontal, 30)
////                    .font(.system(size: 16))  // Unified font size
////                    .foregroundColor(Color.blue)  // Label color
////
////                    if isEditing {
////                        Button(action: saveProfileChanges) {
////                            Text("Save Changes")
////                                .font(.headline)
////                                .frame(maxWidth: .infinity)
////                                .padding()
////                                .background(Color.blue)
////                                .foregroundColor(.white)
////                                .cornerRadius(10)
////                                .shadow(radius: 5)
////                        }
////                        .padding()
////                        .onTapGesture {
////                            isEditing = false
////                        }
////                    } else {
////                        Button(action: {
////                            isEditing.toggle()
////                        }) {
////                            Text("Edit Profile")
////                                .font(.headline)
////                                .frame(maxWidth: .infinity)
////                                .padding()
////                                .background(Color.blue)
////                                .foregroundColor(.white)
////                                .cornerRadius(10)
////                                .shadow(radius: 5)
////                        }
////                        .padding()
////                    }
////                }
////
////                Spacer()
////
////                // Tab Bar with Highlighted Profile Icon
////                VStack {
////                    Spacer()  // Pushes the tab bar to the bottom
////
////                    HStack {
////                        Spacer()
////                        TabBarItem(iconName: "briefcase", label: "Past Trips", destination: AnyView(SecondView(userUID: userUID)))
////                        Spacer()
////                        TabBarItem(iconName: "globe", label: "Plan Trip", destination: AnyView(SecondView(userUID: userUID)))
////                        Spacer()
////                        TabBarItem(iconName: "person.fill", label: "Profile", destination: AnyView(ProfileView(userUID: userUID)), isSelected: true)  // Highlight profile icon
////                        Spacer()
////                        TabBarItem(iconName: "gearshape", label: "Settings", destination: AnyView(SettingsView(userUID: userUID)))
////                        Spacer()
////                    }
////                    .frame(height: 72)
////                    .background(Color.white)
////                    .cornerRadius(8)
////                    .shadow(radius: 5)
////                    .padding(.bottom, 0)  // Ensure it is touching the bottom edge
////                }
////                .edgesIgnoringSafeArea(.bottom)  // Ensure the tab bar extends to the bottom and touches it
////            }
////        }
////        .sheet(isPresented: $showingImagePicker) {  // Image Picker for selecting a profile picture
////            ImagePicker(selectedImage: $profileImage)
////        }
////        .alert(isPresented: $showRemovePictureAlert) {
////            Alert(
////                title: Text("Remove Profile Picture"),
////                message: Text("Are you sure you want to remove your profile picture?"),
////                primaryButton: .destructive(Text("Remove")) {
////                    removeProfilePicture()  // Remove profile picture
////                },
////                secondaryButton: .cancel()
////            )
////        }
////        .onAppear(perform: loadUserData)
////    }
////
////    private func saveProfileChanges() {
////        if let newImage = profileImage {
////            uploadProfileImage(newImage)
////        }
////        isEditing = false
////    }
////
////    private func uploadProfileImage(_ image: UIImage) {
////        guard let userUID = Auth.auth().currentUser?.uid else { return }
////        let storageRef = Storage.storage().reference().child("profile_images/\(userUID)/profile.jpg")
////
////        guard let imageData = image.jpegData(compressionQuality: 0.75) else { return }
////
////        storageRef.putData(imageData, metadata: nil) { metadata, error in
////            if let error = error {
////                print("Error uploading image: \(error.localizedDescription)")
////                return
////            }
////
////            storageRef.downloadURL { url, error in
////                if let error = error {
////                    print("Error getting download URL: \(error.localizedDescription)")
////                    return
////                }
////
////                if let urlString = url?.absoluteString {
////                    self.updateUserProfileImageUrl(urlString)
////                }
////            }
////        }
////    }
////
////    private func updateUserProfileImageUrl(_ urlString: String) {
////        guard let userUID = Auth.auth().currentUser?.uid else { return }
////        
////        let db = Firestore.firestore()
////        db.collection("users").document(userUID).updateData([
////            "profileImageUrl": urlString
////        ]) { error in
////            if let error = error {
////                print("Error updating profile image URL: \(error.localizedDescription)")
////                return
////            }
////
////            print("Profile image URL updated successfully.")
////        }
////    }
////
////    private func loadUserData() {
////        AuthService.shared.fetchUser { user, error in
////            if let error = error {
////                self.errorMessage = "Failed to load user data: \(error.localizedDescription)"
////                self.loading = false
////                return
////            }
////            
////            if let user = user {
////                self.username = user.username ?? ""
////                self.email = user.email ?? ""
////                self.bio = (user.bio ?? "").isEmpty ? "This is a default bio. Edit to tell more about yourself." : user.bio ?? ""
////                self.loading = false
////                loadProfileImage(from: user.profileImageUrl ?? "")
////            } else {
////                self.errorMessage = "User data not found."
////                self.loading = false
////            }
////        }
////    }
////
////    private func loadProfileImage(from urlString: String) {
////        guard !urlString.isEmpty, let url = URL(string: urlString) else { return }
////        URLSession.shared.dataTask(with: url) { data, response, error in
////            if let error = error {
////                print("Error loading profile image: \(error.localizedDescription)")
////                return
////            }
////            if let data = data, let uiImage = UIImage(data: data) {
////                DispatchQueue.main.async {
////                    self.profileImage = uiImage
////                }
////            }
////        }.resume()
////    }
////
////    private func removeProfilePicture() {
////        profileImage = nil
////
////        guard let userUID = Auth.auth().currentUser?.uid else { return }
////        let storageRef = Storage.storage().reference().child("profile_images/\(userUID)/profile.jpg")
////
////        storageRef.delete { error in
////            if let error = error {
////                print("Error removing image: \(error.localizedDescription)")
////            } else {
////                AuthService.shared.updateUserProfileData(userUID: userUID, username: self.username, profileImageUrl: "") { error in
////                    if let error = error {
////                        print("Error removing profile image URL: \(error.localizedDescription)")
////                    } else {
////                        print("Profile image removed successfully.")
////                    }
////                }
////            }
////        }
////    }
////
////    private func TabBarItem(iconName: String, label: String, destination: AnyView, isSelected: Bool = false) -> some View {
////        VStack {
////            Image(systemName: iconName)
////                .foregroundColor(isSelected ? gradientEndColor : .blue)  // Highlight if selected
////            Text(label)
////                .font(.footnote)
////                .foregroundColor(isSelected ? gradientEndColor : .blue)  // Highlight if selected
////        }
////        .padding(.vertical, 10)
////        .background(isSelected ? gradientEndColor.opacity(0.2) : Color.clear)  // Highlight background if selected
////        .cornerRadius(10)
////        .onTapGesture {
////            if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene {
////                if let window = windowScene.windows.first {
////                    window.rootViewController = UIHostingController(rootView: destination)
////                    window.makeKeyAndVisible()
////                }
////            }
////        }
////    }
////
////    private func initials(for name: String) -> String {
////        let components = name.split(separator: " ")
////        let initials = components.compactMap { $0.first }.map { String($0) }.joined()
////        return String(initials.prefix(2)).uppercased()
////    }
////}
////
////// Updated PersonalInfoRow Declaration
////struct PersonalInfoRow: View {
////    var icon: String
////    var label: String
////    @Binding var text: String
////    var editable: Bool = false
////    var headerColor: Color
////    var inputTextColor: Color
////    var borderColor: Color
////    var fieldHeight: CGFloat  // Added parameter for field height
////
////    var body: some View {
////        HStack {
////            Image(systemName: icon)
////                .foregroundColor(.gray)
////            Text(label)
////                .font(.system(size: 14, weight: .bold))  // Thicker blue font
////                .foregroundColor(headerColor)
////            Spacer()
////            if editable {
////                TextField(label, text: $text)
////                    .padding(10)
////                    .background(RoundedRectangle(cornerRadius: 10).stroke(borderColor, lineWidth: 1))
////                    .foregroundColor(inputTextColor)  // Use the specific gradient color for input text
////                    .frame(height: fieldHeight)  // Consistent size for all text fields
////                    .frame(maxWidth: .infinity)  // Same width
////                    .multilineTextAlignment(.center)  // Center the text in text fields
////            } else {
////                Text(text)  // Show only the text without repeating the label
////                    .font(.system(size: 16))
////                    .foregroundColor(inputTextColor)
////                    .frame(maxWidth: .infinity, alignment: .leading)
////            }
////            
////        }
////        .padding(.vertical, 5)
////    }
////       
////}
////
////
//
//
//import SwiftUI
//import FirebaseAuth
//import FirebaseFirestore
//import FirebaseStorage
//
//struct ProfileView: View {
//    @State private var username: String = ""
//    @State private var email: String = ""
//    @State private var bio: String = "This is a default bio. Edit to tell more about yourself."  // Default bio
//    @State private var profileImage: UIImage? = nil
//    @State private var isEditing: Bool = false
//    @State private var showingImagePicker = false
//    @State private var loading: Bool = true
//    @State private var errorMessage: String? = nil
//    @State private var showRemovePictureAlert = false  // State for showing the remove picture alert
//    
//    var userUID: String
//
//    let gradientStartColor = Color(UIColor(red: 141/255, green: 172/255, blue: 225/255, alpha: 1))
//    let gradientEndColor = Color(UIColor(red: 41/255, green: 102/255, blue: 117/255, alpha: 1))
//    let borderColor = Color(UIColor(red: 41/255, green: 102/255, blue: 117/255, alpha: 1))
//
//    var body: some View {
//        ZStack {
//            Color.white
//                .edgesIgnoringSafeArea(.all)
//
//            VStack(spacing: 0) {
//                // Gradient Background Box at the Top with No Space Above
//                ZStack(alignment: .top) {  // Use alignment to ensure the box starts from the top
//                    RoundedRectangle(cornerRadius: 30, style: .continuous)
//                        .fill(
//                            LinearGradient(
//                                gradient: Gradient(colors: [gradientStartColor, gradientEndColor]),
//                                startPoint: .top,
//                                endPoint: .bottom
//                            )
//                        )
//                        .frame(height: 300)
//                        .edgesIgnoringSafeArea(.top)  // Ensure the gradient box touches the top
//
//                    VStack {
//                        Spacer().frame(height: 70)  // Adjust spacing to align profile picture
//
//                        ZStack {
//                            if let image = profileImage {
//                                Image(uiImage: image)
//                                    .resizable()
//                                    .aspectRatio(contentMode: .fill)
//                                    .frame(width: 100, height: 100)
//                                    .clipShape(Circle())
//                                    .overlay(Circle().stroke(Color.white, lineWidth: 2))
//                                    .onTapGesture {  // Allow adding profile picture when tapped
//                                        showingImagePicker = true
//                                    }
//
//                                // "Remove Profile Picture" Text
//                                if isEditing {
//                                    Text("Remove Profile Picture")
//                                        .font(.footnote)
//                                        .fontWeight(.medium)
//                                        .foregroundColor(.red)
//                                        .underline()
//                                        .padding(.top, 10)  // Adjusted padding for alignment
//                                        .offset(y: 60) // Move it further down
//                                        .onTapGesture {
//                                            showRemovePictureAlert = true
//                                        }
//                                }
//                            } else {
//                                Text(initials(for: username))
//                                    .font(.largeTitle)
//                                    .foregroundColor(.white)
//                                    .frame(width: 100, height: 100)
//                                    .background(Circle().fill(Color.gray))
//                                    .overlay(Circle().stroke(Color.white, lineWidth: 2))
//                                    .onTapGesture {  // Allow adding profile picture when tapped
//                                        showingImagePicker = true
//                                    }
//                            }
//
//                            if isEditing {
//                                Button(action: {
//                                    showingImagePicker = true
//                                }) {
//                                    Image(systemName: "pencil.circle.fill")
//                                        .font(.system(size: 24))
//                                        .foregroundColor(.blue)
//                                        .background(Circle().fill(Color.white))
//                                        .offset(x: 40, y: -30)
//                                }
//                            }
//                        }
//                    }
//                }
//
//                Spacer().frame(height: 30)
//
//                if loading {
//                    ProgressView("Loading...")
//                        .progressViewStyle(CircularProgressViewStyle())
//                } else {
//                    VStack(alignment: .leading, spacing: 20) {  // Adjusted alignment for labels
//                        PersonalInfoRow(
//                            icon: "person.fill",
//                            label: "Name",
//                            text: $username,
//                            editable: isEditing,
//                            headerColor: Color.blue,
//                            inputTextColor: gradientEndColor,
//                            borderColor: borderColor,
//                            fieldHeight: 40
//                        )
//                        
//                        PersonalInfoRow(
//                            icon: "envelope.fill",
//                            label: "E-Mail",
//                            text: $email,
//                            editable: isEditing,
//                            headerColor: Color.blue,
//                            inputTextColor: gradientEndColor,
//                            borderColor: borderColor,
//                            fieldHeight: 40
//                        )
//                        
//                        PersonalInfoRow(
//                            icon: "info.circle.fill",
//                            label: "Bio",
//                            text: $bio,
//                            editable: isEditing,
//                            headerColor: Color.blue,
//                            inputTextColor: gradientEndColor,
//                            borderColor: borderColor,
//                            fieldHeight: 80  // Increased height for Bio
//                        )
//                    }
//                    .padding(.horizontal, 30)
//                    .font(.system(size: 16))  // Unified font size
//                    .foregroundColor(Color.blue)  // Label color
//
//                    if isEditing {
//                        Button(action: saveProfileChanges) {
//                            Text("Save Changes")
//                                .font(.headline)
//                                .frame(maxWidth: .infinity)
//                                .padding()
//                                .background(Color.blue)
//                                .foregroundColor(.white)
//                                .cornerRadius(10)
//                                .shadow(radius: 5)
//                        }
//                        .padding()
//                        .onTapGesture {
//                            isEditing = false
//                        }
//                    } else {
//                        Button(action: {
//                            isEditing.toggle()
//                        }) {
//                            Text("Edit Profile")
//                                .font(.headline)
//                                .frame(maxWidth: .infinity)
//                                .padding()
//                                .background(Color.blue)
//                                .foregroundColor(.white)
//                                .cornerRadius(10)
//                                .shadow(radius: 5)
//                        }
//                        .padding()
//                    }
//                }
//
//                Spacer()
//
//                // Tab Bar with Highlighted Profile Icon
//                VStack {
//                    Spacer()  // Pushes the tab bar to the bottom
//
//                    HStack {
//                        Spacer()
//                        TabBarItem(iconName: "briefcase", label: "Past Trips", destination: AnyView(SecondView(userUID: userUID)))
//                        Spacer()
//                        TabBarItem(iconName: "globe", label: "Plan Trip", destination: AnyView(SecondView(userUID: userUID)))
//                        Spacer()
//                        TabBarItem(iconName: "person.fill", label: "Profile", destination: AnyView(ProfileView(userUID: userUID)), isSelected: true)  // Highlight profile icon
//                        Spacer()
//                        TabBarItem(iconName: "gearshape", label: "Settings", destination: AnyView(SettingsView(userUID: userUID)))
//                        Spacer()
//                    }
//                    .frame(height: 72)
//                    .background(Color.white)
//                    .cornerRadius(8)
//                    .shadow(radius: 5)
//                    .padding(.bottom, 0)  // Ensure it is touching the bottom edge
//                }
//                .edgesIgnoringSafeArea(.bottom)  // Ensure the tab bar extends to the bottom and touches it
//            }
//        }
//        .sheet(isPresented: $showingImagePicker) {  // Image Picker for selecting a profile picture
//            ImagePicker(selectedImage: $profileImage)
//        }
//        .alert(isPresented: $showRemovePictureAlert) {
//            Alert(
//                title: Text("Remove Profile Picture"),
//                message: Text("Are you sure you want to remove your profile picture?"),
//                primaryButton: .destructive(Text("Remove")) {
//                    removeProfilePicture()  // Remove profile picture
//                },
//                secondaryButton: .cancel()
//            )
//        }
//        .onAppear(perform: loadUserData)
//    }
//
//    private func saveProfileChanges() {
//        guard let userUID = Auth.auth().currentUser?.uid else { return }
//
//            let db = Firestore.firestore()
//            
//            // Save the updated user data
//            db.collection("users").document(userUID).updateData([
//                "username": username,
//                "email": email,
//                "bio": bio
//            ]) { error in
//                if let error = error {
//                    print("Error saving profile data: \(error.localizedDescription)")
//                    return
//                }
//
//                print("Profile data saved successfully.")
//                
//                if let newImage = profileImage {
//                    uploadProfileImage(newImage)  // Upload image if it exists
//                }
//
//                isEditing = false
//            }
//    }
//
//    private func uploadProfileImage(_ image: UIImage) {
//        guard let userUID = Auth.auth().currentUser?.uid else { return }
//        let storageRef = Storage.storage().reference().child("profile_images/\(userUID)/profile.jpg")
//
//        guard let imageData = image.jpegData(compressionQuality: 0.75) else { return }
//
//        storageRef.putData(imageData, metadata: nil) { metadata, error in
//            if let error = error {
//                print("Error uploading image: \(error.localizedDescription)")
//                return
//            }
//
//            storageRef.downloadURL { url, error in
//                if let error = error {
//                    print("Error getting download URL: \(error.localizedDescription)")
//                    return
//                }
//
//                if let urlString = url?.absoluteString {
//                    self.updateUserProfileImageUrl(urlString)
//                }
//            }
//        }
//    }
//
//    private func updateUserProfileImageUrl(_ urlString: String) {
//        guard let userUID = Auth.auth().currentUser?.uid else { return }
//        
//        let db = Firestore.firestore()
//        db.collection("users").document(userUID).updateData([
//            "profileImageUrl": urlString
//        ]) { error in
//            if let error = error {
//                print("Error updating profile image URL: \(error.localizedDescription)")
//                return
//            }
//
//            print("Profile image URL updated successfully.")
//        }
//    }
//
//    private func loadUserData() {
//        guard let userUID = Auth.auth().currentUser?.uid else { return }
//
//            let db = Firestore.firestore()
//            
//            // Fetch the user data from Firestore
//            db.collection("users").document(userUID).getDocument { document, error in
//                if let error = error {
//                    self.errorMessage = "Failed to load user data: \(error.localizedDescription)"
//                    self.loading = false
//                    return
//                }
//
//                if let document = document, document.exists {
//                    let data = document.data()
//                    self.username = data?["username"] as? String ?? ""
//                    self.email = data?["email"] as? String ?? ""
//                    self.bio = (data?["bio"] as? String)?.isEmpty ?? true ? "This is a default bio. Edit to tell more about yourself." : data?["bio"] as? String ?? ""
//                    self.loading = false
//                    loadProfileImage(from: data?["profileImageUrl"] as? String ?? "")
//                } else {
//                    self.errorMessage = "User data not found."
//                    self.loading = false
//                }
//            }
//    }
//
//    private func loadProfileImage(from urlString: String) {
//        guard !urlString.isEmpty, let url = URL(string: urlString) else { return }
//        URLSession.shared.dataTask(with: url) { data, response, error in
//            if let error = error {
//                print("Error loading profile image: \(error.localizedDescription)")
//                return
//            }
//            if let data = data, let uiImage = UIImage(data: data) {
//                DispatchQueue.main.async {
//                    self.profileImage = uiImage
//                }
//            }
//        }.resume()
//    }
//
//    private func removeProfilePicture() {
//        profileImage = nil
//
//        guard let userUID = Auth.auth().currentUser?.uid else { return }
//        let storageRef = Storage.storage().reference().child("profile_images/\(userUID)/profile.jpg")
//
//        storageRef.delete { error in
//            if let error = error {
//                print("Error removing image: \(error.localizedDescription)")
//            } else {
//                AuthService.shared.updateUserProfileData(userUID: userUID, username: self.username, profileImageUrl: "") { error in
//                    if let error = error {
//                        print("Error removing profile image URL: \(error.localizedDescription)")
//                    } else {
//                        print("Profile image removed successfully.")
//                    }
//                }
//            }
//        }
//    }
//
//    private func TabBarItem(iconName: String, label: String, destination: AnyView, isSelected: Bool = false) -> some View {
//        VStack {
//            Image(systemName: iconName)
//                .foregroundColor(isSelected ? gradientEndColor : .blue)  // Highlight if selected
//            Text(label)
//                .font(.footnote)
//                .foregroundColor(isSelected ? gradientEndColor : .blue)  // Highlight if selected
//        }
//        .padding(.vertical, 10)
//        .background(isSelected ? gradientEndColor.opacity(0.2) : Color.clear)  // Highlight background if selected
//        .cornerRadius(10)
//        .onTapGesture {
//            if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene {
//                if let window = windowScene.windows.first {
//                    window.rootViewController = UIHostingController(rootView: destination)
//                    window.makeKeyAndVisible()
//                }
//            }
//        }
//    }
//
//    private func initials(for name: String) -> String {
//        let components = name.split(separator: " ")
//        let initials = components.compactMap { $0.first }.map { String($0) }.joined()
//        return String(initials.prefix(2)).uppercased()
//    }
//}
//
//// Updated PersonalInfoRow Declaration
//struct PersonalInfoRow: View {
//    var icon: String
//    var label: String
//    @Binding var text: String
//    var editable: Bool = false
//    var headerColor: Color
//    var inputTextColor: Color
//    var borderColor: Color
//    var fieldHeight: CGFloat  // Added parameter for field height
//
//    var body: some View {
//        HStack {
//            Image(systemName: icon)
//                .foregroundColor(.gray)
//            Text(label)
//                .font(.system(size: 14, weight: .bold))  // Thicker blue font
//                .foregroundColor(headerColor)
//            Spacer()
//            if editable {
//                TextField(label, text: $text)
//                    .padding(10)
//                    .background(RoundedRectangle(cornerRadius: 10).stroke(borderColor, lineWidth: 1))
//                    .foregroundColor(inputTextColor)  // Use the specific gradient color for input text
//                    .frame(height: fieldHeight)  // Consistent size for all text fields
//                    .frame(maxWidth: .infinity)  // Same width
//                    .multilineTextAlignment(.center)  // Center the text in text fields
//            } else {
//                Text(text)  // Show only the text without repeating the label
//                    .font(.system(size: 16))
//                    .foregroundColor(inputTextColor)
//                    .frame(maxWidth: .infinity, alignment: .leading)
//            }
//            
//        }
//        .padding(.vertical, 5)
//    }
//       
//}
//
//
// <<<<<<< Hinal
// =======


// import SwiftUI
// import FirebaseAuth
// import FirebaseFirestore
// import FirebaseStorage

// struct ProfileView: View {
//     @State private var username: String = ""
//     @State private var email: String = ""
//     @State private var bio: String = "This is a default bio. Edit to tell more about yourself."  // Default bio
//     @State private var profileImage: UIImage? = nil
//     @State private var isEditing: Bool = false
//     @State private var showingImagePicker = false
//     @State private var loading: Bool = true
//     @State private var errorMessage: String? = nil
//     @State private var showRemovePictureAlert = false  // State for showing the remove picture alert
    
//     var userUID: String

//     let gradientStartColor = Color(UIColor(red: 141/255, green: 172/255, blue: 225/255, alpha: 1))
//     let gradientEndColor = Color(UIColor(red: 41/255, green: 102/255, blue: 117/255, alpha: 1))
//     let borderColor = Color(UIColor(red: 41/255, green: 102/255, blue: 117/255, alpha: 1))

//     var body: some View {
//         ZStack {
//             Color.white
//                 .edgesIgnoringSafeArea(.all)

//             VStack(spacing: 0) {
//                 // Gradient Background Box at the Top with No Space Above
//                 ZStack(alignment: .top) {  // Use alignment to ensure the box starts from the top
//                     RoundedRectangle(cornerRadius: 30, style: .continuous)
//                         .fill(
//                             LinearGradient(
//                                 gradient: Gradient(colors: [gradientStartColor, gradientEndColor]),
//                                 startPoint: .top,
//                                 endPoint: .bottom
//                             )
//                         )
//                         .frame(height: 300)
//                         .edgesIgnoringSafeArea(.top)  // Ensure the gradient box touches the top

//                     VStack {
//                         Spacer().frame(height: 70)  // Adjust spacing to align profile picture

//                         ZStack {
//                             if let image = profileImage {
//                                 Image(uiImage: image)
//                                     .resizable()
//                                     .aspectRatio(contentMode: .fill)
//                                     .frame(width: 100, height: 100)
//                                     .clipShape(Circle())
//                                     .overlay(Circle().stroke(Color.white, lineWidth: 2))
//                                     .onTapGesture {  // Allow adding profile picture when tapped
//                                         showingImagePicker = true
//                                     }

//                                 // "Remove Profile Picture" Text
//                                 if isEditing {
//                                     Text("Remove Profile Picture")
//                                         .font(.footnote)
//                                         .fontWeight(.medium)
//                                         .foregroundColor(.red)
//                                         .underline()
//                                         .padding(.top, 10)  // Adjusted padding for alignment
//                                         .offset(y: 60) // Move it further down
//                                         .onTapGesture {
//                                             showRemovePictureAlert = true
//                                         }
//                                 }
//                             } else {
//                                 Text(initials(for: username))
//                                     .font(.largeTitle)
//                                     .foregroundColor(.white)
//                                     .frame(width: 100, height: 100)
//                                     .background(Circle().fill(Color.gray))
//                                     .overlay(Circle().stroke(Color.white, lineWidth: 2))
//                                     .onTapGesture {  // Allow adding profile picture when tapped
//                                         showingImagePicker = true
//                                     }
//                             }

//                             if isEditing {
//                                 Button(action: {
//                                     showingImagePicker = true
//                                 }) {
//                                     Image(systemName: "pencil.circle.fill")
//                                         .font(.system(size: 24))
//                                         .foregroundColor(.blue)
//                                         .background(Circle().fill(Color.white))
//                                         .offset(x: 40, y: -30)
//                                 }
//                             }
//                         }
//                     }
//                 }

//                 Spacer().frame(height: 30)

//                 if loading {
//                     ProgressView("Loading...")
//                         .progressViewStyle(CircularProgressViewStyle())
//                 } else {
//                     VStack(alignment: .leading, spacing: 20) {  // Adjusted alignment for labels
//                         PersonalInfoRow(
//                             icon: "person.fill",
//                             label: "Name",
//                             text: $username,
//                             editable: isEditing,
//                             headerColor: Color.blue,
//                             inputTextColor: gradientEndColor,
//                             borderColor: borderColor,
//                             fieldHeight: 40
//                         )
                        
//                         PersonalInfoRow(
//                             icon: "envelope.fill",
//                             label: "E-Mail",
//                             text: $email,
//                             editable: isEditing,
//                             headerColor: Color.blue,
//                             inputTextColor: gradientEndColor,
//                             borderColor: borderColor,
//                             fieldHeight: 40
//                         )
                        
//                         PersonalInfoRow(
//                             icon: "info.circle.fill",
//                             label: "Bio",
//                             text: $bio,
//                             editable: isEditing,
//                             headerColor: Color.blue,
//                             inputTextColor: gradientEndColor,
//                             borderColor: borderColor,
//                             fieldHeight: 80  // Increased height for Bio
//                         )
//                     }
//                     .padding(.horizontal, 30)
//                     .font(.system(size: 16))  // Unified font size
//                     .foregroundColor(Color.blue)  // Label color

//                     if isEditing {
//                         Button(action: saveProfileChanges) {
//                             Text("Save Changes")
//                                 .font(.headline)
//                                 .frame(maxWidth: .infinity)
//                                 .padding()
//                                 .background(Color.blue)
//                                 .foregroundColor(.white)
//                                 .cornerRadius(10)
//                                 .shadow(radius: 5)
//                         }
//                         .padding()
//                         .onTapGesture {
//                             isEditing = false
//                         }
//                     } else {
//                         Button(action: {
//                             isEditing.toggle()
//                         }) {
//                             Text("Edit Profile")
//                                 .font(.headline)
//                                 .frame(maxWidth: .infinity)
//                                 .padding()
//                                 .background(Color.blue)
//                                 .foregroundColor(.white)
//                                 .cornerRadius(10)
//                                 .shadow(radius: 5)
//                         }
//                         .padding()
//                     }
//                 }

//                 Spacer()

//                 // Tab Bar with Highlighted Profile Icon
//                 VStack {
//                     Spacer()  // Pushes the tab bar to the bottom

//                     HStack {
//                         Spacer()
//                         TabBarItem(iconName: "briefcase", label: "Past Trips", destination: AnyView(SecondView(userUID: userUID)))
//                         Spacer()
//                         TabBarItem(iconName: "globe", label: "Plan Trip", destination: AnyView(SecondView(userUID: userUID)))
//                         Spacer()
//                         TabBarItem(iconName: "person.fill", label: "Profile", destination: AnyView(ProfileView(userUID: userUID)), isSelected: true)  // Highlight profile icon
//                         Spacer()
//                         TabBarItem(iconName: "gearshape", label: "Settings", destination: AnyView(SettingsView(userUID: userUID)))
//                         Spacer()
//                     }
//                     .frame(height: 72)
//                     .background(Color.white)
//                     .cornerRadius(8)
//                     .shadow(radius: 5)
//                     .padding(.bottom, 0)  // Ensure it is touching the bottom edge
//                 }
//                 .edgesIgnoringSafeArea(.bottom)  // Ensure the tab bar extends to the bottom and touches it
//             }
//         }
//         .sheet(isPresented: $showingImagePicker) {  // Image Picker for selecting a profile picture
//             ImagePicker(selectedImage: $profileImage)
//         }
//         .alert(isPresented: $showRemovePictureAlert) {
//             Alert(
//                 title: Text("Remove Profile Picture"),
//                 message: Text("Are you sure you want to remove your profile picture?"),
//                 primaryButton: .destructive(Text("Remove")) {
//                     removeProfilePicture()  // Remove profile picture
//                 },
//                 secondaryButton: .cancel()
//             )
//         }
//         .onAppear(perform: loadUserData)
//     }

//     private func saveProfileChanges() {
//         guard let userUID = Auth.auth().currentUser?.uid else { return }

//             let db = Firestore.firestore()
            
//             // Save the updated user data
//             db.collection("users").document(userUID).updateData([
//                 "username": username,
//                 "email": email,
//                 "bio": bio
//             ]) { error in
//                 if let error = error {
//                     print("Error saving profile data: \(error.localizedDescription)")
//                     return
//                 }

//                 print("Profile data saved successfully.")
                
//                 if let newImage = profileImage {
//                     uploadProfileImage(newImage)  // Upload image if it exists
//                 }

//                 isEditing = false
//             }
//     }

//     private func uploadProfileImage(_ image: UIImage) {
//         guard let userUID = Auth.auth().currentUser?.uid else { return }
//         let storageRef = Storage.storage().reference().child("profile_images/\(userUID)/profile.jpg")

//         guard let imageData = image.jpegData(compressionQuality: 0.75) else { return }

//         storageRef.putData(imageData, metadata: nil) { metadata, error in
//             if let error = error {
//                 print("Error uploading image: \(error.localizedDescription)")
//                 return
//             }

//             storageRef.downloadURL { url, error in
//                 if let error = error {
//                     print("Error getting download URL: \(error.localizedDescription)")
//                     return
//                 }

//                 if let urlString = url?.absoluteString {
//                     self.updateUserProfileImageUrl(urlString)
//                 }
//             }
//         }
//     }

//     private func updateUserProfileImageUrl(_ urlString: String) {
//         guard let userUID = Auth.auth().currentUser?.uid else { return }
        
//         let db = Firestore.firestore()
//         db.collection("users").document(userUID).updateData([
//             "profileImageUrl": urlString
//         ]) { error in
//             if let error = error {
//                 print("Error updating profile image URL: \(error.localizedDescription)")
//                 return
//             }

//             print("Profile image URL updated successfully.")
//         }
//     }

//     private func loadUserData() {
//         guard let userUID = Auth.auth().currentUser?.uid else { return }

//             let db = Firestore.firestore()
            
//             // Fetch the user data from Firestore
//             db.collection("users").document(userUID).getDocument { document, error in
//                 if let error = error {
//                     self.errorMessage = "Failed to load user data: \(error.localizedDescription)"
//                     self.loading = false
//                     return
//                 }

//                 if let document = document, document.exists {
//                     let data = document.data()
//                     self.username = data?["username"] as? String ?? ""
//                     self.email = data?["email"] as? String ?? ""
//                     self.bio = (data?["bio"] as? String)?.isEmpty ?? true ? "This is a default bio. Edit to tell more about yourself." : data?["bio"] as? String ?? ""
//                     self.loading = false
//                     loadProfileImage(from: data?["profileImageUrl"] as? String ?? "")
//                 } else {
//                     self.errorMessage = "User data not found."
//                     self.loading = false
//                 }
//             }
//     }

//     private func loadProfileImage(from urlString: String) {
//         guard !urlString.isEmpty, let url = URL(string: urlString) else { return }
//         URLSession.shared.dataTask(with: url) { data, response, error in
//             if let error = error {
//                 print("Error loading profile image: \(error.localizedDescription)")
//                 return
//             }
//             if let data = data, let uiImage = UIImage(data: data) {
//                 DispatchQueue.main.async {
//                     self.profileImage = uiImage
//                 }
//             }
//         }.resume()
//     }

//     private func removeProfilePicture() {
//         profileImage = nil

//         guard let userUID = Auth.auth().currentUser?.uid else { return }
//         let storageRef = Storage.storage().reference().child("profile_images/\(userUID)/profile.jpg")

//         storageRef.delete { error in
//             if let error = error {
//                 print("Error removing image: \(error.localizedDescription)")
//             } else {
//                 AuthService.shared.updateUserProfileData(userUID: userUID, username: self.username, profileImageUrl: "") { error in
//                     if let error = error {
//                         print("Error removing profile image URL: \(error.localizedDescription)")
//                     } else {
//                         print("Profile image removed successfully.")
//                     }
//                 }
//             }
//         }
//     }

//     private func TabBarItem(iconName: String, label: String, destination: AnyView, isSelected: Bool = false) -> some View {
//         VStack {
//             Image(systemName: iconName)
//                 .foregroundColor(isSelected ? gradientEndColor : .blue)  // Highlight if selected
//             Text(label)
//                 .font(.footnote)
//                 .foregroundColor(isSelected ? gradientEndColor : .blue)  // Highlight if selected
//         }
//         .padding(.vertical, 10)
//         .background(isSelected ? gradientEndColor.opacity(0.2) : Color.clear)  // Highlight background if selected
//         .cornerRadius(10)
//         .onTapGesture {
//             if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene {
//                 if let window = windowScene.windows.first {
//                     window.rootViewController = UIHostingController(rootView: destination)
//                     window.makeKeyAndVisible()
//                 }
//             }
//         }
//     }

//     private func initials(for name: String) -> String {
//         let components = name.split(separator: " ")
//         let initials = components.compactMap { $0.first }.map { String($0) }.joined()
//         return String(initials.prefix(2)).uppercased()
//     }
// }

// // Updated PersonalInfoRow Declaration
// struct PersonalInfoRow: View {
//     var icon: String
//     var label: String
//     @Binding var text: String
//     var editable: Bool = false
//     var headerColor: Color
//     var inputTextColor: Color
//     var borderColor: Color
//     var fieldHeight: CGFloat  // Added parameter for field height

//     var body: some View {
//         HStack {
//             Image(systemName: icon)
//                 .foregroundColor(.gray)
//             Text(label)
//                 .font(.system(size: 14, weight: .bold))  // Thicker blue font
//                 .foregroundColor(headerColor)
//             Spacer()
//             if editable {
//                 TextField(label, text: $text)
//                     .padding(10)
//                     .background(RoundedRectangle(cornerRadius: 10).stroke(borderColor, lineWidth: 1))
//                     .foregroundColor(inputTextColor)  // Use the specific gradient color for input text
//                     .frame(height: fieldHeight)  // Consistent size for all text fields
//                     .frame(maxWidth: .infinity)  // Same width
//                     .multilineTextAlignment(.center)  // Center the text in text fields
//             } else {
//                 Text(text)  // Show only the text without repeating the label
//                     .font(.system(size: 16))
//                     .foregroundColor(inputTextColor)
//                     .frame(maxWidth: .infinity, alignment: .leading)
//             }
            
//         }
//         .padding(.vertical, 5)
//     }
       
// }
// >>>>>>> main
