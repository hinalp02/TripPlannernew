//
//// Sruthi's and hinal's code integrated
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
//    let cities = ["Abuja, Nigeria", "Accra, Ghana", "Addis Ababa, Ethiopia", "Amsterdam, Netherlands", "Asunción, Paraguay", "Athens, Greece", "Auckland, New Zealand", "Austin, USA", "Bali, Indonesia", "Bangkok, Thailand", "Banjul, Gambia", "Barcelona, Spain", "Beijing, China", "Belgrade, Serbia", "Bendigo, Australia", "Berlin, Germany", "Bogota, Colombia", "Boston, USA", "Brisbane, Australia", "Buenos Aires, Argentina", "Budapest, Hungary", "Cairo, Egypt", "Calgary, Canada", "Cancun, Mexico", "Canberra, Australia", "Cape Town, South Africa", "Cartagena, Colombia", "Casablanca, Morocco", "Chennai, India", "Chicago, USA", "Colombo, Sri Lanka", "Copenhagen, Denmark", "Curitiba, Brazil", "Cusco, Peru", "Dakar, Senegal", "Delhi, India", "Dubai, UAE", "Dublin, Ireland", "Dunedin, New Zealand", "Durban, South Africa", "Edinburgh, Scotland", "Florence, Italy", "Fortaleza, Brazil", "Geneva, Switzerland", "Geelong, Australia", "Gold Coast, Australia", "Hamilton, New Zealand", "Hanoi, Vietnam", "Helsinki, Finland", "Hobart, Australia", "Ho Chi Minh City, Vietnam", "Honolulu, USA", "Hong Kong, China", "Istanbul, Turkey", "Jakarta, Indonesia", "Jerusalem, Israel", "Jamnagar, India", "Johannesburg, South Africa", "Karachi, Pakistan", "Kolkata, India", "Kuala Lumpur, Malaysia", "Kyoto, Japan", "La Paz, Bolivia", "Lagos, Nigeria", "Las Vegas, USA", "Lima, Peru", "Lisbon, Portugal", "London, England", "Los Angeles, USA", "Madrid, Spain", "Manali, India", "Manila, Philippines", "Maldives, Maldives", "Maputo, Mozambique", "Mar del Plata, Argentina", "Marrakech, Morocco", "Melbourne, Australia", "Mendoza, Argentina", "Mexico City, Mexico", "Miami, USA", "Montevideo, Uruguay", "Montreal, Canada", "Moscow, Russia", "Mumbai, India", "Nairobi, Kenya", "Napier, New Zealand", "New Orleans, USA", "New York City, USA", "Ottawa, Canada", "Paris, France", "Perth, Australia", "Portland, USA", "Prague, Czech Republic", "Punta Cana, Dominican Republic", "Quebec City, Canada", "Queenstown, New Zealand", "Quito, Ecuador", "Rio de Janeiro, Brazil", "Rome, Italy", "Salvador, Brazil", "San Diego, USA", "San Francisco, USA", "Santorini, Greece", "Santiago, Chile", "São Paulo, Brazil", "Seattle, USA", "Shanghai, China", "Singapore, Singapore", "Stockholm, Sweden", "Suva, Fiji", "Sydney, Australia", "Tauranga, New Zealand", "Tokyo, Japan", "Toronto, Canada", "Tunis, Tunisia", "Udaipur, India", "Vancouver, Canada", "Victoria Falls, Zimbabwe/Zambia", "Vienna, Austria", "Washington, D.C., USA", "Wellington, New Zealand", "Windhoek, Namibia", "Yellowstone, USA", "Yokohama, Japan", "Zanzibar City, Tanzania", "Zurich, Switzerland"]
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
//                                .padding(.top, -UIScreen.main.bounds.height * 0.1)
//                                .edgesIgnoringSafeArea(.top)
//
//                            VStack {
//                                Text("Where are you headed?")
//                                    .font(.title)
//                                    .foregroundColor(.white)
//                                    .padding(.top, UIScreen.main.bounds.height * 0.03) // Adjusted padding for better alignment
//
//                                // search bar
//                                HStack {
//                                    Image(systemName: "magnifyingglass")
//                                        .foregroundColor(.gray)
//                                    TextField("Enter destination", text: $searchQuery)
//                                        .padding()
//                                        .background(Color.white)
//                                        .cornerRadius(10)
//                                        .shadow(radius: 2)
//                                        .onTapGesture {
//                                            isDropdownVisible = true
//                                        }
//                                        .onChange(of: searchQuery) { newValue in
//                                            isDropdownVisible = !newValue.isEmpty
//                                        }
//                                    Spacer()
//                                    Image(systemName: "chevron.down")
//                                        .foregroundColor(.blue)
//                                }
//                                .padding()
//                                .background(
//                                    GeometryReader { geometry in
//                                        Color.clear
//                                            .onAppear {
//                                                searchBarYPosition = geometry.frame(in: .global).maxY // Get the bottom Y position of the search bar
//                                            }
//                                            .onChange(of: searchQuery) { _ in
//                                                searchBarYPosition = geometry.frame(in: .global).maxY
//                                            }
//                                    }
//                                )
//                                .background(Color(.white))
//                                .frame(width: buttonWidth, height: elementHeight)
//                                .cornerRadius(10)
//                                .shadow(radius: 2)
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
//                        .padding(.top, -UIScreen.main.bounds.height * 0.1)
//
//                        Picker("How many days will you be gone for?", selection: $selectedDays) {
//                            ForEach(daysOptions, id: \.self) { day in
//                                Text("\(day) Days")
//                            }
//                        }
//                        .pickerStyle(MenuPickerStyle())
//                        .frame(width: buttonWidth, height: elementHeight)
//                        .background(Color(.white))
//                        .cornerRadius(UIScreen.main.bounds.width * 0.02)
//                        .overlay(
//                            RoundedRectangle(cornerRadius: UIScreen.main.bounds.width * 0.02)
//                                .stroke(Color(red: 96/255, green: 131/255, blue: 153/255, opacity: 255/255), lineWidth: 3)
//                        )
//                        .padding(.horizontal)
//                        .padding(.top, -UIScreen.main.bounds.height * 0.03)
//
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
//                                selectedTripType: selectedTripTypes.joined(separator: ", "), // Pass all selected filters
//                                planController: planController
//                            ),
//                            isActive: $navigateToItinerary
//                        ) {
//                            EmptyView()
//                        }
//
//                        // Plan Trip Button
//                        Button(action: {
//                            if selectedCity == "Enter destination" {
//                                showAlert = true // Show alert if no destination is selected
//                            } else {
//                                navigateToItinerary = true // Trigger navigation
//                            }
//                        }) {
//                            Text("Plan Your Next Trip!")
//                                .font(.headline)
//                                .padding()
//                                .frame(width: buttonWidth, height: elementHeight)
//                                .background(Color.teal)
//                                .foregroundColor(.white)
//                                .cornerRadius(UIScreen.main.bounds.width * 0.02)
//                        }
//                        .alert(isPresented: $showAlert) {
//                            Alert(
//                                title: Text("No Destination Selected"),
//                                message: Text("Please select a destination before planning your trip."),
//                                dismissButton: .default(Text("OK"))
//                            )
//                        }
//                        .padding(.horizontal)
//
//                        Spacer()
//                    }
//                    .edgesIgnoringSafeArea(.bottom)
//                    .onAppear {
//                        resetUserInputs()  // Reset inputs when the view appears
//                        resetPlanController()  // Clear previous trip data only when on the Plan Trip screen
//                    }
//                }
//            }
//
//            if isDropdownVisible {
//                let filteredCities = cities.filter { $0.lowercased().contains(searchQuery.lowercased()) } // Adjusted filtering logic
//                VStack(spacing: 0) {
//                    ScrollView {
//                        VStack(spacing: 0) {
//                            if filteredCities.isEmpty {
//                                // No match found message
//                                Text("No match found")
//                                    .padding()
//                                    .frame(maxWidth: .infinity, alignment: .center)
//                                    .background(Color.white)
//                                    .foregroundColor(.black)
//                                    .cornerRadius(10)
//                                    .shadow(radius: 2)
//                            } else {
//                                // Display filtered cities
//                                ForEach(filteredCities, id: \.self) { city in
//                                    Button(action: {
//                                        selectedCity = city
//                                        searchQuery = city
//                                        isDropdownVisible = false
//                                    }) {
//                                        Text(city)
//                                            .padding()
//                                            .frame(maxWidth: .infinity, alignment: .leading)
//                                            .background(Color.white)
//                                            .foregroundColor(.black)
//                                    }
//                                    Divider()
//                                }
//                            }
//                        }
//                    }
//                    .frame(maxHeight: filteredCities.isEmpty ? elementHeight : min(CGFloat(filteredCities.count) * elementHeight, UIScreen.main.bounds.height * 0.4)) // Adjusted height logic
//                }
//                .frame(width: buttonWidth)
//                .background(Color.white)
//                .cornerRadius(10)
//                .shadow(radius: 2)
//                .position(
//                    x: UIScreen.main.bounds.width / 2,
////                    y: searchBarYPosition + elementHeight / 2 + (min(CGFloat(filteredCities.count) * elementHeight, UIScreen.main.bounds.height * 0.4) / 2) + dropdownYOffsetAdjustment() // Position remains the same
//                    y: searchBarYPosition + elementHeight / 2 + (filteredCities.isEmpty ? elementHeight / 2 : (min(CGFloat(filteredCities.count) * elementHeight, UIScreen.main.bounds.height * 0.4) / 2)) + dropdownYOffsetAdjustment()
//
//                )
//                .animation(.easeInOut(duration: 0.2), value: isDropdownVisible)
//                .zIndex(2)
//            }
//
//        }
//    }
//
//    private var filteredCities: [String] {
//        cities.filter { $0.lowercased().contains(searchQuery.lowercased()) }
//    }
//
//    private func dropdownYOffsetAdjustment() -> CGFloat {
//        let height = UIScreen.main.bounds.height
//        if height >= 926 { // iPhone 12 Pro Max, 13 Pro Max, 14 Pro Max, etc.
//            return -140 // Adjust for Pro Max
//        } else if height >= 812 { // iPhone X, 11 Pro, 12, 13, etc.
//            return -137 // Adjust for Pro
//        } else if height <= 667 { // iPhone SE (1st/2nd gen), iPhone 8, etc.
//            return -105 // Adjust for SE
//        } else {
//            return -140 // Default adjustment
//        }
//    }
//
//    private var dropdownYPosition: CGFloat {
//        searchBarYPosition + 5
//    }
//
//    // Helper function to reset user inputs
//    private func resetUserInputs() {
//        selectedCity = "Enter destination" // Reset destination
//        selectedDays = 5 // Reset days to the default value
//        selectedTripTypes = [] // Clear trip types
//        isDropdownVisible = false
//        searchQuery = ""
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
//}
//
//
//
//

