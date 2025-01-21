//// OG WORKING
//import SwiftUI
//
//struct SecondView: View {
//    @State private var selectedCity: String = "Enter destination"
//    @State private var selectedDays: Int = 5
//    @State private var selectedTripTypes: Set<String> = []
//    @StateObject private var planController = PlanController() // Create PlanController instance
//
//    let daysOptions = [1, 2, 3, 4, 5, 6, 7, 8]
//    let cities = ["Abuja, Nigeria", "Accra, Ghana", "Addis Ababa, Ethiopia", "Amsterdam, Netherlands", "Asunción, Paraguay", "Athens, Greece", "Auckland, New Zealand", "Austin, USA", "Bali, Indonesia", "Bangkok, Thailand", "Banjul, Gambia", "Barcelona, Spain", "Beijing, China", "Belgrade, Serbia", "Bendigo, Australia", "Berlin, Germany", "Bogota, Colombia", "Boston, USA", "Brisbane, Australia", "Buenos Aires, Argentina", "Budapest, Hungary", "Cairo, Egypt", "Calgary, Canada", "Cancun, Mexico", "Canberra, Australia", "Cape Town, South Africa", "Cartagena, Colombia", "Casablanca, Morocco", "Chennai, India", "Chicago, USA", "Colombo, Sri Lanka", "Copenhagen, Denmark", "Curitiba, Brazil", "Cusco, Peru", "Dakar, Senegal", "Delhi, India", "Dubai, UAE", "Dublin, Ireland", "Dunedin, New Zealand", "Durban, South Africa", "Edinburgh, Scotland", "Florence, Italy", "Fortaleza, Brazil", "Geneva, Switzerland", "Geelong, Australia", "Gold Coast, Australia", "Hamilton, New Zealand", "Hanoi, Vietnam", "Helsinki, Finland", "Hobart, Australia", "Ho Chi Minh City, Vietnam", "Honolulu, USA", "Hong Kong, China", "Istanbul, Turkey", "Jakarta, Indonesia", "Jerusalem, Israel", "Jamnagar, India", "Johannesburg, South Africa", "Karachi, Pakistan", "Kolkata, India", "Kuala Lumpur, Malaysia", "Kyoto, Japan", "La Paz, Bolivia", "Lagos, Nigeria", "Las Vegas, USA", "Lima, Peru", "Lisbon, Portugal", "London, England", "Los Angeles, USA", "Madrid, Spain", "Manila, Philippines", "Maldives, Maldives", "Maputo, Mozambique", "Mar del Plata, Argentina", "Marrakech, Morocco", "Melbourne, Australia", "Mendoza, Argentina", "Mexico City, Mexico", "Miami, USA", "Montevideo, Uruguay", "Montreal, Canada", "Moscow, Russia", "Mumbai, India", "Nairobi, Kenya", "Napier, New Zealand", "New Orleans, USA", "New York City, USA", "Ottawa, Canada", "Paris, France", "Perth, Australia", "Portland, USA", "Prague, Czech Republic", "Punta Cana, Dominican Republic", "Quebec City, Canada", "Queenstown, New Zealand", "Quito, Ecuador", "Rio de Janeiro, Brazil", "Rome, Italy", "Salvador, Brazil", "San Diego, USA", "San Francisco, USA", "Santorini, Greece", "Santiago, Chile", "São Paulo, Brazil", "Seattle, USA", "Shanghai, China", "Singapore, Singapore", "Stockholm, Sweden", "Suva, Fiji", "Sydney, Australia", "Tauranga, New Zealand", "Tokyo, Japan", "Toronto, Canada", "Tunis, Tunisia", "Udaipur, India", "Vancouver, Canada", "Victoria Falls, Zimbabwe/Zambia", "Vienna, Austria", "Washington, D.C., USA", "Wellington, New Zealand", "Windhoek, Namibia", "Yellowstone, USA", "Yokohama, Japan", "Zanzibar City, Tanzania", "Zurich, Switzerland"]
//
//    let elementHeight: CGFloat = UIScreen.main.bounds.height * 0.05
//    let buttonWidth: CGFloat = UIScreen.main.bounds.width * 0.75
//
//    let gradientStartColor = Color(UIColor(red: 141/255, green: 172/255, blue: 225/255, alpha: 1))
//    let gradientEndColor = Color(UIColor(red: 41/255, green: 102/255, blue: 117/255, alpha: 1))
//
//    var userUID: String
//
//    var body: some View {
//        NavigationView {
//            ZStack {
//                Color.white.edgesIgnoringSafeArea(.all)
//
//                VStack(spacing: UIScreen.main.bounds.height * 0.03) {
//                    // Blue Gradient Box at the Top
//                    ZStack(alignment: .top) {
//                        RoundedRectangle(cornerRadius: UIScreen.main.bounds.width * 0.08, style: .continuous)
//                            .fill(
//                                LinearGradient(
//                                    gradient: Gradient(colors: [gradientStartColor, gradientEndColor]),
//                                    startPoint: .top,
//                                    endPoint: .bottom
//                                )
//                            )
//                            .frame(height: UIScreen.main.bounds.height * 0.4)
//                            .padding(.top, -UIScreen.main.bounds.height * 0.05)
//                            .edgesIgnoringSafeArea(.top)
//
//                        VStack {
//                            Text("Where are you headed?")
//                                .font(.title)
//                                .foregroundColor(.white)
//                                .padding(.top, UIScreen.main.bounds.height * 0.12) // Adjusted padding for better alignment
//
//                            // Destination Menu inside the gradient box
//                            Menu {
//                                ForEach(cities, id: \.self) { city in
//                                    Button(city) {
//                                        selectedCity = city
//                                        print("Selected City: \(selectedCity)")
//                                    }
//                                }
//                            } label: {
//                                HStack {
//                                    Image(systemName: "magnifyingglass")
//                                        .foregroundColor(.gray)
//                                    Text(selectedCity)
//                                        .foregroundColor(selectedCity == "Enter destination" ? .gray : .black)
//                                    Spacer()
//                                    Image(systemName: "chevron.down")
//                                        .foregroundColor(.blue)
//                                }
//                                .padding()
//                                .frame(width: buttonWidth, height: elementHeight)
//                                .background(Color(.white))
//                                .cornerRadius(UIScreen.main.bounds.width * 0.02)
//                            }
//                            .padding(.horizontal)
//                            .padding(.top, UIScreen.main.bounds.height * 0.02) // stopped here
//                        }
//                    }
//
//                    // Days Picker
//                    VStack(alignment: .leading, spacing: UIScreen.main.bounds.height * 0.01) {
//                        Text("Days")
//                            .font(.title2.bold())
//                            .foregroundColor(Color(.systemTeal))
//
//                        Text("How many days will you be gone for?")
//                            .font(.subheadline)
//                            .foregroundColor(.gray)
//                    }
//                    .frame(maxWidth: .infinity, alignment: .leading)
//                    .padding(.leading, UIScreen.main.bounds.width * 0.132)
//                    .padding(.bottom, UIScreen.main.bounds.height * 0.01)
//
//                    Picker("How many days will you be gone for?", selection: $selectedDays) {
//                        ForEach(daysOptions, id: \.self) { day in
//                            Text("\(day) Days")
//                        }
//                    }
//                    .pickerStyle(MenuPickerStyle())
//                    .padding()
//                    .frame(width: buttonWidth, height: elementHeight)
//                    .background(Color(.white))
//                    .cornerRadius(UIScreen.main.bounds.width * 0.02)
//                    .overlay(
//                        RoundedRectangle(cornerRadius: UIScreen.main.bounds.width * 0.02)
//                            .stroke(Color(red: 96/255, green: 131/255, blue: 153/255, opacity: 255/255), lineWidth: 3)
//                    )
//                    .padding(.horizontal)
//                    .onChange(of: selectedDays) { newValue in
//                        print("Selected Days: \(selectedDays)")
//                    }
//
//                    // Trip Type Selection
//                    VStack(alignment: .leading, spacing: UIScreen.main.bounds.height * 0.01) {
//                        Text("Trip Type")
//                            .font(.title2.bold())
//                            .foregroundColor(Color(.systemTeal))
//
//                        Text("What kind of trip do you want to go on?")
//                            .font(.subheadline)
//                            .foregroundColor(.gray)
//                    }
//                    .frame(maxWidth: .infinity, alignment: .leading)
//                    .padding(.leading, UIScreen.main.bounds.width * 0.132)
//                    .padding(.bottom, UIScreen.main.bounds.height * 0.01)
//
//                    VStack(spacing: UIScreen.main.bounds.height * 0.01) {
//                        HStack(spacing: UIScreen.main.bounds.width * 0.02) {
//                            tripTypeButton(title: "Adventurous")
//                            tripTypeButton(title: "Relaxing")
//                        }
//                        HStack(spacing: UIScreen.main.bounds.width * 0.02) {
//                            tripTypeButton(title: "Party")
//                            tripTypeButton(title: "Historical")
//                        }
//                    }
//                    .frame(width: buttonWidth)
//
//                    // NavigationLink to ItineraryView
//                    NavigationLink(
//                        destination: ItineraryView(
//                            location: selectedCity,
//                            days: selectedDays,
//                            userUID: userUID,
//                            //selectedTripType: selectedTripTypes.first ?? "Relaxing",  // Pass the selected trip type
//                            selectedTripType: selectedTripTypes.joined(separator: ", "), // Pass all selected filters
//                            planController: planController
//                        )
//                    ) {
//                        Text("Plan Your Next Trip!")
//                            .font(.headline)
//                            .padding()
//                            .frame(width: buttonWidth, height: elementHeight)
//                            .background(Color.teal)
//                            .foregroundColor(.white)
//                            .cornerRadius(UIScreen.main.bounds.width * 0.02)
//                    }
//                    .padding(.horizontal)
//
//                    Spacer()
//
//                    // Tab Bar
//                    HStack {
//                        Spacer()
//                        TabBarItem(iconName: "briefcase", label: "Past Trips", userUID: userUID)
//                        Spacer()
//                        TabBarItem(iconName: "globe", label: "Plan Trip", isSelected: true, userUID: userUID)
//                        Spacer()
//                        TabBarItem(iconName: "person", label: "Profile", userUID: userUID)
//                        Spacer()
//                        TabBarItem(iconName: "gearshape", label: "Settings", userUID: userUID)
//                        Spacer()
//                    }
//                    .frame(height: UIScreen.main.bounds.height * 0.1) // Dynamic height
//                    .background(Color.white)
//                    .cornerRadius(UIScreen.main.bounds.width * 0.02)
//                    .shadow(radius: UIScreen.main.bounds.width * 0.01)
//                    .padding(.bottom, UIScreen.main.bounds.height * 0.01)
//                } // here
//                .edgesIgnoringSafeArea(.bottom)
//                .onAppear {
//                    resetUserInputs()  // Reset inputs when the view appears
//                    resetPlanController()  // Clear previous trip data only when on the Plan Trip screen
//                }
//            }
//        }
//    }
//
//    // Helper function to reset user inputs
//    private func resetUserInputs() {
//        selectedCity = "Enter destination"  // Reset destination
//        selectedDays = 5  // Reset days to the default value
//        selectedTripTypes = []  // Clear trip types
//    }
//
//    // Reset the plan controller (clear previous trip data)
//    private func resetPlanController() {
//        planController.locationActivitiesByDay = []  // Clear previous activities
//        planController.isLoading = false  // Stop loading
//        planController.hasGeneratedActivities = false  // Mark activities as not generated yet
//        print("Previous search data cleared and ready for new search.")
//    }
//
//    // Custom button view for trip types
//    private func tripTypeButton(title: String) -> some View {
//        Text(title)
//            .font(.headline)
//            .padding()
//            .frame(width: (buttonWidth - 10) / 2, height: elementHeight)
//            .background(selectedTripTypes.contains(title) ? Color(red: 96/255, green: 131/255, blue: 153/255) : Color(red: 200/255, green: 228/255, blue: 250/255))
//            .foregroundColor(selectedTripTypes.contains(title) ? Color.white : Color.black)
//            .cornerRadius(8)
//            .onTapGesture {
//                if selectedTripTypes.contains(title) {
//                    selectedTripTypes.remove(title)
//                } else {
//                    selectedTripTypes.insert(title)
//                }
//                print("Selected Trip Types: \(selectedTripTypes)")
//            }
//    }
//
//    // Tab Bar item creation helper
//    private func TabBarItem(iconName: String, label: String, isSelected: Bool = false, userUID: String) -> some View {
//        VStack {
//            Image(systemName: iconName)
//                .foregroundColor(isSelected ? gradientEndColor : .blue)
//            Text(label)
//                .font(.footnote)
//                .foregroundColor(isSelected ? gradientEndColor : .blue)
//        }
//        .padding(.vertical, 10)
//        .background(isSelected ? gradientEndColor.opacity(0.2) : Color.clear)
//        .cornerRadius(10)
//        .onTapGesture {
//            switch label {
//            case "Plan Trip":
//                resetPlanController()  // Clear the previous trip when navigating to the Plan Trip tab
//            case "Past Trips":
//                if let window = UIApplication.shared.windows.first {
//                    window.rootViewController = UIHostingController(rootView: PastTripsView(userUID: userUID))
//                    window.makeKeyAndVisible()
//                }
//            case "Settings":
//                if let window = UIApplication.shared.windows.first {
//                    window.rootViewController = UIHostingController(rootView: SettingsView(userUID: userUID))
//                    window.makeKeyAndVisible()
//                }
//            default:
//                break
//            }
//        }
//    }
//}





