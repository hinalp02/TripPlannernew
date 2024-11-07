//
//  PastTripsView.swift
//  TripPlanner3
//
//  Created by stlp on 9/14/24.
//

import SwiftUI

struct PastTripsView: View {
    let gradientStartColor = Color(UIColor(red: 141/255, green: 172/255, blue: 225/255, alpha: 1))
    let gradientEndColor = Color(UIColor(red: 41/255, green: 102/255, blue: 117/255, alpha: 1))

    @State private var selectedTab: Tab = .pastTrips
    @State private var pastTrips: [String] = []
    @State private var profileImage: UIImage? = nil
    var userUID: String
    @State private var username: String = ""
    @State private var trendingCity: String = "Santorini"  // Default value
    @State private var trendingImageName: String = "santorini"  // Default image

    // Cities and corresponding images
    let cities = [
        ("Los Angeles, USA", "losangelesday1"),
        ("Honolulu, USA", "honoluluday1"),
        ("Paris, France", "parisday1"),
        ("Santorini, Greece", "santoriniday1"),
        ("Mumbai, India", "mumbaiday1"),
        ("Shanghai, China", "shanghaiday1"),
        ("Tokyo, Japan", "tokyoday1"),
        ("New York City, USA", "newyorkcityday1"),
        ("Cancun, Mexico", "cancunday1"),
        ("London, England", "londonday1")
    ]

    var body: some View {
        ZStack {
            Color.white.edgesIgnoringSafeArea(.all)

            VStack(spacing: 0) {
                // Header with profile picture on the right, welcome message, and button
                VStack(spacing: 10) {
                    HStack {
                        VStack(alignment: .leading) {
                            Text("\(formattedDate())")
                                .foregroundColor(.gray)
                                .font(.subheadline)
                            Text("Welcome, \(username)!")
                                .font(.title2)
                                .foregroundColor(.blue)
                                .fontWeight(.bold)
                        }
                        Spacer()

                        if let image = profileImage {
                            Image(uiImage: image)
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(width: 60, height: 60)
                                .clipShape(Circle())
                                .overlay(Circle().stroke(Color.white, lineWidth: 2))
                        } else {
                            Text(initials(for: username))
                                .font(.largeTitle)
                                .foregroundColor(.white)
                                .frame(width: 60, height: 60)
                                .background(Circle().fill(Color.gray))
                                .overlay(Circle().stroke(Color.white, lineWidth: 2))
                        }
                    }
                    .padding(.horizontal, 30)
                    .padding(.top, 50)

                    // Trending Section with random city and image
                    ZStack {
                        
                        if let trendingImage = UIImage(named: trendingImageName) {
                            Image(uiImage: trendingImage)
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(width: UIScreen.main.bounds.width * 0.85, height: 120)
                                .clipped()
                                .cornerRadius(10)
                                .overlay(
                                    VStack(alignment: .leading, spacing: 10) {
                                        // Display the day number on the button
                                        Text("Recommended:")
                                            .font(.title2)
                                            .fontWeight(.black)
                                            .foregroundColor(.white)

                                        // Displays extra 'view activities' text
                                        Text(trendingCity)
                                            .font(.subheadline)
                                            .fontWeight(.heavy)
                                            .foregroundColor(.white)
                                    }
                                    .padding(.leading, 15) // Adjust padding for text
                                    .padding(.top, 20),
                                    alignment: .topLeading
                                    
                            )
                        }
                        //.frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottomLeading)
                    }
                    .padding(.horizontal, 30)
                    .padding(.top, 20)

                    // "Plan Your Next Trip" button
                    Button(action: {
                        selectedTab = .planTrip
                    }) {
                        Text("Plan Your Next Trip!")
                            .font(.headline)
                            .foregroundColor(.white)
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(LinearGradient(
                                gradient: Gradient(colors: [gradientStartColor, gradientEndColor]),
                                startPoint: .leading,
                                endPoint: .trailing)
                            )
                            .cornerRadius(10)
                            .shadow(radius: 5)
                    }
                    .padding(.horizontal, 30)
                    .padding(.top, 40)
                }

                VStack(spacing: 20) {
                    Text("Past Trips")
                        .font(.headline)
                        .foregroundColor(Color(.systemTeal))
                        .padding(.top, 20)

                    Text("View trips you recently created on TripPlanner")
                        .font(.subheadline)
                        .foregroundColor(.gray)

                    List(pastTrips, id: \.self) { trip in
                        Text(trip)
                    }
                    .listStyle(InsetGroupedListStyle())
                    .frame(height: 300)
                }
                .padding(.horizontal, 20)
                .padding(.horizontal)

                Spacer()

                // Tab Bar
                VStack {
                    Spacer()
                    HStack {
                        Spacer()
                        TabBarItem(iconName: "briefcase", label: "Past Trips", isSelected: selectedTab == .pastTrips) {
                            selectedTab = .pastTrips
                        }
                        Spacer()
                        TabBarItem(iconName: "globe", label: "Plan Trip", isSelected: selectedTab == .planTrip) {
                            selectedTab = .planTrip
                        }
                        Spacer()
                        TabBarItem(iconName: "person.fill", label: "Profile", isSelected: selectedTab == .profile) {
                            selectedTab = .profile
                        }
                        Spacer()
                        TabBarItem(iconName: "gearshape", label: "Settings", isSelected: selectedTab == .settings) {
                            selectedTab = .settings
                        }
                        Spacer()
                    }
                    .frame(height: 72)
                    .background(Color.white)
                    .cornerRadius(8)
                    .shadow(radius: 5)
                    .padding(.bottom, 5)
                }
                .edgesIgnoringSafeArea(.all)
            }
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarHidden(true)

            if selectedTab == .planTrip {
                SecondView(userUID: userUID)
            } else if selectedTab == .settings {
                SettingsView(userUID: userUID)
            }
        }
        .onAppear {
            loadUserProfile()
            loadPastTrips()
            selectRandomTrendingCity()  // Select a random city on appear
        }
    }