// Sruthi's and hinal's code integrated
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

    let daysOptions = [1, 2, 3, 4, 5, 6, 7, 8]
    let cities = ["Abuja, Nigeria", "Accra, Ghana", "Addis Ababa, Ethiopia", "Amsterdam, Netherlands", "Asunción, Paraguay", "Athens, Greece", "Auckland, New Zealand", "Austin, USA", "Bali, Indonesia", "Bangkok, Thailand", "Banjul, Gambia", "Barcelona, Spain", "Beijing, China", "Belgrade, Serbia", "Bendigo, Australia", "Berlin, Germany", "Bogota, Colombia", "Boston, USA", "Brisbane, Australia", "Buenos Aires, Argentina", "Budapest, Hungary", "Cairo, Egypt", "Calgary, Canada", "Cancun, Mexico", "Canberra, Australia", "Cape Town, South Africa", "Cartagena, Colombia", "Casablanca, Morocco", "Chennai, India", "Chicago, USA", "Colombo, Sri Lanka", "Copenhagen, Denmark", "Curitiba, Brazil", "Cusco, Peru", "Dakar, Senegal", "Delhi, India", "Dubai, UAE", "Dublin, Ireland", "Dunedin, New Zealand", "Durban, South Africa", "Edinburgh, Scotland", "Florence, Italy", "Fortaleza, Brazil", "Geneva, Switzerland", "Geelong, Australia", "Gold Coast, Australia", "Hamilton, New Zealand", "Hanoi, Vietnam", "Helsinki, Finland", "Hobart, Australia", "Ho Chi Minh City, Vietnam", "Honolulu, USA", "Hong Kong, China", "Istanbul, Turkey", "Jakarta, Indonesia", "Jerusalem, Israel", "Jamnagar, India", "Johannesburg, South Africa", "Karachi, Pakistan", "Kolkata, India", "Kuala Lumpur, Malaysia", "Kyoto, Japan", "La Paz, Bolivia", "Lagos, Nigeria", "Las Vegas, USA", "Lima, Peru", "Lisbon, Portugal", "London, England", "Los Angeles, USA", "Madrid, Spain", "Manali, India", "Manila, Philippines", "Maldives, Maldives", "Maputo, Mozambique", "Mar del Plata, Argentina", "Marrakech, Morocco", "Melbourne, Australia", "Mendoza, Argentina", "Mexico City, Mexico", "Miami, USA", "Montevideo, Uruguay", "Montreal, Canada", "Moscow, Russia", "Mumbai, India", "Nairobi, Kenya", "Napier, New Zealand", "New Orleans, USA", "New York City, USA", "Ottawa, Canada", "Paris, France", "Perth, Australia", "Portland, USA", "Prague, Czech Republic", "Punta Cana, Dominican Republic", "Quebec City, Canada", "Queenstown, New Zealand", "Quito, Ecuador", "Rio de Janeiro, Brazil", "Rome, Italy", "Salvador, Brazil", "San Diego, USA", "San Francisco, USA", "Santorini, Greece", "Santiago, Chile", "São Paulo, Brazil", "Seattle, USA", "Shanghai, China", "Singapore, Singapore", "Stockholm, Sweden", "Suva, Fiji", "Sydney, Australia", "Tauranga, New Zealand", "Tokyo, Japan", "Toronto, Canada", "Tunis, Tunisia", "Udaipur, India", "Vancouver, Canada", "Victoria Falls, Zimbabwe/Zambia", "Vienna, Austria", "Washington, D.C., USA", "Wellington, New Zealand", "Windhoek, Namibia", "Yellowstone, USA", "Yokohama, Japan", "Zanzibar City, Tanzania", "Zurich, Switzerland"]

    let elementHeight: CGFloat = UIScreen.main.bounds.height * 0.05
    let buttonWidth: CGFloat = UIScreen.main.bounds.width * 0.75

    let gradientStartColor = Color(UIColor(red: 141/255, green: 172/255, blue: 225/255, alpha: 1))
    let gradientEndColor = Color(UIColor(red: 41/255, green: 102/255, blue: 117/255, alpha: 1))

    var userUID: String

    var body: some View {
        ZStack {
            // Background to detect taps outside the dropdown
            if isDropdownVisible {
                Color.black.opacity(0.01) // Slight opacity to ensure taps are captured
                    .edgesIgnoringSafeArea(.all)
                    .zIndex(1) // Ensures this is above other elements
                    .onTapGesture {
                        isDropdownVisible = false
                    }
            }

           
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
                                .padding(.top, -UIScreen.main.bounds.height * 0.1)
                                .edgesIgnoringSafeArea(.top)

                            VStack {
                                Text("Where are you headed?")
                                    .font(.title)
                                    .foregroundColor(.white)
                                    .padding(.top, UIScreen.main.bounds.height * 0.03) // Adjusted padding for better alignment

                                // search bar
                                HStack {
                                    Image(systemName: "magnifyingglass")
                                        .foregroundColor(.gray)
                                    TextField("Enter destination", text: $searchQuery)
                                        .padding()
                                        .background(Color.white)
                                        .cornerRadius(10)
                                        .shadow(radius: 2)
                                        .onTapGesture {
                                            isDropdownVisible = true
                                        }
                                        .onChange(of: searchQuery) { newValue in
                                            isDropdownVisible = !newValue.isEmpty
                                        }
                                    Spacer()
                                    Image(systemName: "chevron.down")
                                        .foregroundColor(.blue)
                                }
                                .padding()
                                .background(
                                    GeometryReader { geometry in
                                        Color.clear
                                            .onAppear {
                                                searchBarYPosition = geometry.frame(in: .global).maxY // Get the bottom Y position of the search bar
                                            }
                                            .onChange(of: searchQuery) { _ in
                                                searchBarYPosition = geometry.frame(in: .global).maxY
                                            }
                                    }
                                )
                                .background(Color(.white))
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
                        .padding(.top, -UIScreen.main.bounds.height * 0.1)

                        Picker("How many days will you be gone for?", selection: $selectedDays) {
                            ForEach(daysOptions, id: \.self) { day in
                                Text("\(day) Days")
                            }
                        }
                        .pickerStyle(MenuPickerStyle())
                        .frame(width: buttonWidth, height: elementHeight)
                        .background(Color(.white))
                        .cornerRadius(UIScreen.main.bounds.width * 0.02)
                        .overlay(
                            RoundedRectangle(cornerRadius: UIScreen.main.bounds.width * 0.02)
                                .stroke(Color(red: 96/255, green: 131/255, blue: 153/255, opacity: 255/255), lineWidth: 3)
                        )
                        .padding(.horizontal)
                        .padding(.top, -UIScreen.main.bounds.height * 0.03)

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
                                selectedTripType: selectedTripTypes.joined(separator: ", "), // Pass all selected filters
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
                                .background(Color.teal)
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
                    }
                    .edgesIgnoringSafeArea(.bottom)
                    .onAppear {
                        resetUserInputs()  // Reset inputs when the view appears
                        resetPlanController()  // Clear previous trip data only when on the Plan Trip screen
                    }
                }
            

            if isDropdownVisible {
                let filteredCities = cities.filter { $0.lowercased().contains(searchQuery.lowercased()) } // Adjusted filtering logic
                VStack(spacing: 0) {
                    ScrollView {
                        VStack(spacing: 0) {
                            if filteredCities.isEmpty {
                                // No match found message
                                Text("No match found")
                                    .padding()
                                    .frame(maxWidth: .infinity, alignment: .center)
                                    .background(Color.white)
                                    .foregroundColor(.black)
                                    .cornerRadius(10)
                                    .shadow(radius: 2)
                            } else {
                                // Display filtered cities
                                ForEach(filteredCities, id: \.self) { city in
                                    Button(action: {
                                        selectedCity = city
                                        searchQuery = city
                                        isDropdownVisible = false
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
                    .frame(maxHeight: filteredCities.isEmpty ? elementHeight : min(CGFloat(filteredCities.count) * elementHeight, UIScreen.main.bounds.height * 0.4)) // Adjusted height logic
                }
                .frame(width: buttonWidth)
                .background(Color.white)
                .cornerRadius(10)
                .shadow(radius: 2)
                .position(
                    x: UIScreen.main.bounds.width / 2,
//                    y: searchBarYPosition + elementHeight / 2 + (min(CGFloat(filteredCities.count) * elementHeight, UIScreen.main.bounds.height * 0.4) / 2) + dropdownYOffsetAdjustment() // Position remains the same
                    y: searchBarYPosition + elementHeight / 2 + (filteredCities.isEmpty ? elementHeight / 2 : (min(CGFloat(filteredCities.count) * elementHeight, UIScreen.main.bounds.height * 0.4) / 2)) + dropdownYOffsetAdjustment()

                )
                .animation(.easeInOut(duration: 0.2), value: isDropdownVisible)
                .zIndex(2)
            }

        }
    }

    private var filteredCities: [String] {
        cities.filter { $0.lowercased().contains(searchQuery.lowercased()) }
    }

    private func dropdownYOffsetAdjustment() -> CGFloat {
        let height = UIScreen.main.bounds.height
        if height >= 926 { // iPhone 12 Pro Max, 13 Pro Max, 14 Pro Max, etc.
            return -140 // Adjust for Pro Max
        } else if height >= 812 { // iPhone X, 11 Pro, 12, 13, etc.
            return -137 // Adjust for Pro
        } else if height <= 667 { // iPhone SE (1st/2nd gen), iPhone 8, etc.
            return -105 // Adjust for SE
        } else {
            return -140 // Default adjustment
        }
    }

    private var dropdownYPosition: CGFloat {
        searchBarYPosition + 5
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

}




