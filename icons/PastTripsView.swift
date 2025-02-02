//import SwiftUI
//
//struct PastTripsView: View {
//    let gradientStartColor = Color(UIColor(red: 141/255, green: 172/255, blue: 225/255, alpha: 1))
//    let gradientEndColor = Color(UIColor(red: 41/255, green: 102/255, blue: 117/255, alpha: 1))
//
//    @State private var selectedTab: Tab = .pastTrips
//    @State private var pastTrips: [String] = []
//    @State private var profileImage: UIImage? = nil
//    var userUID: String
//    @State private var username: String = ""
//    @State private var trendingCity: String = "Santorini"  // Default value
//    @State private var trendingImageName: String = "santorini"  // Default image
//
//    // Define a responsive height based on screen height
//    let buttonHeight: CGFloat = UIScreen.main.bounds.height * 0.1 // 10% of screen height
//    let buttonWidth: CGFloat = UIScreen.main.bounds.width * 0.85 // 85% of screen width
//
//    // Cities and corresponding images
//    let cities = [
//        ("Los Angeles, USA", "losangelesday1"),
//        ("Honolulu, USA", "honoluluday1"),
//        ("Paris, France", "parisday1"),
//        ("Santorini, Greece", "santoriniday1"),
//        ("Mumbai, India", "mumbaiday1"),
//        ("Shanghai, China", "shanghaiday1"),
//        ("Tokyo, Japan", "tokyoday1"),
//        ("New York City, USA", "newyorkcityday1"),
//        ("Cancun, Mexico", "cancunday1"),
//        ("London, England", "londonday1")
//    ]
//
//    var body: some View {
//            NavigationView {
//                ZStack {
//                    Color.white.edgesIgnoringSafeArea(.all)
//                    ScrollView {
//                    VStack(spacing: 0) {
//                        VStack(spacing: UIScreen.main.bounds.height * 0.012) {
//                            HStack {
//                                VStack(alignment: .leading) {
//                                    Text("\(formattedDate())")
//                                        .foregroundColor(.gray)
//                                        .font(.subheadline)
//                                    Text("Welcome, \(username)!")
//                                        .font(.title2.bold())
//                                        .foregroundColor(Color(.systemTeal))
//                                        .fontWeight(.bold)
//                                }
//                                Spacer()
//                                
//                                if let image = profileImage {
//                                    Image(uiImage: image)
//                                        .resizable()
//                                        .aspectRatio(contentMode: .fill)
//                                        .frame(width: UIScreen.main.bounds.width * 0.15, height: UIScreen.main.bounds.width * 0.15)
//                                        .clipShape(Circle())
//                                        .overlay(Circle().stroke(Color.white, lineWidth: 2))
//                                } else {
//                                    Text(initials(for: username))
//                                        .font(.largeTitle)
//                                        .foregroundColor(.white)
//                                        .frame(width: UIScreen.main.bounds.width * 0.15, height: UIScreen.main.bounds.width * 0.15)
//                                        .background(Circle().fill(Color.gray))
//                                        .overlay(Circle().stroke(Color.white, lineWidth: 2))
//                                }
//                            }
//                            .padding(.horizontal, UIScreen.main.bounds.width * 0.08) // 30 points = ~8% of screen width
//                            .padding(.top, UIScreen.main.bounds.height * 0.06)
//                            
//                            // cur
//                            
//                            // Trending Section with random city and image
//                            ZStack {
//                                if let trendingImage = UIImage(named: trendingImageName) {
//                                    Image(uiImage: trendingImage)
//                                        .resizable()
//                                        .aspectRatio(contentMode: .fill)
//                                        .frame(width: UIScreen.main.bounds.width * 0.85, height: UIScreen.main.bounds.height * 0.15)
//                                        .clipped()
//                                        .cornerRadius(UIScreen.main.bounds.width * 0.025)
//                                        .overlay(
//                                            VStack(alignment: .leading, spacing: UIScreen.main.bounds.height * 0.012) {
//                                                Text("Recommended:")
//                                                    .font(.title2)
//                                                    .fontWeight(.black)
//                                                    .foregroundColor(.white)
//                                                
//                                                Text(trendingCity)
//                                                    .font(.subheadline)
//                                                    .fontWeight(.heavy)
//                                                    .foregroundColor(.white)
//                                            }
//                                            .padding(.leading, UIScreen.main.bounds.width * 0.04)
//                                            .padding(.top, UIScreen.main.bounds.height * 0.025),
//                                            alignment: .topLeading
//                                        )
//                                }
//                            }
//                            .padding(.horizontal, UIScreen.main.bounds.width * 0.08) // 30 points as ~8% of screen width
//                            .padding(.top, UIScreen.main.bounds.height * 0.025)
//                            
//                            // "Plan Your Next Trip" button
//                            Button(action: {
//                                selectedTab = .planTrip
//                            }) {
//                                Text("Plan Your Next Trip!")
//                                    .font(.headline)
//                                    .foregroundColor(.white)
//                                    .padding()
//                                    .frame(maxWidth: .infinity)
//                                    .background(LinearGradient(
//                                        gradient: Gradient(colors: [gradientStartColor, gradientEndColor]),
//                                        startPoint: .leading,
//                                        endPoint: .trailing)
//                                    )
//                                    .cornerRadius(UIScreen.main.bounds.width * 0.025) // 10 points as ~2.5% of screen width
//                                    .shadow(radius: UIScreen.main.bounds.width * 0.013)
//                            }
//                            .padding(.horizontal, UIScreen.main.bounds.width * 0.08) // 30 points as ~8% of screen width
//                            .padding(.top, UIScreen.main.bounds.height * 0.05)
//                        }
//                        
//                        // Adjust the Spacer here to take up the available space
//                        Spacer(minLength: UIScreen.main.bounds.height * 0.06)
//                        
//                        // Past Trips Section
//                        VStack(spacing: UIScreen.main.bounds.height * 0.025) {
//                            Text("Past Trips")
//                                .font(.title2.bold())
//                                .foregroundColor(Color(.systemTeal))
//                                .padding(.top, UIScreen.main.bounds.height * 0.024)
//                            
//                            Text("View trips you recently created on TripPlanner")
//                                .font(.subheadline)
//                                .foregroundColor(.gray)
//                            
//                            // ScrollView for past trips
//                            //ScrollView {
//                            VStack(spacing: UIScreen.main.bounds.height * 0.012) {
//                                ForEach(pastTrips, id: \.self) { trip in
//                                    let components = trip.components(separatedBy: " - ")
//                                    let location = components[0].replacingOccurrences(of: "Trip to ", with: "")
//                                    let cityName = location.split(separator: ",")[0].lowercased().replacingOccurrences(of: " ", with: "")
//                                    let dayAndType = components[1].replacingOccurrences(of: " days", with: "").components(separatedBy: " (")
//                                    let days = Int(dayAndType[0]) ?? 5
//                                    let type = dayAndType[1].replacingOccurrences(of: ")", with: "")
//                                    
//                                    let imageName = "\(cityName)day\(days)"
//                                    
//                                    NavigationLink(
//                                        destination: ItineraryView(location: location, days: days, userUID: userUID, selectedTripType: type, planController: PlanController())
//                                    ) {
//                                        ZStack {
//                                            // Full background image
//                                            Image(imageName)
//                                                .resizable()
//                                                .scaledToFill()
//                                                .frame(width: buttonWidth, height: buttonHeight)
//                                                .clipped() // Ensures the image does not overflow the button
//                                            
//                                            // Overlay content
//                                            HStack {
//                                                VStack(alignment: .leading) {
//                                                    Text(trip)
//                                                        .font(.headline)
//                                                        .fontWeight(.bold)
//                                                        .foregroundColor(.white) // Make text visible on image background
//                                                        .frame(maxWidth: .infinity, alignment: .center)
//                                                }
//                                                .padding(.leading, UIScreen.main.bounds.width * 0.04)
//                                                Spacer()
//                                                Image(systemName: "chevron.right")
//                                                    .foregroundColor(.white)
//                                                    .padding(.trailing, UIScreen.main.bounds.width * 0.04)
//                                            }
//                                            .padding()
//                                        }
//                                        .frame(width: buttonWidth, height: buttonHeight)
//                                        .background(Color(.systemGray6).opacity(0.2)) // Optional overlay for contrast
//                                        .cornerRadius(UIScreen.main.bounds.width * 0.025)
//                                        .shadow(radius: UIScreen.main.bounds.width * 0.01)
//                                        .padding(.horizontal, UIScreen.main.bounds.width * 0.05)
//                                        .padding(.top, UIScreen.main.bounds.height * 0.005)
//                                    }
//                                }
//                            }}
//                            
//                            .frame(maxHeight: .infinity) // Ensure ScrollView takes full available space
//                            .padding()
//                            .background(Color.white)
//                            .cornerRadius(UIScreen.main.bounds.width * 0.06) // Responsive corner radius (6% of screen width)
//                            .padding(.top, UIScreen.main.bounds.height * -0.06) // Responsive top padding for overlap effect
//                            .padding(.bottom, UIScreen.main.bounds.height * 0.06)
//                        }
//                        Spacer()
//                    }
//                    
//                    // Tab Bar
//                    VStack {
//                        Spacer()
//                        HStack {
//                            Spacer()
//                            TabBarItem(iconName: "briefcase", label: "Past Trips", isSelected: selectedTab == .pastTrips) {
//                                selectedTab = .pastTrips
//                            }
//                            Spacer()
//                            TabBarItem(iconName: "globe", label: "Plan Trip", isSelected: selectedTab == .planTrip) {
//                                selectedTab = .planTrip
//                            }
//                            Spacer()
//                            TabBarItem(iconName: "person.fill", label: "Profile", isSelected: selectedTab == .profile) {
//                                selectedTab = .profile
//                            }
//                            Spacer()
//                            TabBarItem(iconName: "gearshape", label: "Settings", isSelected: selectedTab == .settings) {
//                                selectedTab = .settings
//                            }
//                            Spacer()
//                        }
//                        .frame(height: UIScreen.main.bounds.height * 0.09) // Responsive tab bar height
//                        .background(Color.white)
//                        .cornerRadius(UIScreen.main.bounds.width * 0.02) // Responsive corner radius
//                        .shadow(radius: UIScreen.main.bounds.width * 0.015) // Responsive shadow radius
//                        .padding(.bottom, UIScreen.main.bounds.height * 0.01)
//                    }
//                    .edgesIgnoringSafeArea(.all)
//                    
//                    if selectedTab == .planTrip {
//                        SecondView(userUID: userUID)
//                    } else if selectedTab == .settings {
//                        SettingsView(userUID: userUID)
//                    }
//                }
//                .onAppear {
//                    loadUserProfile()
//                    loadPastTrips()
//                    selectRandomTrendingCity()  // Select a random city on appear
//                }
//            }
//        } // done responsiveness till here
//
//    private func formattedDate() -> String {
//        let dateFormatter = DateFormatter()
//        dateFormatter.dateStyle = .long
//        return dateFormatter.string(from: Date())
//    }
//
//    func loadUserProfile() {
//        AuthService.shared.fetchUser { user, error in
//            if let error = error {
//                print("Error loading user data: \(error.localizedDescription)")
//                return
//            }
//            if let user = user {
//                self.username = user.username ?? "Guest"
//                loadProfileImage(from: user.profileImageUrl ?? "")
//            }
//        }
//    }
//
//    func loadPastTrips() {
//        let planController = PlanController()
//        self.pastTrips = planController.getPastTrips(userUID: userUID)
//    }
//
//    func loadProfileImage(from urlString: String) {
//        guard !urlString.isEmpty, let url = URL(string: urlString) else { return }
//        URLSession.shared.dataTask(with: url) { data, response, error in
//            if let data = data, let uiImage = UIImage(data: data) {
//                DispatchQueue.main.async {
//                    self.profileImage = uiImage
//                }
//            }
//        }.resume()
//    }
//
//    func selectRandomTrendingCity() {
//        let randomCity = cities.randomElement()!
//        trendingCity = randomCity.0
//        trendingImageName = randomCity.1
//    }
//
//    private func TabBarItem(iconName: String, label: String, isSelected: Bool = false, action: @escaping () -> Void) -> some View {
//        VStack {
//            Image(systemName: iconName)
//                .foregroundColor(isSelected ? .blue : .blue)
//                .frame(width: UIScreen.main.bounds.width * 0.1, height: UIScreen.main.bounds.height * 0.05) // Responsive icon size
//            Text(label)
//                .font(.footnote)
//                .foregroundColor(isSelected ? .blue : .blue)
//                .padding(.top, UIScreen.main.bounds.height * 0.005) // Responsive padding
//        }
//        .padding(.vertical, UIScreen.main.bounds.height * 0.01) // Responsive vertical padding
//        .padding(.horizontal, UIScreen.main.bounds.width * 0.02) // Responsive horizontal padding
//        .background(isSelected ? Color.blue.opacity(0.2) : Color.clear)
//        .cornerRadius(UIScreen.main.bounds.width * 0.025) // Responsive corner radius
//        .onTapGesture {
//            action()
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
//// Enum to manage different tabs
//enum Tab {
//    case pastTrips
//    case planTrip
//    case profile
//    case settings
//}
//