//// Sruthi's and hinal's code integrated (this code is from when we met up on campus)
//import SwiftUI
//
//struct SecondView: View {
//    @State private var selectedCity: String = "Enter destination"
//    @State private var selectedDays: Int = 5
//    @State private var selectedTripTypes: Set<String> = []
//    @StateObject private var planController = PlanController() // Create PlanController instance
//    
//    @State private var isDropdownVisible: Bool = false // For showing/hiding the dropdown
//    @State private var searchQuery: String = "" // For filtering the cities
//    @State private var dropdownOffset: CGFloat = 0
//    @State private var searchBarYPosition: CGFloat = 0.0
//    @State private var navigateToItinerary: Bool = false // Manage navigation state
//    @State private var showAlert: Bool = false // Manage alert state
//
//    let daysOptions = [1, 2, 3, 4, 5, 6, 7, 8]
//    let cities = ["Abuja, Nigeria", "Accra, Ghana", "Addis Ababa, Ethiopia", "Amsterdam, Netherlands", "Asunción, Paraguay", "Athens, Greece", "Auckland, New Zealand", "Austin, USA", "Bali, Indonesia", "Bangkok, Thailand", "Banjul, Gambia", "Barcelona, Spain", "Beijing, China", "Belgrade, Serbia", "Bendigo, Australia", "Berlin, Germany", "Bogota, Colombia", "Boston, USA", "Brisbane, Australia", "Buenos Aires, Argentina", "Budapest, Hungary", "Cairo, Egypt", "Calgary, Canada", "Cancun, Mexico", "Canberra, Australia", "Cape Town, South Africa", "Cartagena, Colombia", "Casablanca, Morocco", "Chennai, India", "Chicago, USA", "Colombo, Sri Lanka", "Copenhagen, Denmark", "Curitiba, Brazil", "Cusco, Peru", "Dakar, Senegal", "Delhi, India", "Dubai, UAE", "Dublin, Ireland", "Dunedin, New Zealand", "Durban, South Africa", "Edinburgh, Scotland", "Florence, Italy", "Fortaleza, Brazil", "Geneva, Switzerland", "Geelong, Australia", "Gold Coast, Australia", "Hamilton, New Zealand", "Hanoi, Vietnam", "Helsinki, Finland", "Hobart, Australia", "Ho Chi Minh City, Vietnam", "Honolulu, USA", "Hong Kong, China", "Istanbul, Turkey", "Jakarta, Indonesia", "Jerusalem, Israel", "Jamnagar, India", "Johannesburg, South Africa", "Karachi, Pakistan", "Kolkata, India", "Kuala Lumpur, Malaysia", "Kyoto, Japan", "La Paz, Bolivia", "Lagos, Nigeria", "Las Vegas, USA", "Lima, Peru", "Lisbon, Portugal", "London, England", "Los Angeles, USA", "Madrid, Spain", "Manila, Philippines", "Maldives, Maldives", "Maputo, Mozambique", "Mar del Plata, Argentina", "Marrakech, Morocco", "Melbourne, Australia", "Mendoza, Argentina", "Mexico City, Mexico", "Miami, USA", "Montevideo, Uruguay", "Montreal, Canada", "Moscow, Russia", "Mumbai, India", "Nairobi, Kenya", "Napier, New Zealand", "New Orleans, USA", "New York City, USA", "Ottawa, Canada", "Paris, France", "Perth, Australia", "Portland, USA", "Prague, Czech Republic", "Punta Cana, Dominican Republic", "Quebec City, Canada", "Queenstown, New Zealand", "Quito, Ecuador", "Rio de Janeiro, Brazil", "Rome, Italy", "Salvador, Brazil", "San Diego, USA", "San Francisco, USA", "Santorini, Greece", "Santiago, Chile", "São Paulo, Brazil", "Seattle, USA", "Shanghai, China", "Singapore, Singapore", "Stockholm, Sweden", "Suva, Fiji", "Sydney, Australia", "Tauranga, New Zealand", "Tokyo, Japan", "Toronto, Canada", "Tunis, Tunisia", "Udaipur, India", "Vancouver, Canada", "Victoria Falls, Zimbabwe/Zambia", "Vienna, Austria", "Washington, D.C., USA", "Wellington, New Zealand", "Windhoek, Namibia", "Yellowstone, USA", "Yokohama, Japan", "Zanzibar City, Tanzania", "Zurich, Switzerland"]
//
//    let elementHeight: CGFloat = UIScreen.main.bounds.height * 0.05
//    let buttonWidth: CGFloat = UIScreen.main.bounds.width * 0.75
//
//    let gradientStartColor = Color(UIColor(red: 141/255, green: 172/255, blue: 225/255, alpha: 1))
//    let gradientEndColor = Color(UIColor(red: 41/255, green: 102/255, blue: 117/255, alpha: 1))
//
//    var userUID: String
//
//    var body: some View {
//        
//        ZStack {
//            // Background to detect taps outside the dropdown
//            if isDropdownVisible {
//                Color.black.opacity(0.01) // Slight opacity to ensure taps are captured
//                    .edgesIgnoringSafeArea(.all)
//                    .zIndex(1) // Ensures this is above other elements
//                    .onTapGesture {
//                        isDropdownVisible = false
//                    }
//            }
//            
//            
//            
//            NavigationView {
//                ZStack {
//                    Color.white.edgesIgnoringSafeArea(.all)
//                    
//                    VStack(spacing: UIScreen.main.bounds.height * 0.03) {
//                        // Blue Gradient Box at the Top
//                        ZStack(alignment: .top) {
//                            RoundedRectangle(cornerRadius: UIScreen.main.bounds.width * 0.08, style: .continuous)
//                                .fill(
//                                    LinearGradient(
//                                        gradient: Gradient(colors: [gradientStartColor, gradientEndColor]),
//                                        startPoint: .top,
//                                        endPoint: .bottom
//                                    )
//                                )
//                                .frame(height: UIScreen.main.bounds.height * 0.4)
//                                .padding(.top, -UIScreen.main.bounds.height * 0.05)
//                                .edgesIgnoringSafeArea(.top)
//                            
//                            VStack {
//                                Text("Where are you headed?")
//                                    .font(.title)
//                                    .foregroundColor(.white)
//                                    .padding(.top, UIScreen.main.bounds.height * 0.12) // Adjusted padding for better alignment
//                                
//                                    // search bar
//                                    HStack {
//                                        Image(systemName: "magnifyingglass")
//                                            .foregroundColor(.gray)
//                                        TextField("Enter destination", text: $searchQuery)
//                                            .onTapGesture {
//                                                isDropdownVisible = true
//                                            }
//                                            .onChange(of: searchQuery) { newValue in
//                                                    // Show dropdown only if the search query is not empty
//                                                    isDropdownVisible = !newValue.isEmpty
//                                                }
//                                            .background(
//                                                GeometryReader { geometry in
//                                                    Color.clear.onAppear {
//                                                        // Capture the Y position of the search bar
//                                                        searchBarYPosition = geometry.frame(in: .global).maxY
//                                                    }
//                                                }
//                                            )
//                                        Spacer()
//                                        Image(systemName: "chevron.down")
//                                            .foregroundColor(.blue)
//                                }
//                                .padding()
//                                .background(Color(.white))
//                                .frame(width: buttonWidth, height: elementHeight)
//                                
//                                .cornerRadius(10)
//                                .shadow(radius: 2)
//                                
//                                //.padding(.horizontal)
//                                //.padding(.top, UIScreen.main.bounds.height * 0.02) // stopped here
//                            }
//                        }
//                        
//                        // Days Picker
//                        VStack(alignment: .leading, spacing: UIScreen.main.bounds.height * 0.01) {
//                            Text("Days")
//                                .font(.title2.bold())
//                                .foregroundColor(Color(.systemTeal))
//                            
//                            Text("How many days will you be gone for?")
//                                .font(.subheadline)
//                                .foregroundColor(.gray)
//                        }
//                        .frame(maxWidth: .infinity, alignment: .leading)
//                        .padding(.leading, UIScreen.main.bounds.width * 0.132)
//                        .padding(.bottom, UIScreen.main.bounds.height * 0.01)
//                        
//                        Picker("How many days will you be gone for?", selection: $selectedDays) {
//                            ForEach(daysOptions, id: \.self) { day in
//                                Text("\(day) Days")
//                            }
//                        }
//                        .pickerStyle(MenuPickerStyle())
//                        .padding()
//                        .frame(width: buttonWidth, height: elementHeight)
//                        .background(Color(.white))
//                        .cornerRadius(UIScreen.main.bounds.width * 0.02)
//                        .overlay(
//                            RoundedRectangle(cornerRadius: UIScreen.main.bounds.width * 0.02)
//                                .stroke(Color(red: 96/255, green: 131/255, blue: 153/255, opacity: 255/255), lineWidth: 3)
//                        )
//                        .padding(.horizontal)
//                        
////                        .onChange(of: selectedDays) { newValue in
////                            print("Selected Days: \(selectedDays)")
////                        }
////                        
//                        // Trip Type Selection
//                        VStack(alignment: .leading, spacing: UIScreen.main.bounds.height * 0.01) {
//                            Text("Trip Type")
//                                .font(.title2.bold())
//                                .foregroundColor(Color(.systemTeal))
//                            
//                            Text("What kind of trip do you want to go on?")
//                                .font(.subheadline)
//                                .foregroundColor(.gray)
//                        }
//                        .frame(maxWidth: .infinity, alignment: .leading)
//                        .padding(.leading, UIScreen.main.bounds.width * 0.132)
//                        .padding(.bottom, UIScreen.main.bounds.height * 0.01)
//                        
//                        VStack(spacing: UIScreen.main.bounds.height * 0.01) {
//                            HStack(spacing: UIScreen.main.bounds.width * 0.02) {
//                                tripTypeButton(title: "Adventurous")
//                                tripTypeButton(title: "Relaxing")
//                            }
//                            HStack(spacing: UIScreen.main.bounds.width * 0.02) {
//                                tripTypeButton(title: "Party")
//                                tripTypeButton(title: "Historical")
//                            }
//                        }
//                        .frame(width: buttonWidth)
//                        
//                        // NavigationLink to ItineraryView
//                        NavigationLink(
//                            destination: ItineraryView(
//                                location: selectedCity,
//                                days: selectedDays,
//                                userUID: userUID,
//                                //selectedTripType: selectedTripTypes.first ?? "Relaxing",  // Pass the selected trip type
//                                selectedTripType: selectedTripTypes.joined(separator: ", "), // Pass all selected filters
//                                planController: planController
//                            ),
//                            isActive: $navigateToItinerary
//                        ) {
//                            EmptyView()
//                        }
//                        
//                         // Plan Trip Button
//                            Button(action: {
//                                if selectedCity == "Enter destination" {
//                                    showAlert = true // Show alert if no destination is selected
//                                } else {
//                                    navigateToItinerary = true // Trigger navigation
//                                }
//                            }) {
//                        
//                            Text("Plan Your Next Trip!")
//                                .font(.headline)
//                                .padding()
//                                .frame(width: buttonWidth, height: elementHeight)
//                                .background(selectedCity != "Enter destination" ? Color.teal : Color.gray) // Indicate disabled visually
//                                .foregroundColor(.white)
//                                .cornerRadius(UIScreen.main.bounds.width * 0.02)
//                        }
//                        
//                        
//                        .alert(isPresented: $showAlert) {
//                                Alert(
//                                    title: Text("No Destination Selected"),
//                                    message: Text("Please select a destination before planning your trip."),
//                                    dismissButton: .default(Text("OK"))
//                                )
//                        }
//                        
//                        
//                        .padding(.horizontal)
//                        
//                        Spacer()
//                        
//                        // Tab Bar
//                        HStack {
//                            Spacer()
//                            TabBarItem(iconName: "briefcase", label: "Past Trips", userUID: userUID)
//                            Spacer()
//                            TabBarItem(iconName: "globe", label: "Plan Trip", isSelected: true, userUID: userUID)
//                            Spacer()
//                            TabBarItem(iconName: "person", label: "Profile", userUID: userUID)
//                            Spacer()
//                            TabBarItem(iconName: "gearshape", label: "Settings", userUID: userUID)
//                            Spacer()
//                        }
//                        .frame(height: UIScreen.main.bounds.height * 0.1) // Dynamic height
//                        .background(Color.white)
//                        .cornerRadius(UIScreen.main.bounds.width * 0.02)
//                        .shadow(radius: UIScreen.main.bounds.width * 0.01)
//                        .padding(.bottom, UIScreen.main.bounds.height * 0.01)
//                    } // here
//                    .edgesIgnoringSafeArea(.bottom)
//                    
//                    .onAppear {
//                        resetUserInputs()  // Reset inputs when the view appears
//                        resetPlanController()  // Clear previous trip data only when on the Plan Trip screen
//                    }
//                }
//            }
//            
//            // Dropdown Overlay
//            if isDropdownVisible {
//                let filteredCities = cities.filter { $0.lowercased().contains(searchQuery.lowercased()) || searchQuery.isEmpty }
//                ScrollView {
//                    VStack(spacing: 0) {
//                        if filteredCities.isEmpty {
//                            // Display "No match found" message
//                            Text("No match found")
//                                .padding()
//                                .frame(maxWidth: .infinity) // Specify the maximum width
//                                .frame(height: elementHeight) // Specify the height separately
//                                .background(Color.white) // Match dropdown background
//                                .foregroundColor(.black) // Match text color
//                                .cornerRadius(10)
//                                .shadow(radius: 2) // Optional shadow for consistency
//                           
//                        } else {
//                            ForEach(filteredCities, id: \.self) { city in
//                                Button(action: {
//                                    selectedCity = city
//                                    searchQuery = city
//                                    isDropdownVisible = false
//                                }) {
//                                    Text(city)
//                                        .padding()
//                                        .frame(maxWidth: .infinity, alignment: .leading)
//                                        .background(Color.white)
//                                        .foregroundColor(.black)
//                                }
//                                Divider()
//                            }
//                        }
//                    }
//                }
//                .frame(
//                    width: buttonWidth,
//                    height: filteredCities.isEmpty
//                    ? elementHeight
//                    : min(CGFloat(filteredCities.count) * elementHeight, UIScreen.main.bounds.height * 0.3) // Adjust height dynamically
//                )
//                .background(Color.white) // Match dropdown background
//                .cornerRadius(10)
//                .shadow(radius: 2)
//                .position(
//                    x: UIScreen.main.bounds.width / 2,
//                    y: dropdownYPosition - 15
//                )
//                .animation(.easeInOut(duration: 0.2), value: isDropdownVisible)
//                .zIndex(2)
//               
//            }
//        }
//
//            
//            
//        
//        
//    }
//    
//    
//    private var filteredCities: [String] {
//        cities.filter { $0.lowercased().contains(searchQuery.lowercased()) || searchQuery.isEmpty }
//    }
//
//
//
//    private var dropdownYPosition: CGFloat {
//        let safeAreaInset = UIApplication.shared.connectedScenes
//            .compactMap { $0 as? UIWindowScene }
//            .first?.windows.first?.safeAreaInsets.top ?? 0
//
//        let screenHeight = UIScreen.main.bounds.height
//        let isSmallScreen = screenHeight < 700 // Specifically for iPhone SE
//
//        // Base position: right below the search bar
//        let basePosition = searchBarYPosition + elementHeight
//
//        // iPhone 15 Pro: Use specific logic
//        if screenHeight > 900 { // iPhone 15 Pro
//            return {
//                switch filteredCities.count {
//                case 0, 1:
//                    return searchBarYPosition + elementHeight - UIScreen.main.bounds.height * 0.075
//                case 2:
//                    return searchBarYPosition + elementHeight - UIScreen.main.bounds.height * 0.050
//                case 3:
//                    return searchBarYPosition + elementHeight - UIScreen.main.bounds.height * 0.025
//                case 4:
//                    return searchBarYPosition + elementHeight
//                case 5:
//                    return searchBarYPosition + elementHeight + UIScreen.main.bounds.height * 0.025
//                default:
//                    return searchBarYPosition + elementHeight + UIScreen.main.bounds.height * 0.05
//                }
//            }()
//        }
//
//        // Default Logic for Other Devices
//        let adjustedOffset: CGFloat = isSmallScreen ? 22 : 5
//        let largeDeviceAdjustment: CGFloat = {
//            if screenHeight > 800 && screenHeight <= 900 { // iPhone 10
//                return 18 // Move slightly down for iPhone 10
//            } else if screenHeight > 700 && screenHeight <= 800 { // iPhone 13 Mini
//                return 5 // Move slightly down for iPhone 13 Mini
//            } else {
//                return 0 // Default for all other devices
//            }
//        }()
//
//        // Use only a fraction of safeAreaInset for large devices
//        //let adjustedSafeAreaInset: CGFloat = (screenHeight > 900 ? safeAreaInset * 0.3 : safeAreaInset * 0.5)
//
//        // Handle different dropdown heights based on the filteredCities.count
//        let dropdownAdjustment: CGFloat = {
//            switch filteredCities.count {
//            case 0, 1:
//                return -UIScreen.main.bounds.height * 0.075
//            case 2:
//                return -UIScreen.main.bounds.height * 0.050
//            case 3:
//                return -UIScreen.main.bounds.height * 0.025
//            case 4:
//                return 0
//            case 5:
//                return UIScreen.main.bounds.height * 0.025
//            default:
//                return UIScreen.main.bounds.height * 0.05
//            }
//        }()
//
//        // Combine all adjustments
//        return basePosition + adjustedOffset + largeDeviceAdjustment + dropdownAdjustment
//    }
//
//
//
//    // Helper function to reset user inputs
//    private func resetUserInputs() {
//        selectedCity = "Enter destination" // Reset destination
//        selectedDays = 5 // Reset days to the default value
//        selectedTripTypes = [] // Clear trip types
//        isDropdownVisible = false
//        searchQuery = ""
//       
//    }
//    
//    
//
////    // Helper function to reset user inputs
////    private func resetUserInputs() {
////        selectedCity = "Enter destination"  // Reset destination
////        selectedDays = 5  // Reset days to the default value
////        selectedTripTypes = []  // Clear trip types
////    }
//
//    // Reset the plan controller (clear previous trip data)
//    private func resetPlanController() {
//        planController.locationActivitiesByDay = []  // Clear previous activities
//        planController.isLoading = false  // Stop loading
//        planController.hasGeneratedActivities = false  // Mark activities as not generated yet
//        print("Previous search data cleared and ready for new search.")
//    }
//
//    // Custom button view for trip types
//    private func tripTypeButton(title: String) -> some View {
//        Text(title)
//            .font(.headline)
//            .padding()
//            .frame(width: (buttonWidth - 10) / 2, height: elementHeight)
//            .background(selectedTripTypes.contains(title) ? Color(red: 96/255, green: 131/255, blue: 153/255) : Color(red: 200/255, green: 228/255, blue: 250/255))
//            .foregroundColor(selectedTripTypes.contains(title) ? Color.white : Color.black)
//            .cornerRadius(8)
//            .onTapGesture {
//                if selectedTripTypes.contains(title) {
//                    selectedTripTypes.remove(title)
//                } else {
//                    selectedTripTypes.insert(title)
//                }
//                print("Selected Trip Types: \(selectedTripTypes)")
//            }
//    }
//
//    // Tab Bar item creation helper
//    private func TabBarItem(iconName: String, label: String, isSelected: Bool = false, userUID: String) -> some View {
//        VStack {
//            Image(systemName: iconName)
//                .foregroundColor(isSelected ? gradientEndColor : .blue)
//            Text(label)
//                .font(.footnote)
//                .foregroundColor(isSelected ? gradientEndColor : .blue)
//        }
//        .padding(.vertical, 10)
//        .background(isSelected ? gradientEndColor.opacity(0.2) : Color.clear)
//        .cornerRadius(10)
//        .onTapGesture {
//            switch label {
//            case "Plan Trip":
//                resetPlanController()  // Clear the previous trip when navigating to the Plan Trip tab
//            case "Past Trips":
//                if let window = UIApplication.shared.windows.first {
//                    window.rootViewController = UIHostingController(rootView: PastTripsView(userUID: userUID))
//                    window.makeKeyAndVisible()
//                }
//            case "Settings":
//                if let window = UIApplication.shared.windows.first {
//                    window.rootViewController = UIHostingController(rootView: SettingsView(userUID: userUID))
//                    window.makeKeyAndVisible()
//                }
//            default:
//                break
//            }
//        }
//    }
//}
//
//
//// Preference Key for capturing the view offset
//struct ViewOffsetKey: PreferenceKey {
//    static var defaultValue: CGFloat = 0
//    static func reduce(value: inout CGFloat, nextValue: () -> CGFloat) {
//        value = nextValue()
//    }
//}
//
//struct BlurView: UIViewRepresentable {
//    var style: UIBlurEffect.Style
//
//    func makeUIView(context: Context) -> UIVisualEffectView {
//        let blurEffect = UIBlurEffect(style: style)
//        let blurView = UIVisualEffectView(effect: blurEffect)
//        return blurView
//    }
//
//    func updateUIView(_ uiView: UIVisualEffectView, context: Context) {
//        // No updates needed
//    }
//}