    private func formattedDate() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .long
        return dateFormatter.string(from: Date())
    }

    func loadUserProfile() {
        AuthService.shared.fetchUser { user, error in
            if let error = error {
                print("Error loading user data: \(error.localizedDescription)")
                return
            }
            if let user = user {
                self.username = user.username ?? "Guest"
                loadProfileImage(from: user.profileImageUrl ?? "")
            }
        }
    }

    func loadPastTrips() {
        let planController = PlanController()
        self.pastTrips = planController.getPastTrips(userUID: userUID)
    }

    func loadProfileImage(from urlString: String) {
        guard !urlString.isEmpty, let url = URL(string: urlString) else { return }
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let data = data, let uiImage = UIImage(data: data) {
                DispatchQueue.main.async {
                    self.profileImage = uiImage
                }
            }
        }.resume()
    }

    func selectRandomTrendingCity() {
        let randomCity = cities.randomElement()!
        trendingCity = randomCity.0
        trendingImageName = randomCity.1
    }

    private func TabBarItem(iconName: String, label: String, isSelected: Bool = false, action: @escaping () -> Void) -> some View {
        VStack {
            Image(systemName: iconName)
                .foregroundColor(isSelected ? .blue : .blue)
            Text(label)
                .font(.footnote)
                .foregroundColor(isSelected ? .blue : .blue)
        }
        .padding(.vertical, 10)
        .background(isSelected ? Color.blue.opacity(0.2) : Color.clear)
        .cornerRadius(10)
        .onTapGesture {
            action()
        }
    }

    private func initials(for name: String) -> String {
        let components = name.split(separator: " ")
        let initials = components.compactMap { $0.first }.map { String($0) }.joined()
        return String(initials.prefix(2)).uppercased()
    }
}

// Enum to manage different tabs
enum Tab {
    case pastTrips
    case planTrip
    case profile
    case settings
}