import SwiftUI

struct PastTripsView: View {
    let gradientStartColor = Color(UIColor(red: 141/255, green: 172/255, blue: 225/255, alpha: 1))
    let gradientEndColor = Color(UIColor(red: 41/255, green: 102/255, blue: 117/255, alpha: 1))

    @EnvironmentObject var appState: AppState
    @State private var pastTrips: [String] = []
    @State private var profileImage: UIImage? = nil
    var userUID: String
    @State private var username: String = ""
    @State private var trendingCity: String = "Santorini"  // Default value
    @State private var trendingImageName: String = "santorini"  // Default image
    
    @State private var expandedTrips: [String: Bool] = [:] // Track expanded state by trip

    // Define a responsive height based on screen height
    let buttonHeight: CGFloat = UIScreen.main.bounds.height * 0.1 // 10% of screen height
    let buttonWidth: CGFloat = UIScreen.main.bounds.width * 0.85 // 85% of screen width

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
                ScrollView {
                    VStack(spacing: 0) {
                        VStack(spacing: UIScreen.main.bounds.height * 0.012) {
                            HStack {
                                VStack(alignment: .leading) {
                                    Text("\(formattedDate())")
                                        .foregroundColor(.gray)
                                        .font(.subheadline)
                                    Text("Welcome, \(username)!")
                                        .font(.title2.bold())
                                        .foregroundColor(Color(.systemTeal))
                                        .fontWeight(.bold)
                                }
                                Spacer()
                                
                                if let image = profileImage {
                                    Image(uiImage: image)
                                        .resizable()
                                        .aspectRatio(contentMode: .fill)
                                        .frame(width: UIScreen.main.bounds.width * 0.15, height: UIScreen.main.bounds.width * 0.15)
                                        .clipShape(Circle())
                                        .overlay(Circle().stroke(Color.white, lineWidth: 2))
                                } else {
                                    Text(initials(for: username))
                                        .font(.largeTitle)
                                        .foregroundColor(.white)
                                        .frame(width: UIScreen.main.bounds.width * 0.15, height: UIScreen.main.bounds.width * 0.15)
                                        .background(Circle().fill(Color.gray))
                                        .overlay(Circle().stroke(Color.white, lineWidth: 2))
                                }
                            }
                            .padding(.horizontal, UIScreen.main.bounds.width * 0.08) // 30 points = ~8% of screen width
                            .padding(.top, UIScreen.main.bounds.height * 0.06)
                            
                            // cur
                            
                            // Trending Section with random city and image
                            ZStack {
                                if let trendingImage = UIImage(named: trendingImageName) {
                                    Image(uiImage: trendingImage)
                                        .resizable()
                                        .aspectRatio(contentMode: .fill)
                                        .frame(width: UIScreen.main.bounds.width * 0.85, height: UIScreen.main.bounds.height * 0.15)
                                        .clipped()
                                        .cornerRadius(UIScreen.main.bounds.width * 0.025)
                                        .overlay(
                                            VStack(alignment: .leading, spacing: UIScreen.main.bounds.height * 0.012) {
                                                Text("Recommended:")
                                                    .font(.title2)
                                                    .fontWeight(.black)
                                                    .foregroundColor(.white)
                                                
                                                Text(trendingCity)
                                                    .font(.subheadline)
                                                    .fontWeight(.heavy)
                                                    .foregroundColor(.white)
                                            }
                                            .padding(.leading, UIScreen.main.bounds.width * 0.04)
                                            .padding(.top, UIScreen.main.bounds.height * 0.025),
                                            alignment: .topLeading
                                        )
                                }
                            }
                            .padding(.horizontal, UIScreen.main.bounds.width * 0.08) // 30 points as ~8% of screen width
                            .padding(.top, UIScreen.main.bounds.height * 0.025)
                            
                            // "Plan Your Next Trip" button
                            Button(action: {
                                appState.selectedTab = .planTrip
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
                                    .cornerRadius(UIScreen.main.bounds.width * 0.025)
                                    .shadow(radius: UIScreen.main.bounds.width * 0.013)
                            }
                            .padding(.horizontal, UIScreen.main.bounds.width * 0.08) // 30 points as ~8% of screen width
                            .padding(.top, UIScreen.main.bounds.height * 0.05)
                        }
                        
                        // Adjust the Spacer here to take up the available space
                        Spacer(minLength: UIScreen.main.bounds.height * 0.06)
                        
                        // Past Trips Section
                        VStack(spacing: UIScreen.main.bounds.height * 0.025) {
                            Text("Past Trips")
                                .font(.title2.bold())
                                .foregroundColor(Color(.systemTeal))
                                .padding(.top, UIScreen.main.bounds.height * 0.024)
                            
                            Text("View trips you recently created on TripPlanner")
                                .font(.subheadline)
                                .foregroundColor(.gray)
                            
                            // ScrollView for past trips
                            VStack(spacing: UIScreen.main.bounds.height * 0.012) {
                                // Filter valid trips before passing them to ForEach
                                ForEach(pastTrips.filter { trip in
                                    let components = trip.components(separatedBy: " - ")
                                    return components.count == 2 && components[1].contains("days") && components[1].contains("(")
                                }, id: \.self) { trip in
                                    let components = trip.components(separatedBy: " - ")
                                    let location = components[0].replacingOccurrences(of: "Trip to ", with: "").trimmingCharacters(in: .whitespacesAndNewlines)
                                    let cityName = location.split(separator: ",")[0].lowercased().replacingOccurrences(of: " ", with: "")
                                    let dayAndType = components[1].replacingOccurrences(of: " days", with: "").components(separatedBy: " (")
                                    let days = Int(dayAndType[0].trimmingCharacters(in: .whitespacesAndNewlines)) ?? 5
                                    let types = dayAndType[1].replacingOccurrences(of: ")", with: "").trimmingCharacters(in: .whitespacesAndNewlines)

                                    let imageName = "\(cityName)day\(days)"
                                    
                                    NavigationLink(
                                        destination: ItineraryView(location: location, days: days, userUID: userUID, selectedTripType: types, planController: PlanController())
                                    ) {
                                        ZStack {
                                            // Full background image
                                            Image(imageName)
                                                .resizable()
                                                .scaledToFill()
                                                .frame(width: buttonWidth, height: buttonHeight)
                                                .clipped() // Ensures the image does not overflow the button
                                            
                                            // Overlay content
                                            HStack {
                                                VStack(alignment: .leading) {
                                                    Text(location)
                                                        .font(.title3)
                                                        .fontWeight(.bold)
                                                        .foregroundColor(.white)

                                                    Text("\(days) \(days == 1 ? "day" : "days")")
                                                        .font(.body)
                                                        .fontWeight(.semibold)
                                                        .foregroundColor(.white)

                                                    Text(types)
                                                        .font(.footnote)
                                                        .foregroundColor(.white)
                                                        .lineLimit(2)
                                                        .truncationMode(.tail)
                                                }
                                                .padding(.leading, UIScreen.main.bounds.width * 0.04)
                                                Spacer()
                                                Image(systemName: "chevron.right")
                                                    .foregroundColor(.white)
                                                    .padding(.trailing, UIScreen.main.bounds.width * 0.04)
                                            }
                                            .padding()
                                        }
                                        .frame(width: buttonWidth, height: buttonHeight)
                                        .background(Color(.systemGray6).opacity(0.2)) // Optional overlay for contrast
                                        .cornerRadius(UIScreen.main.bounds.width * 0.025)
                                        .shadow(radius: UIScreen.main.bounds.width * 0.01)
                                        .padding(.horizontal, UIScreen.main.bounds.width * 0.05)
                                        .padding(.top, UIScreen.main.bounds.height * 0.005)
                                    }
                                }
                            }
                        }
                        .frame(maxHeight: .infinity) // Ensure ScrollView takes full available space
                        .padding()
                        .background(Color.white)
                        .cornerRadius(UIScreen.main.bounds.width * 0.06) // Responsive corner radius (6% of screen width)
                        .padding(.top, UIScreen.main.bounds.height * -0.06) // Responsive top padding for overlap effect
                        .padding(.bottom, UIScreen.main.bounds.height * 0.06)
                    }
                    Spacer()
                }
                .edgesIgnoringSafeArea(.all)
                .onAppear {
                    loadUserProfile()
                    loadPastTrips()
                    selectRandomTrendingCity()  // Select a random city on appear
                }
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
    case settings
}
func changeTab(index: Int) {
    if let scene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
       let window = scene.windows.first,
       let tabBar = window.rootViewController as? UITabBarController {
        tabBar.selectedIndex = index
    }
}
class AppState: ObservableObject {
    @Published var selectedTab: Tab = .pastTrips
}