//// Sruthi's and hinal's code integrated + trying to fix the search bar gap
//import SwiftUI
//
//struct SecondView: View {
//    @State private var selectedCity: String = "Enter destination"
//    @State private var selectedDays: Int = 5
//    @State private var selectedTripTypes: Set<String> = []
//    @StateObject private var planController = PlanController() // Create PlanController instance
//    
//    @State private var isDropdownVisible: Bool = false // For showing/hiding the dropdown
//    @State private var searchQuery: String = "" // For filtering the cities
//    @State private var dropdownOffset: CGFloat = 0
//    @State private var searchBarYPosition: CGFloat = 0.0
//    @State private var navigateToItinerary: Bool = false // Manage navigation state
//    @State private var showAlert: Bool = false // Manage alert state
//
//    let daysOptions = [1, 2, 3, 4, 5, 6, 7, 8]
//    let cities = ["Abuja, Nigeria", "Accra, Ghana", "Addis Ababa, Ethiopia", "Amsterdam, Netherlands", "Asunción, Paraguay", "Athens, Greece", "Auckland, New Zealand", "Austin, USA", "Bali, Indonesia", "Bangkok, Thailand", "Banjul, Gambia", "Barcelona, Spain", "Beijing, China", "Belgrade, Serbia", "Bendigo, Australia", "Berlin, Germany", "Bogota, Colombia", "Boston, USA", "Brisbane, Australia", "Buenos Aires, Argentina", "Budapest, Hungary", "Cairo, Egypt", "Calgary, Canada", "Cancun, Mexico", "Canberra, Australia", "Cape Town, South Africa", "Cartagena, Colombia", "Casablanca, Morocco", "Chennai, India", "Chicago, USA", "Colombo, Sri Lanka", "Copenhagen, Denmark", "Curitiba, Brazil", "Cusco, Peru", "Dakar, Senegal", "Delhi, India", "Dubai, UAE", "Dublin, Ireland", "Dunedin, New Zealand", "Durban, South Africa", "Edinburgh, Scotland", "Florence, Italy", "Fortaleza, Brazil", "Geneva, Switzerland", "Geelong, Australia", "Gold Coast, Australia", "Hamilton, New Zealand", "Hanoi, Vietnam", "Helsinki, Finland", "Hobart, Australia", "Ho Chi Minh City, Vietnam", "Honolulu, USA", "Hong Kong, China", "Istanbul, Turkey", "Jakarta, Indonesia", "Jerusalem, Israel", "Jamnagar, India", "Johannesburg, South Africa", "Karachi, Pakistan", "Kolkata, India", "Kuala Lumpur, Malaysia", "Kyoto, Japan", "La Paz, Bolivia", "Lagos, Nigeria", "Las Vegas, USA", "Lima, Peru", "Lisbon, Portugal", "London, England", "Los Angeles, USA", "Madrid, Spain", "Manila, Philippines", "Maldives, Maldives", "Maputo, Mozambique", "Mar del Plata, Argentina", "Marrakech, Morocco", "Melbourne, Australia", "Mendoza, Argentina", "Mexico City, Mexico", "Miami, USA", "Montevideo, Uruguay", "Montreal, Canada", "Moscow, Russia", "Mumbai, India", "Nairobi, Kenya", "Napier, New Zealand", "New Orleans, USA", "New York City, USA", "Ottawa, Canada", "Paris, France", "Perth, Australia", "Portland, USA", "Prague, Czech Republic", "Punta Cana, Dominican Republic", "Quebec City, Canada", "Queenstown, New Zealand", "Quito, Ecuador", "Rio de Janeiro, Brazil", "Rome, Italy", "Salvador, Brazil", "San Diego, USA", "San Francisco, USA", "Santorini, Greece", "Santiago, Chile", "São Paulo, Brazil", "Seattle, USA", "Shanghai, China", "Singapore, Singapore", "Stockholm, Sweden", "Suva, Fiji", "Sydney, Australia", "Tauranga, New Zealand", "Tokyo, Japan", "Toronto, Canada", "Tunis, Tunisia", "Udaipur, India", "Vancouver, Canada", "Victoria Falls, Zimbabwe/Zambia", "Vienna, Austria", "Washington, D.C., USA", "Wellington, New Zealand", "Windhoek, Namibia", "Yellowstone, USA", "Yokohama, Japan", "Zanzibar City, Tanzania", "Zurich, Switzerland"]
//
//    let elementHeight: CGFloat = UIScreen.main.bounds.height * 0.05
//    let buttonWidth: CGFloat = UIScreen.main.bounds.width * 0.75
//
//    let gradientStartColor = Color(UIColor(red: 141/255, green: 172/255, blue: 225/255, alpha: 1))
//    let gradientEndColor = Color(UIColor(red: 41/255, green: 102/255, blue: 117/255, alpha: 1))
//
//    var userUID: String
//
//    var body: some View {
//        
//        ZStack {
//            // Background to detect taps outside the dropdown
//            if isDropdownVisible {
//                Color.black.opacity(0.01) // Slight opacity to ensure taps are captured
//                    .edgesIgnoringSafeArea(.all)
//                    .zIndex(1) // Ensures this is above other elements
//                    .onTapGesture {
//                        isDropdownVisible = false
//                    }
//            }
//            
//            
//            
//            NavigationView {
//                ZStack {
//                    Color.white.edgesIgnoringSafeArea(.all)
//                    
//                    VStack(spacing: UIScreen.main.bounds.height * 0.03) {
//                        // Blue Gradient Box at the Top
//                        ZStack(alignment: .top) {
//                            RoundedRectangle(cornerRadius: UIScreen.main.bounds.width * 0.08, style: .continuous)
//                                .fill(
//                                    LinearGradient(
//                                        gradient: Gradient(colors: [gradientStartColor, gradientEndColor]),
//                                        startPoint: .top,
//                                        endPoint: .bottom
//                                    )
//                                )
//                                .frame(height: UIScreen.main.bounds.height * 0.4)
//                                .padding(.top, -UIScreen.main.bounds.height * 0.05)
//                                .edgesIgnoringSafeArea(.top)
//                            
//                            VStack {
//                                Text("Where are you headed?")
//                                    .font(.title)
//                                    .foregroundColor(.white)
//                                    .padding(.top, UIScreen.main.bounds.height * 0.12) // Adjusted padding for better alignment
//                                
//                                    // search bar
//                                    HStack {
//                                        Image(systemName: "magnifyingglass")
//                                            .foregroundColor(.gray)
//                                        TextField("Enter destination", text: $searchQuery)
//                                            .onTapGesture {
//                                                isDropdownVisible = true
//                                            }
//                                            .onChange(of: searchQuery) { newValue in
//                                                    // Show dropdown only if the search query is not empty
//                                                    isDropdownVisible = !newValue.isEmpty
//                                                }
//                                            .background(
//                                                GeometryReader { geometry in
//                                                    Color.clear.onAppear {
//                                                        // Capture the Y position of the search bar
//                                                        searchBarYPosition = geometry.frame(in: .global).maxY
//                                                    }
//                                                }
//                                            )
//                                        Spacer()
//                                        Image(systemName: "chevron.down")
//                                            .foregroundColor(.blue)
//                                }
//                                .padding()
//                                .background(Color(.white))
//                                .frame(width: buttonWidth, height: elementHeight)
//                                
//                                .cornerRadius(10)
//                                .shadow(radius: 2)
//                                
//                                //.padding(.horizontal)
//                                //.padding(.top, UIScreen.main.bounds.height * 0.02) // stopped here
//                            }
//                        }
//                        
//                        // Days Picker
//                        VStack(alignment: .leading, spacing: UIScreen.main.bounds.height * 0.01) {
//                            Text("Days")
//                                .font(.title2.bold())
//                                .foregroundColor(Color(.systemTeal))
//                            
//                            Text("How many days will you be gone for?")
//                                .font(.subheadline)
//                                .foregroundColor(.gray)
//                        }
//                        .frame(maxWidth: .infinity, alignment: .leading)
//                        .padding(.leading, UIScreen.main.bounds.width * 0.132)
//                        .padding(.bottom, UIScreen.main.bounds.height * 0.01)
//                        
//                        Picker("How many days will you be gone for?", selection: $selectedDays) {
//                            ForEach(daysOptions, id: \.self) { day in
//                                Text("\(day) Days")
//                            }
//                        }
//                        .pickerStyle(MenuPickerStyle())
//                        .padding()
//                        .frame(width: buttonWidth, height: elementHeight)
//                        .background(Color(.white))
//                        .cornerRadius(UIScreen.main.bounds.width * 0.02)
//                        .overlay(
//                            RoundedRectangle(cornerRadius: UIScreen.main.bounds.width * 0.02)
//                                .stroke(Color(red: 96/255, green: 131/255, blue: 153/255, opacity: 255/255), lineWidth: 3)
//                        )
//                        .padding(.horizontal)
//                        
////                        .onChange(of: selectedDays) { newValue in
////                            print("Selected Days: \(selectedDays)")
////                        }
////
//                        // Trip Type Selection
//                        VStack(alignment: .leading, spacing: UIScreen.main.bounds.height * 0.01) {
//                            Text("Trip Type")
//                                .font(.title2.bold())
//                                .foregroundColor(Color(.systemTeal))
//                            
//                            Text("What kind of trip do you want to go on?")
//                                .font(.subheadline)
//                                .foregroundColor(.gray)
//                        }
//                        .frame(maxWidth: .infinity, alignment: .leading)
//                        .padding(.leading, UIScreen.main.bounds.width * 0.132)
//                        .padding(.bottom, UIScreen.main.bounds.height * 0.01)
//                        
//                        VStack(spacing: UIScreen.main.bounds.height * 0.01) {
//                            HStack(spacing: UIScreen.main.bounds.width * 0.02) {
//                                tripTypeButton(title: "Adventurous")
//                                tripTypeButton(title: "Relaxing")
//                            }
//                            HStack(spacing: UIScreen.main.bounds.width * 0.02) {
//                                tripTypeButton(title: "Party")
//                                tripTypeButton(title: "Historical")
//                            }
//                        }
//                        .frame(width: buttonWidth)
//                        
//                        // NavigationLink to ItineraryView
//                        NavigationLink(
//                            destination: ItineraryView(
//                                location: selectedCity,
//                                days: selectedDays,
//                                userUID: userUID,
//                                //selectedTripType: selectedTripTypes.first ?? "Relaxing",  // Pass the selected trip type
//                                selectedTripType: selectedTripTypes.joined(separator: ", "), // Pass all selected filters
//                                planController: planController
//                            ),
//                            isActive: $navigateToItinerary
//                        ) {
//                            EmptyView()
//                        }
//                        
//                         // Plan Trip Button
//                            Button(action: {
//                                if selectedCity == "Enter destination" {
//                                    showAlert = true // Show alert if no destination is selected
//                                } else {
//                                    navigateToItinerary = true // Trigger navigation
//                                }
//                            }) {
//                        
//                            Text("Plan Your Next Trip!")
//                                .font(.headline)
//                                .padding()
//                                .frame(width: buttonWidth, height: elementHeight)
//                                .background(selectedCity != "Enter destination" ? Color.teal : Color.gray) // Indicate disabled visually
//                                .foregroundColor(.white)
//                                .cornerRadius(UIScreen.main.bounds.width * 0.02)
//                        }
//                        
//                        
//                        .alert(isPresented: $showAlert) {
//                                Alert(
//                                    title: Text("No Destination Selected"),
//                                    message: Text("Please select a destination before planning your trip."),
//                                    dismissButton: .default(Text("OK"))
//                                )
//                        }
//                        
//                        
//                        .padding(.horizontal)
//                        
//                        Spacer()
//                        
//                        // Tab Bar
//                        HStack {
//                            Spacer()
//                            TabBarItem(iconName: "briefcase", label: "Past Trips", userUID: userUID)
//                            Spacer()
//                            TabBarItem(iconName: "globe", label: "Plan Trip", isSelected: true, userUID: userUID)
//                            Spacer()
//                            TabBarItem(iconName: "person", label: "Profile", userUID: userUID)
//                            Spacer()
//                            TabBarItem(iconName: "gearshape", label: "Settings", userUID: userUID)
//                            Spacer()
//                        }
//                        .frame(height: UIScreen.main.bounds.height * 0.1) // Dynamic height
//                        .background(Color.white)
//                        .cornerRadius(UIScreen.main.bounds.width * 0.02)
//                        .shadow(radius: UIScreen.main.bounds.width * 0.01)
//                        .padding(.bottom, UIScreen.main.bounds.height * 0.01)
//                    } // here
//                    .edgesIgnoringSafeArea(.bottom)
//                    
//                    .onAppear {
//                        resetUserInputs()  // Reset inputs when the view appears
//                        resetPlanController()  // Clear previous trip data only when on the Plan Trip screen
//                    }
//                }
//            }
//            
//            // Dropdown Overlay
//            if isDropdownVisible {
//                let filteredCities = cities.filter { $0.lowercased().contains(searchQuery.lowercased()) || searchQuery.isEmpty }
//                ScrollView {
//                    VStack(spacing: 0) {
//                        if filteredCities.isEmpty {
//                            // Display "No match found" message
//                            Text("No match found")
//                                .padding()
//                                .frame(maxWidth: .infinity) // Specify the maximum width
//                                .frame(height: elementHeight) // Specify the height separately
//                                .background(Color.white) // Match dropdown background
//                                .foregroundColor(.black) // Match text color
//                                .cornerRadius(10)
//                                .shadow(radius: 2) // Optional shadow for consistency
//                           
//                        } else {
//                            ForEach(filteredCities, id: \.self) { city in
//                                Button(action: {
//                                    selectedCity = city
//                                    searchQuery = city
//                                    isDropdownVisible = false
//                                }) {
//                                    Text(city)
//                                        .padding()
//                                        .frame(maxWidth: .infinity, alignment: .leading)
//                                        .background(Color.white)
//                                        .foregroundColor(.black)
//                                }
//                                Divider()
//                            }
//                        }
//                    }
//                }
//                .frame(
//                    width: buttonWidth,
//                    height: filteredCities.isEmpty
//                    ? elementHeight
//                    : min(CGFloat(filteredCities.count) * elementHeight, UIScreen.main.bounds.height * 0.3) // Adjust height dynamically
//                )
//                .background(Color.white) // Match dropdown background
//                .cornerRadius(10)
//                .shadow(radius: 2)
//                .position(
//                    x: UIScreen.main.bounds.width / 2,
//                    // y: dropdownYPosition - 15
//                    y: dropdownYPosition
//                )
//                .animation(.easeInOut(duration: 0.2), value: isDropdownVisible)
//                .zIndex(2)
//               
//            }
//        }
//
//            
//            
//        
//        
//    }
//    
//    
//    private var filteredCities: [String] {
//        cities.filter { $0.lowercased().contains(searchQuery.lowercased()) || searchQuery.isEmpty }
//    }
//
//
//
////    private var dropdownYPosition: CGFloat {
////        let safeAreaInset = UIApplication.shared.connectedScenes
////            .compactMap { $0 as? UIWindowScene }
////            .first?.windows.first?.safeAreaInsets.top ?? 0
////
////        let screenHeight = UIScreen.main.bounds.height
////        let isSmallScreen = screenHeight < 700 // Specifically for iPhone SE
////
////        // Base position: right below the search bar
////        let basePosition = searchBarYPosition + elementHeight
////
////        // iPhone 15 Pro: Use specific logic
////        if screenHeight > 900 { // iPhone 15 Pro
////            return {
////                switch filteredCities.count {
////                case 0, 1:
////                    return searchBarYPosition + elementHeight - UIScreen.main.bounds.height * 0.075
////                case 2:
////                    return searchBarYPosition + elementHeight - UIScreen.main.bounds.height * 0.050
////                case 3:
////                    return searchBarYPosition + elementHeight - UIScreen.main.bounds.height * 0.025
////                case 4:
////                    return searchBarYPosition + elementHeight
////                case 5:
////                    return searchBarYPosition + elementHeight + UIScreen.main.bounds.height * 0.025
////                default:
////                    return searchBarYPosition + elementHeight + UIScreen.main.bounds.height * 0.05
////                }
////            }()
////        }
////
////        // Default Logic for Other Devices
////        let adjustedOffset: CGFloat = isSmallScreen ? 22 : 5
////        let largeDeviceAdjustment: CGFloat = {
////            if screenHeight > 800 && screenHeight <= 900 { // iPhone 10
////                return 18 // Move slightly down for iPhone 10
////            } else if screenHeight > 700 && screenHeight <= 800 { // iPhone 13 Mini
////                return 5 // Move slightly down for iPhone 13 Mini
////            } else {
////                return 0 // Default for all other devices
////            }
////        }()
////
////        // Use only a fraction of safeAreaInset for large devices
////        //let adjustedSafeAreaInset: CGFloat = (screenHeight > 900 ? safeAreaInset * 0.3 : safeAreaInset * 0.5)
////
////        // Handle different dropdown heights based on the filteredCities.count
////        let dropdownAdjustment: CGFloat = {
////            switch filteredCities.count {
////            case 0, 1:
////                return -UIScreen.main.bounds.height * 0.075
////            case 2:
////                return -UIScreen.main.bounds.height * 0.050
////            case 3:
////                return -UIScreen.main.bounds.height * 0.025
////            case 4:
////                return 0
////            case 5:
////                return UIScreen.main.bounds.height * 0.025
////            default:
////                return UIScreen.main.bounds.height * 0.05
////            }
////        }()
////
////        // Combine all adjustments
////        return basePosition + adjustedOffset + largeDeviceAdjustment + dropdownAdjustment
////    }
//    
//    private var dropdownYPosition: CGFloat {
//        searchBarYPosition + elementHeight / 2
//    }
//
//
//
//
//    // Helper function to reset user inputs
//    private func resetUserInputs() {
//        selectedCity = "Enter destination" // Reset destination
//        selectedDays = 5 // Reset days to the default value
//        selectedTripTypes = [] // Clear trip types
//        isDropdownVisible = false
//        searchQuery = ""
//       
//    }
//    
//    
//
////    // Helper function to reset user inputs
////    private func resetUserInputs() {
////        selectedCity = "Enter destination"  // Reset destination
////        selectedDays = 5  // Reset days to the default value
////        selectedTripTypes = []  // Clear trip types
////    }
//
//    // Reset the plan controller (clear previous trip data)
//    private func resetPlanController() {
//        planController.locationActivitiesByDay = []  // Clear previous activities
//        planController.isLoading = false  // Stop loading
//        planController.hasGeneratedActivities = false  // Mark activities as not generated yet
//        print("Previous search data cleared and ready for new search.")
//    }
//
//    // Custom button view for trip types
//    private func tripTypeButton(title: String) -> some View {
//        Text(title)
//            .font(.headline)
//            .padding()
//            .frame(width: (buttonWidth - 10) / 2, height: elementHeight)
//            .background(selectedTripTypes.contains(title) ? Color(red: 96/255, green: 131/255, blue: 153/255) : Color(red: 200/255, green: 228/255, blue: 250/255))
//            .foregroundColor(selectedTripTypes.contains(title) ? Color.white : Color.black)
//            .cornerRadius(8)
//            .onTapGesture {
//                if selectedTripTypes.contains(title) {
//                    selectedTripTypes.remove(title)
//                } else {
//                    selectedTripTypes.insert(title)
//                }
//                print("Selected Trip Types: \(selectedTripTypes)")
//            }
//    }
//
//    // Tab Bar item creation helper
//    private func TabBarItem(iconName: String, label: String, isSelected: Bool = false, userUID: String) -> some View {
//        VStack {
//            Image(systemName: iconName)
//                .foregroundColor(isSelected ? gradientEndColor : .blue)
//            Text(label)
//                .font(.footnote)
//                .foregroundColor(isSelected ? gradientEndColor : .blue)
//        }
//        .padding(.vertical, 10)
//        .background(isSelected ? gradientEndColor.opacity(0.2) : Color.clear)
//        .cornerRadius(10)
//        .onTapGesture {
//            switch label {
//            case "Plan Trip":
//                resetPlanController()  // Clear the previous trip when navigating to the Plan Trip tab
//            case "Past Trips":
//                if let window = UIApplication.shared.windows.first {
//                    window.rootViewController = UIHostingController(rootView: PastTripsView(userUID: userUID))
//                    window.makeKeyAndVisible()
//                }
//            case "Settings":
//                if let window = UIApplication.shared.windows.first {
//                    window.rootViewController = UIHostingController(rootView: SettingsView(userUID: userUID))
//                    window.makeKeyAndVisible()
//                }
//            default:
//                break
//            }
//        }
//    }
//}
//
//
//// Preference Key for capturing the view offset
//struct ViewOffsetKey: PreferenceKey {
//    static var defaultValue: CGFloat = 0
//    static func reduce(value: inout CGFloat, nextValue: () -> CGFloat) {
//        value = nextValue()
//    }
//}
//
//struct BlurView: UIViewRepresentable {
//    var style: UIBlurEffect.Style
//
//    func makeUIView(context: Context) -> UIVisualEffectView {
//        let blurEffect = UIBlurEffect(style: style)
//        let blurView = UIVisualEffectView(effect: blurEffect)
//        return blurView
//    }
//
//    func updateUIView(_ uiView: UIVisualEffectView, context: Context) {
//        // No updates needed
//    }
//}



