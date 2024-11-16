import SwiftUI

struct SecondView: View {
    @State private var selectedCity: String = "Enter destination"
    @State private var selectedDays: Int = 5
    @State private var selectedTripTypes: Set<String> = []
    @StateObject private var planController = PlanController() // Create PlanController instance

    let daysOptions = [1, 2, 3, 4, 5, 6, 7, 8]
    let cities = ["Abuja, Nigeria", "Accra, Ghana", "Addis Ababa, Ethiopia", "Amsterdam, Netherlands", "Asunción, Paraguay", "Athens, Greece", "Auckland, New Zealand", "Austin, USA", "Bali, Indonesia", "Bangkok, Thailand", "Banjul, Gambia", "Barcelona, Spain", "Beijing, China", "Belgrade, Serbia", "Bendigo, Australia", "Berlin, Germany", "Bogota, Colombia", "Boston, USA", "Brisbane, Australia", "Buenos Aires, Argentina", "Budapest, Hungary", "Cairo, Egypt", "Calgary, Canada", "Cancun, Mexico", "Canberra, Australia", "Cape Town, South Africa", "Cartagena, Colombia", "Casablanca, Morocco", "Chennai, India", "Chicago, USA", "Colombo, Sri Lanka", "Copenhagen, Denmark", "Curitiba, Brazil", "Cusco, Peru", "Dakar, Senegal", "Delhi, India", "Dubai, UAE", "Dublin, Ireland", "Dunedin, New Zealand", "Durban, South Africa", "Edinburgh, Scotland", "Florence, Italy", "Fortaleza, Brazil", "Geneva, Switzerland", "Geelong, Australia", "Gold Coast, Australia", "Hamilton, New Zealand", "Hanoi, Vietnam", "Helsinki, Finland", "Hobart, Australia", "Ho Chi Minh City, Vietnam", "Honolulu, USA", "Hong Kong, China", "Istanbul, Turkey", "Jakarta, Indonesia", "Jerusalem, Israel", "Jamnagar, India", "Johannesburg, South Africa", "Karachi, Pakistan", "Kolkata, India", "Kuala Lumpur, Malaysia", "Kyoto, Japan", "La Paz, Bolivia", "Lagos, Nigeria", "Las Vegas, USA", "Lima, Peru", "Lisbon, Portugal", "London, England", "Los Angeles, USA", "Madrid, Spain", "Manila, Philippines", "Maldives, Maldives", "Maputo, Mozambique", "Mar del Plata, Argentina", "Marrakech, Morocco", "Melbourne, Australia", "Mendoza, Argentina", "Mexico City, Mexico", "Miami, USA", "Montevideo, Uruguay", "Montreal, Canada", "Moscow, Russia", "Mumbai, India", "Nairobi, Kenya", "Napier, New Zealand", "New Orleans, USA", "New York City, USA", "Ottawa, Canada", "Paris, France", "Perth, Australia", "Portland, USA", "Prague, Czech Republic", "Punta Cana, Dominican Republic", "Quebec City, Canada", "Queenstown, New Zealand", "Quito, Ecuador", "Rio de Janeiro, Brazil", "Rome, Italy", "Salvador, Brazil", "San Diego, USA", "San Francisco, USA", "Santorini, Greece", "Santiago, Chile", "São Paulo, Brazil", "Seattle, USA", "Shanghai, China", "Singapore, Singapore", "Stockholm, Sweden", "Suva, Fiji", "Sydney, Australia", "Tauranga, New Zealand", "Tokyo, Japan", "Toronto, Canada", "Tunis, Tunisia", "Udaipur, India", "Vancouver, Canada", "Victoria Falls, Zimbabwe/Zambia", "Vienna, Austria", "Washington, D.C., USA", "Wellington, New Zealand", "Windhoek, Namibia", "Yellowstone, USA", "Yokohama, Japan", "Zanzibar City, Tanzania", "Zurich, Switzerland"]

    let elementHeight: CGFloat = UIScreen.main.bounds.height * 0.05
    let buttonWidth: CGFloat = UIScreen.main.bounds.width * 0.75

