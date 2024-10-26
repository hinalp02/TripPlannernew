//
//  SettingsView.swift
//  TripPlanner3
//
//  Created by stlp on 9/14/24.
//
//hello//
import SwiftUI
import FirebaseAuth

struct SettingsView: View {
    let gradientStartColor = Color(UIColor(red: 141/255, green: 172/255, blue: 225/255, alpha: 1))
    let gradientEndColor = Color(UIColor(red: 41/255, green: 102/255, blue: 117/255, alpha: 1))

    @State private var selectedTab: Tab = .settings  // Manage the active tab state
    var userUID: String

    var body: some View {
        NavigationView {
            ZStack {
                Color.white.edgesIgnoringSafeArea(.all)

                VStack(spacing: 0) {
                    // Fancy Header with Blue Gradient Background
                    ZStack(alignment: .top) {
                        RoundedRectangle(cornerRadius: 30, style: .continuous)
                            .fill(
                                LinearGradient(
                                    gradient: Gradient(colors: [gradientStartColor, gradientEndColor]),
                                    startPoint: .top,
                                    endPoint: .bottom
                                )
                            )
                            .frame(height: 300)
                            .edgesIgnoringSafeArea(.top)

                        VStack {
                            Spacer().frame(height: 70)  // Adjust spacing to align title

                            // Fancy Title inside the gradient box
                            Text("Settings")
                                .font(.system(size: 40, weight: .bold, design: .rounded))  // Larger, rounded bold font
                                .foregroundColor(.white)
                                .shadow(color: Color.black.opacity(0.2), radius: 5, x: 0, y: 5)  // Add subtle shadow
                                .padding(.top, 30)  // Adjusted padding for better alignment
                                .frame(maxWidth: .infinity)  // Center the header
                        }
                    }

                    // Content Section Below the Gradient
                    VStack(spacing: 20) {
                        NavigationLink(destination: ChangePasswordView()) {
                            Text("Change Password")
                                .font(.headline)
                                .padding()
                                .frame(maxWidth: .infinity)
                                .background(Color.blue)
                                .foregroundColor(.white)
                                .cornerRadius(10)
                        }
                        .padding(.horizontal)

                        NavigationLink(destination: ChangeEmailView()) {
                            Text("Change Email")
                                .font(.headline)
                                .padding()
                                .frame(maxWidth: .infinity)
                                .background(Color.blue)
                                .foregroundColor(.white)
                                .cornerRadius(10)
                        }
                        .padding(.horizontal)

                        Button(action: logout) {
                            Text("Logout")
                                .font(.headline)
                                .padding()
                                .frame(maxWidth: .infinity)
                                .background(Color.red)
                                .foregroundColor(.white)
                                .cornerRadius(10)
                        }
                        .padding(.horizontal)

                        Spacer()
                    }
                    .padding(.top, 20)
                    .padding(.horizontal, 20)
                    .background(Color.white)
                    .cornerRadius(10)
                    .shadow(radius: 5)
                    .padding(.horizontal)

                    Spacer()

                    // Tab Bar
                    VStack {
                        Spacer()  // Pushes the tab bar to the bottom

                        HStack {
                            Spacer()
                            TabBarItem(iconName: "briefcase", label: "Past Trips", isSelected: selectedTab == .pastTrips) {
                                navigateTo(.pastTrips)
                            }
                            Spacer()
                            TabBarItem(iconName: "globe", label: "Plan Trip", isSelected: selectedTab == .planTrip) {
                                navigateTo(.planTrip)
                            }
                            Spacer()
                            TabBarItem(iconName: "person.fill", label: "Profile", isSelected: selectedTab == .profile) {
                                navigateTo(.profile)
                            }
                            Spacer()
                            TabBarItem(iconName: "gearshape", label: "Settings", isSelected: selectedTab == .settings) {
                                navigateTo(.settings)
                            }
                            Spacer()
                        }
                        .frame(height: 72)
                        .background(Color.white)
                        .cornerRadius(8)
                        .shadow(radius: 5)
                        .padding(.bottom, 0)  // Ensure it is touching the bottom edge
                    }
                    .edgesIgnoringSafeArea(.bottom)  // Ensure the tab bar extends to the bottom and touches it
                }
                .navigationBarTitleDisplayMode(.inline)
                .navigationBarHidden(true)
            }
        }
        .navigationViewStyle(StackNavigationViewStyle())  // Ensures proper navigation view behavior
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

    // Tab Bar Item View
    private func TabBarItem(iconName: String, label: String, isSelected: Bool = false, action: @escaping () -> Void) -> some View {
        VStack {
            Image(systemName: iconName)
                .foregroundColor(isSelected ? gradientEndColor : .blue)  // Highlight if selected
            Text(label)
                .font(.footnote)
                .foregroundColor(isSelected ? gradientEndColor : .blue)  // Highlight if selected
        }
        .padding(.vertical, 10)
        .background(isSelected ? gradientEndColor.opacity(0.2) : Color.clear)  // Highlight background if selected
        .cornerRadius(10)
        .onTapGesture {
            action()
            self.selectedTab = Tab(rawValue: label) ?? .settings  // Update selected tab
        }
    }

    // Function to navigate between views
    private func navigateTo(_ tab: Tab) {
        if let window = UIApplication.shared.windows.first {
            switch tab {
            case .pastTrips:
                window.rootViewController = UIHostingController(rootView: PastTripsView(userUID: userUID))
            case .planTrip:
                window.rootViewController = UIHostingController(rootView: SecondView(userUID: userUID))
            case .profile:
                window.rootViewController = UIHostingController(rootView: ProfileView(userUID: userUID))
            case .settings:
                window.rootViewController = UIHostingController(rootView: SettingsView(userUID: userUID))
            }
            window.makeKeyAndVisible()
        }
    }
}

// Enum to manage tab selection
extension SettingsView {
    enum Tab: String {
        case pastTrips = "Past Trips"
        case planTrip = "Plan Trip"
        case profile = "Profile"
        case settings = "Settings"
    }
}