//// hinal's updated code (able to press on the tab bar easily)
//import SwiftUI
//
//
//struct SecondView: View {
//    @State private var selectedCity: String = "Enter destination"
//    @State private var selectedDays: Int = 5
//    @State private var selectedTripTypes: Set<String> = []
//    @StateObject private var planController = PlanController() // Create PlanController instance
//    @State private var isDropdownVisible: Bool = false // For showing/hiding the dropdown
//    @State private var searchQuery: String = "" // For filtering the cities
//    @State private var dropdownOffset: CGFloat = 0
//    @State private var searchBarYPosition: CGFloat = 0.0
//    @State private var navigateToItinerary: Bool = false // Manage navigation state
//    @State private var showAlert: Bool = false // Manage alert state
//    @State private var storedDropdownPosition: CGFloat? = nil
//    @State private var hasCalculatedDropdownPosition = false
//    
//
//
//    let daysOptions = [1, 2, 3, 4, 5, 6, 7, 8]
//    let cities = ["Abuja, Nigeria", "Accra, Ghana", "Addis Ababa, Ethiopia", "Amsterdam, Netherlands", "Asunción, Paraguay", "Athens, Greece", "Auckland, New Zealand", "Austin, USA", "Bali, Indonesia", "Bangkok, Thailand", "Banjul, Gambia", "Barcelona, Spain", "Beijing, China", "Belgrade, Serbia", "Bendigo, Australia", "Berlin, Germany", "Bogota, Colombia", "Boston, USA", "Brisbane, Australia", "Buenos Aires, Argentina", "Budapest, Hungary", "Cairo, Egypt", "Calgary, Canada", "Cancun, Mexico", "Canberra, Australia", "Cape Town, South Africa", "Cartagena, Colombia", "Casablanca, Morocco", "Chennai, India", "Chicago, USA", "Colombo, Sri Lanka", "Copenhagen, Denmark", "Curitiba, Brazil", "Cusco, Peru", "Dakar, Senegal", "Delhi, India", "Dubai, UAE", "Dublin, Ireland", "Dunedin, New Zealand", "Durban, South Africa", "Edinburgh, Scotland", "Florence, Italy", "Fortaleza, Brazil", "Geneva, Switzerland", "Geelong, Australia", "Gold Coast, Australia", "Hamilton, New Zealand", "Hanoi, Vietnam", "Helsinki, Finland", "Hobart, Australia", "Ho Chi Minh City, Vietnam", "Honolulu, USA", "Hong Kong, China", "Istanbul, Turkey", "Jakarta, Indonesia", "Jerusalem, Israel", "Jamnagar, India", "Johannesburg, South Africa", "Karachi, Pakistan", "Kolkata, India", "Kuala Lumpur, Malaysia", "Kyoto, Japan", "La Paz, Bolivia", "Lagos, Nigeria", "Las Vegas, USA", "Lima, Peru", "Lisbon, Portugal", "London, England", "Los Angeles, USA", "Madrid, Spain", "Manila, Philippines", "Maldives, Maldives", "Maputo, Mozambique", "Mar del Plata, Argentina", "Marrakech, Morocco", "Melbourne, Australia", "Mendoza, Argentina", "Mexico City, Mexico", "Miami, USA", "Montevideo, Uruguay", "Montreal, Canada", "Moscow, Russia", "Mumbai, India", "Nairobi, Kenya", "Napier, New Zealand", "New Orleans, USA", "New York City, USA", "Ottawa, Canada", "Paris, France", "Perth, Australia", "Portland, USA", "Prague, Czech Republic", "Punta Cana, Dominican Republic", "Quebec City, Canada", "Queenstown, New Zealand", "Quito, Ecuador", "Rio de Janeiro, Brazil", "Rome, Italy", "Salvador, Brazil", "San Diego, USA", "San Francisco, USA", "Santorini, Greece", "Santiago, Chile", "São Paulo, Brazil", "Seattle, USA", "Shanghai, China", "Singapore, Singapore", "Stockholm, Sweden", "Suva, Fiji", "Sydney, Australia", "Tauranga, New Zealand", "Tokyo, Japan", "Toronto, Canada", "Tunis, Tunisia", "Udaipur, India", "Vancouver, Canada", "Victoria Falls, Zimbabwe/Zambia", "Vienna, Austria", "Washington, D.C., USA", "Wellington, New Zealand", "Windhoek, Namibia", "Yellowstone, USA", "Yokohama, Japan", "Zanzibar City, Tanzania", "Zurich, Switzerland"]
//
//    let elementHeight: CGFloat = UIScreen.main.bounds.height * 0.05
//    let buttonWidth: CGFloat = UIScreen.main.bounds.width * 0.75
//   
//
//    let gradientStartColor = Color(UIColor(red: 141/255, green: 172/255, blue: 225/255, alpha: 1))
//    let gradientEndColor = Color(UIColor(red: 41/255, green: 102/255, blue: 117/255, alpha: 1))
//
//    var userUID: String
//
//    var body: some View {
//        ZStack {
//            // Background to detect taps outside the dropdown
//            if isDropdownVisible {
////                Color.black.opacity(0.01) // Slight opacity to ensure taps are captured
////                    .edgesIgnoringSafeArea(.all)
////                    .zIndex(1) // Ensures this is above other elements
////                    .onTapGesture {
////                        isDropdownVisible = false
////                    }
//                Rectangle()
//                        .foregroundColor(Color.black.opacity(0.01)) // Keep it transparent for capturing taps
//                        .ignoresSafeArea() // Only apply to safe area
//                        .onTapGesture {
//                            isDropdownVisible = false // Close dropdown on tap
//                            UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
//                        }
//                        .zIndex(1) // Ensure it stays above other elements
//            }
//           
//            NavigationView {
//                ZStack {
//                    Color.white
//                        .edgesIgnoringSafeArea(.all)
//                   
//                    VStack(spacing: UIScreen.main.bounds.height * 0.03) {
//                        // Top Gradient Box
//                        ZStack(alignment: .top) {
//                            RoundedRectangle(cornerRadius: UIScreen.main.bounds.width * 0.08, style: .continuous)
//                                .fill(
//                                    LinearGradient(
//                                        gradient: Gradient(colors: [gradientStartColor, gradientEndColor]),
//                                        startPoint: .top,
//                                        endPoint: .bottom
//                                    )
//                                )
//                                .frame(height: UIScreen.main.bounds.height * 0.4)
//                                .padding(.top, -UIScreen.main.bounds.height * 0.05)
//                                .edgesIgnoringSafeArea(.top)
//                           
//                            VStack {
//                                Text("Where are you headed?")
//                                    .font(.title)
//                                    .foregroundColor(.white)
//                                    .padding(.top, UIScreen.main.bounds.height * 0.12)
//                               
//                                // Search Bar
//                                HStack {
//                                    Image(systemName: "magnifyingglass")
//                                        .foregroundColor(.gray)
//                                    TextField("Enter destination", text: $searchQuery)
//                                        .onTapGesture {
//                                            isDropdownVisible = true
//                                        }
//                                        .onChange(of: searchQuery) { newValue in
//                                            isDropdownVisible = !newValue.isEmpty
//                                        }
//                                        .background(
////                                            GeometryReader { geometry in
////                                                Color.clear.onAppear {
////                                                    // Dynamically store the position of the search bar
////                                                    searchBarYPosition = geometry.frame(in: .global).maxY
////                                                }
////                                            }
//                                            // should be changed here
//                                            GeometryReader { geometry in
//                                                Color.clear.onAppear {
//                                                    if searchBarYPosition == 0.0 { // Set only once
//                                                        searchBarYPosition = geometry.frame(in: .global).maxY
//                                                    }
//                                                    //searchBarYPosition = geometry.frame(in: .global).maxY
//                                                    
//                                                }
//                                            }
//                                            
//                                        )
//                                    Spacer()
//                                    Image(systemName: "chevron.down")
//                                        .foregroundColor(.blue)
//                                }
//                                .padding()
//                                .background(Color.white)
//                                .frame(width: buttonWidth, height: elementHeight)
//                                .cornerRadius(10)
//                                .shadow(radius: 2)
//
//                            }
//                        }
//                       
//                        // Days Picker
//                        VStack(alignment: .leading, spacing: UIScreen.main.bounds.height * 0.01) {
//                            Text("Days")
//                                .font(.title2.bold())
//                                .foregroundColor(Color(.systemTeal))
//                           
//                            Text("How many days will you be gone for?")
//                                .font(.subheadline)
//                                .foregroundColor(.gray)
//                        }
//                        .frame(maxWidth: .infinity, alignment: .leading)
//                        .padding(.leading, UIScreen.main.bounds.width * 0.132)
//                        .padding(.bottom, UIScreen.main.bounds.height * 0.01)
//                       
//                        Picker("How many days will you be gone for?", selection: $selectedDays) {
//                            ForEach(daysOptions, id: \.self) { day in
//                                Text("\(day) Days")
//                            }
//                        }
//                        .pickerStyle(MenuPickerStyle())
//                        .padding()
//                        .frame(width: buttonWidth, height: elementHeight)
//                        .background(Color(.white))
//                        .cornerRadius(UIScreen.main.bounds.width * 0.02)
//                        .overlay(
//                            RoundedRectangle(cornerRadius: UIScreen.main.bounds.width * 0.02)
//                                .stroke(Color(red: 96/255, green: 131/255, blue: 153/255, opacity: 255/255), lineWidth: 3)
//                        )
//                        .padding(.horizontal)
//                       
//                        VStack(alignment: .leading, spacing: UIScreen.main.bounds.height * 0.01) {
//                                                Text("Trip Type")
//                                                    .font(.title2.bold())
//                                                    .foregroundColor(Color(.systemTeal))
//                       
//                                                Text("What kind of trip do you want to go on?")
//                                                    .font(.subheadline)
//                                                    .foregroundColor(.gray)
//                                            }
//                                            .frame(maxWidth: .infinity, alignment: .leading)
//                                            .padding(.leading, UIScreen.main.bounds.width * 0.132)
//                                            .padding(.bottom, UIScreen.main.bounds.height * 0.01)
//                       
//                        // Trip Type Selection
//                        VStack(spacing: UIScreen.main.bounds.height * 0.01) {
//                            HStack(spacing: UIScreen.main.bounds.width * 0.02) {
//                                tripTypeButton(title: "Adventurous")
//                                tripTypeButton(title: "Relaxing")
//                            }
//                            HStack(spacing: UIScreen.main.bounds.width * 0.02) {
//                                tripTypeButton(title: "Party")
//                                tripTypeButton(title: "Historical")
//                            }
//                        }
//                        .frame(width: buttonWidth)
//                       
//                     
//                       
//                            // NavigationLink managed by `navigateToItinerary`
//                            NavigationLink(
//                                destination: ItineraryView(
//                                    location: selectedCity,
//                                    days: selectedDays,
//                                    userUID: userUID,
//                                    selectedTripType: selectedTripTypes.first ?? "Relaxing",
//                                    planController: planController
//                                ),
//                                isActive: $navigateToItinerary
//                            ) {
//                                EmptyView()
//                            }
//
//                            // Plan Trip Button
//                            Button(action: {
//                                if selectedCity == "Enter destination" {
//                                    showAlert = true // Show alert if no destination is selected
//                                } else {
//                                    navigateToItinerary = true // Trigger navigation
//                                }
//                            }) {
//                                Text("Plan Your Next Trip!")
//                                    .font(.headline)
//                                    .padding()
//                                    .frame(width: buttonWidth, height: elementHeight)
//                                    .background(selectedCity != "Enter destination" ? Color.teal : Color.gray) // Indicate disabled visually
//                                    .foregroundColor(.white)
//                                    .cornerRadius(UIScreen.main.bounds.width * 0.02)
//                            }
//                            .alert(isPresented: $showAlert) {
//                                Alert(
//                                    title: Text("No Destination Selected"),
//                                    message: Text("Please select a destination before planning your trip."),
//                                    dismissButton: .default(Text("OK"))
//                                )
//                            }
//                       
//                        .padding(.horizontal)
//                       
//                        Spacer()
//                       
//                        // Tab Bar
//                        HStack {
//                            Spacer()
//                            TabBarItem(iconName: "briefcase", label: "Past Trips", userUID: userUID)
//                            Spacer()
//                            TabBarItem(iconName: "globe", label: "Plan Trip", isSelected: true, userUID: userUID)
//                            Spacer()
//                            TabBarItem(iconName: "person", label: "Profile", userUID: userUID)
//                            Spacer()
//                            TabBarItem(iconName: "gearshape", label: "Settings", userUID: userUID)
//                            Spacer()
//                        }
//                        .frame(height: UIScreen.main.bounds.height * 0.1)
//                        .background(Color.white)
//                        .cornerRadius(UIScreen.main.bounds.width * 0.02)
//                        .shadow(radius: UIScreen.main.bounds.width * 0.01)
//                        .padding(.bottom, UIScreen.main.bounds.height * 0.01)
//                        .zIndex(2)
//                    }
//                }
////                .onAppear {
////                    if !hasCalculatedDropdownPosition {
////                            // Recalculate only if not already calculated
////                            storedDropdownPosition = nil
////                            hasCalculatedDropdownPosition = true
////                        }
////                        resetUserInputs() // Clear inputs when back button is pressed
////                        resetPlanController() // Reset the plan controller
////                        storedDropdownPosition = nil
////                    }
//                
//                .onAppear {
//                    storedDropdownPosition = nil // Clear stored position
//                    hasCalculatedDropdownPosition = false // Ensure fresh calculation
//                    resetUserInputs()
//                    resetPlanController()
//                }
//
//            }
//           
//            
//            if isDropdownVisible {
//                let filteredCities = cities.filter { $0.lowercased().contains(searchQuery.lowercased()) || searchQuery.isEmpty }
//                
//                ScrollView {
//                    VStack(spacing: 0) {
//                        if filteredCities.isEmpty {
//                            // No results message
//                            Text("No match found")
//                                .padding()
//                                .frame(maxWidth: .infinity)
//                                .frame(height: elementHeight)
//                                .background(Color.white)
//                                .foregroundColor(.black)
//                                .cornerRadius(10)
//                                .shadow(radius: 2)
//                        } else {
//                            // Filtered cities list
//                            ForEach(filteredCities, id: \.self) { city in
//                                Button(action: {
//                                    selectedCity = city
//                                    searchQuery = city
//                                    isDropdownVisible = false
//                                    UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
//                                }) {
//                                    Text(city)
//                                        .padding()
//                                        .frame(maxWidth: .infinity, alignment: .leading)
//                                        .background(Color.white)
//                                        .foregroundColor(.black)
//                                }
//                                Divider()
//                            }
//                        }
//                    }
//                }
//                .frame(
//                    width: buttonWidth,
//                    height: filteredCities.isEmpty
//                        ? elementHeight
//                        : min(CGFloat(filteredCities.count) * elementHeight, UIScreen.main.bounds.height * 0.3)
//                )
//                .background(Color.white)
//                .cornerRadius(10)
//                .shadow(radius: 2)
//                // Use GeometryReader to dynamically align dropdown below the search bar
//                .background(
////                    GeometryReader { geometry in
////                        Color.clear.onAppear {
////                            searchBarYPosition = geometry.frame(in: .global).maxY // Capture Y position dynamically
////                        }
////                    }
//                    GeometryReader { geometry in
//                        Color.clear.onAppear {
//                            // Capture the Y-position of the search bar only once
//                            if searchBarYPosition == 0.0 {
//                                searchBarYPosition = geometry.frame(in: .global).maxY
//                            }
//                            //searchBarYPosition = geometry.frame(in: .global).maxY
//                        }
//                    }
//                )
//                .position(
//                    x: UIScreen.main.bounds.width / 2,
//                    y: searchBarYPosition + elementHeight / 0.5 // Position directly below search bar
//                    
//                 
//                )
//                .animation(.easeInOut(duration: 0.2), value: isDropdownVisible)
//                .zIndex(2)
//            }
//        }
//        .zIndex(3)
//    }
//    
//    
//    
//    
////    private var dropdownYPosition: CGFloat {
////            if let position = storedDropdownPosition {
////                // Use the stored position if available
////                return position
////            }
////
////            // Save the position
////            storedDropdownPosition = position
////
////            return position
////        }
//    
////    private var dropdownYPosition: CGFloat {
////        if let position = storedDropdownPosition {
////            // Use the stored position if available
////            return position
////        }
////
////        // Calculate the position (replace this with your actual logic)
////        let calculatedPosition: CGFloat = 100.0 // Example value
////
////        // Save the position
////        storedDropdownPosition = calculatedPosition
////
////        return calculatedPosition
////    }
//    
//    private var dropdownYPosition: CGFloat {
//        if let position = storedDropdownPosition {
//            return position
//        }
//
//        let basePosition = searchBarYPosition + elementHeight
//
//        // Dynamic adjustment logic
//        let adjustedOffset: CGFloat = UIScreen.main.bounds.height < 700 ? 22 : 5
//
//        let position = basePosition + adjustedOffset
//        storedDropdownPosition = position
//
//        return position
//    }
//
//
//    
//    
//    
//   
//    private var filteredCities: [String] {
//        cities.filter { $0.lowercased().contains(searchQuery.lowercased()) || searchQuery.isEmpty }
//    }
//   
//
//
//    // Helper function to reset user inputs
//    private func resetUserInputs() {
//        selectedCity = "Enter destination" // Reset destination
//        selectedDays = 5 // Reset days to the default value
//        selectedTripTypes = [] // Clear trip types
//        isDropdownVisible = false
//        searchQuery = ""
//       
//    }
//
//    // Reset the plan controller (clear previous trip data)
//    private func resetPlanController() {
//        planController.locationActivitiesByDay = [] // Clear previous activities
//        planController.isLoading = false // Stop loading
//        planController.hasGeneratedActivities = false // Mark activities as not generated yet
//        print("Previous search data cleared and ready for new search.")
//    }
//
//    // Custom button view for trip types
//    private func tripTypeButton(title: String) -> some View {
//        Text(title)
//            .font(.headline)
//            .padding()
//            .frame(width: (buttonWidth - 10) / 2, height: elementHeight)
//            .background(selectedTripTypes.contains(title) ? Color(red: 96/255, green: 131/255, blue: 153/255) : Color(red: 200/255, green: 228/255, blue: 250/255))
//            .foregroundColor(selectedTripTypes.contains(title) ? Color.white : Color.black)
//            .cornerRadius(8)
//            .onTapGesture {
//                if selectedTripTypes.contains(title) {
//                    selectedTripTypes.remove(title)
//                } else {
//                    selectedTripTypes.insert(title)
//                }
//                print("Selected Trip Types: \(selectedTripTypes)")
//            }
//    }
//
//    // Tab Bar item creation helper
//    private func TabBarItem(iconName: String, label: String, isSelected: Bool = false, userUID: String) -> some View {
//        VStack {
//            Image(systemName: iconName)
//                .foregroundColor(isSelected ? gradientEndColor : .blue)
//            Text(label)
//                .font(.footnote)
//                .foregroundColor(isSelected ? gradientEndColor : .blue)
//        }
//        .padding(.vertical, 10)
//        .background(isSelected ? gradientEndColor.opacity(0.2) : Color.clear)
//        .cornerRadius(10)
//        .onTapGesture {
//            switch label {
//            case "Plan Trip":
//                // Restore dropdown position when navigating back
//                hasCalculatedDropdownPosition = true
//                
//                storedDropdownPosition = nil // Clear old position so it recalculates
//            case "Past Trips":
//                // Store dropdown position before navigating away
//                storedDropdownPosition = dropdownYPosition
//                
//                if let window = UIApplication.shared.windows.first {
//                    window.rootViewController = UIHostingController(rootView: PastTripsView(userUID: userUID))
//                    window.makeKeyAndVisible()
//                }
//            case "Settings":
//                if let window = UIApplication.shared.windows.first {
//                    window.rootViewController = UIHostingController(rootView: SettingsView(userUID: userUID))
//                    window.makeKeyAndVisible()
//                }
//            default:
//                break
//            }
//        }
//    }
//
//}
//// Preference Key for capturing the view offset
//struct ViewOffsetKey: PreferenceKey {
//    static var defaultValue: CGFloat = 0
//    static func reduce(value: inout CGFloat, nextValue: () -> CGFloat) {
//        value = nextValue()
//    }
//}
//
//struct BlurView: UIViewRepresentable {
//    var style: UIBlurEffect.Style
//
//    func makeUIView(context: Context) -> UIVisualEffectView {
//        let blurEffect = UIBlurEffect(style: style)
//        let blurView = UIVisualEffectView(effect: blurEffect)
//        return blurView
//    }
//
//    func updateUIView(_ uiView: UIVisualEffectView, context: Context) {
//        // No updates needed
//    }
//}