    let gradientStartColor = Color(UIColor(red: 141/255, green: 172/255, blue: 225/255, alpha: 1))
    let gradientEndColor = Color(UIColor(red: 41/255, green: 102/255, blue: 117/255, alpha: 1))

    var userUID: String

    var body: some View {
        NavigationView {
            ZStack {
                Color.white.edgesIgnoringSafeArea(.all)

                VStack(spacing: UIScreen.main.bounds.height * 0.03) {
                    // Blue Gradient Box at the Top
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
                            .edgesIgnoringSafeArea(.top)

                        VStack {
                            Text("Where are you headed?")
                                .font(.title)
                                .foregroundColor(.white)
                                .padding(.top, UIScreen.main.bounds.height * 0.12) // Adjusted padding for better alignment

                            // Destination Menu inside the gradient box
                            Menu {
                                ForEach(cities, id: \.self) { city in
                                    Button(city) {
                                        selectedCity = city
                                        print("Selected City: \(selectedCity)")
                                    }
                                }
                            } label: {
                                HStack {
                                    Image(systemName: "magnifyingglass")
                                        .foregroundColor(.gray)
                                    Text(selectedCity)
                                        .foregroundColor(selectedCity == "Enter destination" ? .gray : .black)
                                    Spacer()
                                    Image(systemName: "chevron.down")
                                        .foregroundColor(.blue)
                                }
                                .padding()
                                .frame(width: buttonWidth, height: elementHeight)
                                .background(Color(.white))
                                .cornerRadius(UIScreen.main.bounds.width * 0.02)
                            }
                            .padding(.horizontal)
                            .padding(.top, UIScreen.main.bounds.height * 0.02) // stopped here
                        }
                    }

                    // Days Picker
                    VStack(alignment: .leading, spacing: UIScreen.main.bounds.height * 0.01) {
                        Text("Days")
                            .font(.title2.bold())
                            .foregroundColor(Color(.systemTeal))

                        Text("How many days will you be gone for?")
                            .font(.subheadline)
                            .foregroundColor(.gray)
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.leading, UIScreen.main.bounds.width * 0.132)
                    .padding(.bottom, UIScreen.main.bounds.height * 0.01)

                    Picker("How many days will you be gone for?", selection: $selectedDays) {
                        ForEach(daysOptions, id: \.self) { day in
                            Text("\(day) Days")
                        }
                    }
                    .pickerStyle(MenuPickerStyle())
                    .padding()
                    .frame(width: buttonWidth, height: elementHeight)
                    .background(Color(.white))
                    .cornerRadius(UIScreen.main.bounds.width * 0.02)
                    .overlay(
                        RoundedRectangle(cornerRadius: UIScreen.main.bounds.width * 0.02)
                            .stroke(Color(red: 96/255, green: 131/255, blue: 153/255, opacity: 255/255), lineWidth: 3)
                    )
                    .padding(.horizontal)
                    .onChange(of: selectedDays) { newValue in
                        print("Selected Days: \(selectedDays)")
                    }

                    // Trip Type Selection
                    VStack(alignment: .leading, spacing: UIScreen.main.bounds.height * 0.01) {
                        Text("Trip Type")
                            .font(.title2.bold())
                            .foregroundColor(Color(.systemTeal))

                        Text("What kind of trip do you want to go on?")
                            .font(.subheadline)
                            .foregroundColor(.gray)
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.leading, UIScreen.main.bounds.width * 0.132)
                    .padding(.bottom, UIScreen.main.bounds.height * 0.01)

                    VStack(spacing: UIScreen.main.bounds.height * 0.01) {
                        HStack(spacing: UIScreen.main.bounds.width * 0.02) {
                            tripTypeButton(title: "Adventurous")
                            tripTypeButton(title: "Relaxing")
                        }
                        HStack(spacing: UIScreen.main.bounds.width * 0.02) {
                            tripTypeButton(title: "Party")
                            tripTypeButton(title: "Historical")
                        }
                    }
                    .frame(width: buttonWidth)

                    // NavigationLink to ItineraryView
                    NavigationLink(
                        destination: ItineraryView(
                            location: selectedCity,
                            days: selectedDays,
                            userUID: userUID,
                            selectedTripType: selectedTripTypes.first ?? "Relaxing",  // Pass the selected trip type
                            planController: planController
                        )
                    ) {
                        Text("Plan Your Next Trip!")
                            .font(.headline)
                            .padding()
                            .frame(width: buttonWidth, height: elementHeight)
                            .background(Color.teal)
                            .foregroundColor(.white)
                            .cornerRadius(UIScreen.main.bounds.width * 0.02)
                    }
                    .padding(.horizontal)

                    Spacer()

                    // Tab Bar
                    HStack {
                        Spacer()
                        TabBarItem(iconName: "briefcase", label: "Past Trips", userUID: userUID)
                        Spacer()
                        TabBarItem(iconName: "globe", label: "Plan Trip", isSelected: true, userUID: userUID)
                        Spacer()
                        TabBarItem(iconName: "person", label: "Profile", userUID: userUID)
                        Spacer()
                        TabBarItem(iconName: "gearshape", label: "Settings", userUID: userUID)
                        Spacer()
                    }
                    .frame(height: UIScreen.main.bounds.height * 0.1) // Dynamic height
                    .background(Color.white)
                    .cornerRadius(UIScreen.main.bounds.width * 0.02)
                    .shadow(radius: UIScreen.main.bounds.width * 0.01)
                    .padding(.bottom, UIScreen.main.bounds.height * 0.01)
                } // here
                .edgesIgnoringSafeArea(.bottom)
                .onAppear {
                    resetUserInputs()  // Reset inputs when the view appears
                    resetPlanController()  // Clear previous trip data only when on the Plan Trip screen
                }
            }
        }
    }

    // Helper function to reset user inputs
    private func resetUserInputs() {
        selectedCity = "Enter destination"  // Reset destination
        selectedDays = 5  // Reset days to the default value
        selectedTripTypes = []  // Clear trip types
    }

    // Reset the plan controller (clear previous trip data)
    private func resetPlanController() {
        planController.locationActivitiesByDay = []  // Clear previous activities
        planController.isLoading = false  // Stop loading
        planController.hasGeneratedActivities = false  // Mark activities as not generated yet
        print("Previous search data cleared and ready for new search.")
    }

    // Custom button view for trip types
    private func tripTypeButton(title: String) -> some View {
        Text(title)
            .font(.headline)
            .padding()
            .frame(width: (buttonWidth - 10) / 2, height: elementHeight)
            .background(selectedTripTypes.contains(title) ? Color(red: 96/255, green: 131/255, blue: 153/255) : Color(red: 200/255, green: 228/255, blue: 250/255))
            .foregroundColor(selectedTripTypes.contains(title) ? Color.white : Color.black)
            .cornerRadius(8)
            .onTapGesture {
                if selectedTripTypes.contains(title) {
                    selectedTripTypes.remove(title)
                } else {
                    selectedTripTypes.insert(title)
                }
                print("Selected Trip Types: \(selectedTripTypes)")
            }
    }

    // Tab Bar item creation helper
    private func TabBarItem(iconName: String, label: String, isSelected: Bool = false, userUID: String) -> some View {
        VStack {
            Image(systemName: iconName)
                .foregroundColor(isSelected ? gradientEndColor : .blue)
            Text(label)
                .font(.footnote)
                .foregroundColor(isSelected ? gradientEndColor : .blue)
        }
        .padding(.vertical, 10)
        .background(isSelected ? gradientEndColor.opacity(0.2) : Color.clear)
        .cornerRadius(10)
        .onTapGesture {
            switch label {
            case "Plan Trip":
                resetPlanController()  // Clear the previous trip when navigating to the Plan Trip tab
            case "Past Trips":
                if let window = UIApplication.shared.windows.first {
                    window.rootViewController = UIHostingController(rootView: PastTripsView(userUID: userUID))
                    window.makeKeyAndVisible()
                }
            case "Settings":
                if let window = UIApplication.shared.windows.first {
                    window.rootViewController = UIHostingController(rootView: SettingsView(userUID: userUID))
                    window.makeKeyAndVisible()
                }
            default:
                break
            }
        }
    }
}