import SwiftUI


struct SecondView: View {
    @State private var selectedCity: String = "Enter destination"
    @State private var selectedDays: Int = 5
    @State private var selectedTripTypes: Set<String> = []
    @StateObject private var planController = PlanController() // Create PlanController instance
    @State private var isDropdownVisible: Bool = false // For showing/hiding the dropdown
    @State private var searchQuery: String = "" // For filtering the cities
    @State private var dropdownOffset: CGFloat = 0
    @State private var searchBarYPosition: CGFloat = 0.0
    @State private var navigateToItinerary: Bool = false // Manage navigation state
    @State private var showAlert: Bool = false // Manage alert state
    @State private var storedDropdownPosition: CGFloat? = nil
    @State private var hasCalculatedDropdownPosition = false


    let daysOptions = [1, 2, 3, 4, 5, 6, 7, 8]
    let cities = ["Abuja, Nigeria", "Accra, Ghana", "Addis Ababa, Ethiopia", "Amsterdam, Netherlands", "Asunción, Paraguay", "Athens, Greece", "Auckland, New Zealand", "Austin, USA", "Bali, Indonesia", "Bangkok, Thailand", "Banjul, Gambia", "Barcelona, Spain", "Beijing, China", "Belgrade, Serbia", "Bendigo, Australia", "Berlin, Germany", "Bogota, Colombia", "Boston, USA", "Brisbane, Australia", "Buenos Aires, Argentina", "Budapest, Hungary", "Cairo, Egypt", "Calgary, Canada", "Cancun, Mexico", "Canberra, Australia", "Cape Town, South Africa", "Cartagena, Colombia", "Casablanca, Morocco", "Chennai, India", "Chicago, USA", "Colombo, Sri Lanka", "Copenhagen, Denmark", "Curitiba, Brazil", "Cusco, Peru", "Dakar, Senegal", "Delhi, India", "Dubai, UAE", "Dublin, Ireland", "Dunedin, New Zealand", "Durban, South Africa", "Edinburgh, Scotland", "Florence, Italy", "Fortaleza, Brazil", "Geneva, Switzerland", "Geelong, Australia", "Gold Coast, Australia", "Hamilton, New Zealand", "Hanoi, Vietnam", "Helsinki, Finland", "Hobart, Australia", "Ho Chi Minh City, Vietnam", "Honolulu, USA", "Hong Kong, China", "Istanbul, Turkey", "Jakarta, Indonesia", "Jerusalem, Israel", "Jamnagar, India", "Johannesburg, South Africa", "Karachi, Pakistan", "Kolkata, India", "Kuala Lumpur, Malaysia", "Kyoto, Japan", "La Paz, Bolivia", "Lagos, Nigeria", "Las Vegas, USA", "Lima, Peru", "Lisbon, Portugal", "London, England", "Los Angeles, USA", "Madrid, Spain", "Manila, Philippines", "Maldives, Maldives", "Maputo, Mozambique", "Mar del Plata, Argentina", "Marrakech, Morocco", "Melbourne, Australia", "Mendoza, Argentina", "Mexico City, Mexico", "Miami, USA", "Montevideo, Uruguay", "Montreal, Canada", "Moscow, Russia", "Mumbai, India", "Nairobi, Kenya", "Napier, New Zealand", "New Orleans, USA", "New York City, USA", "Ottawa, Canada", "Paris, France", "Perth, Australia", "Portland, USA", "Prague, Czech Republic", "Punta Cana, Dominican Republic", "Quebec City, Canada", "Queenstown, New Zealand", "Quito, Ecuador", "Rio de Janeiro, Brazil", "Rome, Italy", "Salvador, Brazil", "San Diego, USA", "San Francisco, USA", "Santorini, Greece", "Santiago, Chile", "São Paulo, Brazil", "Seattle, USA", "Shanghai, China", "Singapore, Singapore", "Stockholm, Sweden", "Suva, Fiji", "Sydney, Australia", "Tauranga, New Zealand", "Tokyo, Japan", "Toronto, Canada", "Tunis, Tunisia", "Udaipur, India", "Vancouver, Canada", "Victoria Falls, Zimbabwe/Zambia", "Vienna, Austria", "Washington, D.C., USA", "Wellington, New Zealand", "Windhoek, Namibia", "Yellowstone, USA", "Yokohama, Japan", "Zanzibar City, Tanzania", "Zurich, Switzerland"]

    let elementHeight: CGFloat = UIScreen.main.bounds.height * 0.05
    let buttonWidth: CGFloat = UIScreen.main.bounds.width * 0.75
   

    let gradientStartColor = Color(UIColor(red: 141/255, green: 172/255, blue: 225/255, alpha: 1))
    let gradientEndColor = Color(UIColor(red: 41/255, green: 102/255, blue: 117/255, alpha: 1))

    var userUID: String

    var body: some View {
        ZStack {
            // Background to detect taps outside the dropdown
            if isDropdownVisible {
//                Color.black.opacity(0.01) // Slight opacity to ensure taps are captured
//                    .edgesIgnoringSafeArea(.all)
//                    .zIndex(1) // Ensures this is above other elements
//                    .onTapGesture {
//                        isDropdownVisible = false
//                    }
                Rectangle()
                        .foregroundColor(Color.black.opacity(0.01)) // Keep it transparent for capturing taps
                        .ignoresSafeArea() // Only apply to safe area
                        .onTapGesture {
                            isDropdownVisible = false // Close dropdown on tap
                            UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
                        }
                        .zIndex(1) // Ensure it stays above other elements
            }
           
            NavigationView {
                ZStack {
                    Color.white
                        .edgesIgnoringSafeArea(.all)
                   
                    VStack(spacing: UIScreen.main.bounds.height * 0.03) {
                        // Top Gradient Box
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
                                    .padding(.top, UIScreen.main.bounds.height * 0.12)
                               
                                // Search Bar
                                HStack {
                                    Image(systemName: "magnifyingglass")
                                        .foregroundColor(.gray)
                                    TextField("Enter destination", text: $searchQuery)
                                        .onTapGesture {
                                            isDropdownVisible = true
                                        }
                                        .onChange(of: searchQuery) { newValue in
                                                // Show dropdown only if the search query is not empty
                                                isDropdownVisible = !newValue.isEmpty
                                            }
//                                        .onChange(of: searchQuery) { _ in
//                                            isDropdownVisible = true
//                                        }
                                        .background(
                                            GeometryReader { geometry in
                                                Color.clear.onAppear {
                                                    // Capture the Y position of the search bar
                                                    if !hasCalculatedDropdownPosition {
                                                                // Only set if not calculated
                                                                searchBarYPosition = geometry.frame(in: .global).maxY
                                                            }
                                                }
                                            }
                                        )
                                    Spacer()
                                    Image(systemName: "chevron.down")
                                        .foregroundColor(.blue)
                                }
                                .padding()
                                .background(Color.white)
                                .frame(width: buttonWidth, height: elementHeight)
                                .cornerRadius(10)
                                .shadow(radius: 2)
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
                       
                        // Trip Type Selection
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
                       
                     
                       
                            // NavigationLink managed by `navigateToItinerary`
                            NavigationLink(
                                destination: ItineraryView(
                                    location: selectedCity,
                                    days: selectedDays,
                                    userUID: userUID,
                                    selectedTripType: selectedTripTypes.first ?? "Relaxing",
                                    planController: planController
                                ),
                                isActive: $navigateToItinerary
                            ) {
                                EmptyView()
                            }

                            // Plan Trip Button
                            Button(action: {
                                if selectedCity == "Enter destination" {
                                    showAlert = true // Show alert if no destination is selected
                                } else {
                                    navigateToItinerary = true // Trigger navigation
                                }
                            }) {
                                Text("Plan Your Next Trip!")
                                    .font(.headline)
                                    .padding()
                                    .frame(width: buttonWidth, height: elementHeight)
                                    .background(selectedCity != "Enter destination" ? Color.teal : Color.gray) // Indicate disabled visually
                                    .foregroundColor(.white)
                                    .cornerRadius(UIScreen.main.bounds.width * 0.02)
                            }
                            .alert(isPresented: $showAlert) {
                                Alert(
                                    title: Text("No Destination Selected"),
                                    message: Text("Please select a destination before planning your trip."),
                                    dismissButton: .default(Text("OK"))
                                )
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
                        .frame(height: UIScreen.main.bounds.height * 0.1)
                        .background(Color.white)
                        .cornerRadius(UIScreen.main.bounds.width * 0.02)
                        .shadow(radius: UIScreen.main.bounds.width * 0.01)
                        .padding(.bottom, UIScreen.main.bounds.height * 0.01)
                        .zIndex(2)
                    }
                }
                .onAppear {
                    if !hasCalculatedDropdownPosition {
                            // Recalculate only if not already calculated
                            storedDropdownPosition = nil
                            hasCalculatedDropdownPosition = true
                        }
                        resetUserInputs() // Clear inputs when back button is pressed
                        resetPlanController() // Reset the plan controller
                        storedDropdownPosition = nil
                    }
            }
           

            // Dropdown Overlay
            if isDropdownVisible {
                let filteredCities = cities.filter {
                    $0.lowercased().contains(searchQuery.lowercased()) || searchQuery.isEmpty
                }
                ScrollView {
                    VStack(spacing: 0) {
                        if filteredCities.isEmpty {
                            // Display "No match found" message
                            Text("No match found")
                                .padding()
                                .frame(maxWidth: .infinity)
                                .frame(height: elementHeight)
                                .background(Color.white)
                                .foregroundColor(.black)
                                .cornerRadius(10)
                                .shadow(radius: 2)
                        } else {
                            ForEach(filteredCities, id: \.self) { city in
                                Button(action: {
                                    selectedCity = city
                                    searchQuery = city
                                    isDropdownVisible = false
                                    UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
                                }) {
                                    Text(city)
                                        .padding()
                                        .frame(maxWidth: .infinity, alignment: .leading)
                                        .background(Color.white)
                                        .foregroundColor(.black)
                                }
                                Divider()
                            }
                        }
                    }
                }
                .frame(
                    width: buttonWidth,
                    height: filteredCities.isEmpty
                        ? elementHeight
                        : min(CGFloat(filteredCities.count) * elementHeight, UIScreen.main.bounds.height * 0.3)
                )
                .background(Color.white)
                .cornerRadius(10)
                .shadow(radius: 2)
                .position(
                    x: UIScreen.main.bounds.width / 2,
                    y: dropdownYPosition // Dynamically calculated position
                    //y: searchBarYPosition + elementHeight / 0.169
                )
                

                .animation(.easeInOut(duration: 0.2), value: isDropdownVisible)
                .zIndex(2)
            }
        }
        .zIndex(3)
    }
   
    private var filteredCities: [String] {
        cities.filter { $0.lowercased().contains(searchQuery.lowercased()) || searchQuery.isEmpty }
    }

    
    // go back to this
//    private var dropdownYPosition: CGFloat {
//        if let position = storedDropdownPosition {
//            // Use the stored position if available
//            return position
//        }
//
//        // Base position is calculated relative to the search bar
//        let basePosition = searchBarYPosition + elementHeight + 8 // Add small padding
//
//        // Safe area adjustment to ensure no overlap with the notch or other areas
//        let safeAreaInset = UIApplication.shared.connectedScenes
//            .compactMap { $0 as? UIWindowScene }
//            .first?.windows.first?.safeAreaInsets.top ?? 0
//
//        // Adjust for smaller devices dynamically
//        let screenHeight = UIScreen.main.bounds.height
//        let deviceAdjustment: CGFloat = {
//            switch screenHeight {
//            case ..<700: // iPhone SE and similar
//                return 5
//            case 700..<800: // iPhone 13 Mini
//                return 10
//            default: // Larger devices
//                return 0
//            }
//        }()
//
//        // Combine base position with adjustments
//        let position = basePosition + safeAreaInset + deviceAdjustment
//
//        // Cache the calculated position
//        storedDropdownPosition = position
//
//        return position
//    }


    private var dropdownYPosition: CGFloat {
        if let position = storedDropdownPosition {
            return position // Use stored position if available
        }

        // Add margin below the search bar
        //let margin: CGFloat = 8 // Adjust this value for more spacing
        let margin: CGFloat = elementHeight * 5
        let basePosition = searchBarYPosition + elementHeight + margin

        // Safe area adjustment for devices with notches
        let safeAreaInset = UIApplication.shared.connectedScenes
            .compactMap { $0 as? UIWindowScene }
            .first?.windows.first?.safeAreaInsets.top ?? 0

        // Additional adjustment for small screens
        let screenHeight = UIScreen.main.bounds.height
        let deviceAdjustment: CGFloat = {
            switch screenHeight {
            case ..<700: // Small devices like iPhone SE
                return 5
            default: // Other devices
                return 0
            }
        }()

        // Combine base position and adjustments
        let position = basePosition + safeAreaInset + deviceAdjustment

        // Cache the calculated position
        storedDropdownPosition = position

        return position
    }






    // Helper function to reset user inputs
    private func resetUserInputs() {
        selectedCity = "Enter destination" // Reset destination
        selectedDays = 5 // Reset days to the default value
        selectedTripTypes = [] // Clear trip types
        isDropdownVisible = false
        searchQuery = ""
       
    }

    // Reset the plan controller (clear previous trip data)
    private func resetPlanController() {
        planController.locationActivitiesByDay = [] // Clear previous activities
        planController.isLoading = false // Stop loading
        planController.hasGeneratedActivities = false // Mark activities as not generated yet
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
                // Restore dropdown position when navigating back
                hasCalculatedDropdownPosition = true
            case "Past Trips":
                // Store dropdown position before navigating away
                storedDropdownPosition = dropdownYPosition
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
// Preference Key for capturing the view offset
struct ViewOffsetKey: PreferenceKey {
    static var defaultValue: CGFloat = 0
    static func reduce(value: inout CGFloat, nextValue: () -> CGFloat) {
        value = nextValue()
    }
}

struct BlurView: UIViewRepresentable {
    var style: UIBlurEffect.Style

    func makeUIView(context: Context) -> UIVisualEffectView {
        let blurEffect = UIBlurEffect(style: style)
        let blurView = UIVisualEffectView(effect: blurEffect)
        return blurView
    }

    func updateUIView(_ uiView: UIVisualEffectView, context: Context) {
        // No updates needed
    }
}
