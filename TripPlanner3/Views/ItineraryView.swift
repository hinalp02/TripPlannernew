////
////  ItineraryView.swift
////  TripPlanner3
////
////  Created by stlp on 9/14/24.
////
//
//import SwiftUI
//
//// For the itinerary page display right after user input
//struct ItineraryView: View {
//    var location: String  // name of the location
//    var days: Int  // number of days for the trip
//    var userUID: String  // Add userUID
//    @ObservedObject var planController: PlanController
//
//    // height and width of the buttons for each day
//    let buttonHeight: CGFloat = 120
//    let buttonWidth: CGFloat = UIScreen.main.bounds.width * 0.85
//    
//    var body: some View {
//        VStack(spacing: 15) {
//            // Header Section with Location and Days
//            VStack(alignment: .leading) {
//                // Location text and align it to the left
//                Text(location)
//                    .font(.largeTitle)
//                    .fontWeight(.bold)
//                    .multilineTextAlignment(.leading)
//                    .lineLimit(2)
//                    .padding(.top, 30)
//                
//                // Display the number of days below the location
//                Text("\(days) Days")
//                    .font(.title3)
//                    .foregroundColor(.gray)
//            }
//            .frame(maxWidth: .infinity, alignment: .leading) // Left align the whole VStack
//            .padding(.leading, 20) // Add padding for a better left alignment appearance
//            .padding(.bottom, 20)  // bottom padding for spacing
//            
//            // Day Buttons Section
//            ScrollView {
//                VStack(spacing: 25) {
//                    // loop through activities ny each day
//                    ForEach(planController.locationActivitiesByDay) { dayActivities in
//                        // screen navigates to DayActivityView when the day button is pressed
//                        NavigationLink(
//                            destination: DayActivityView(location: location, dayActivities: dayActivities)) {
//                            HStack {
//                                VStack(alignment: .leading) {
//                                    // display the day number on the button
//                                    Text("Day \(dayActivities.day)")
//                                        .font(.title2)
//                                        .fontWeight(.bold)
//                                    // displays extra 'view activites' text but can be changed
//                                    Text("View Activities")
//                                        .font(.subheadline)
//                                        .foregroundColor(.gray)
//                                }
//                                .padding(.leading, 15)
//                                
//                                Spacer()
//                                
//                                // right arrow on button
//                                Image(systemName: "chevron.right")
//                                    .foregroundColor(.blue)
//                                    .padding(.trailing, 15)
//                            }
//                            // button sizing and color details
//                            .frame(width: buttonWidth, height: buttonHeight)
//                            .background(Color(.systemGray6))
//                            .cornerRadius(10)
//                            .shadow(radius: 2)
//                            .padding(.horizontal)
//                            // add top padding for the first button only
//                            .padding(.top, dayActivities.day == 1 ? 10 : 0)
//                        }
//                    }
//                }
//            }
//            .padding(.bottom, 20)
//            Spacer()
//        }
//        
//        .onAppear {
//            // Only fetch the data once if not already generated
//            if !planController.hasGeneratedActivities {
//                planController.sendNewMessage(userUID: userUID, location: location, filter: "Relaxing", days: days)
//            }
//        }
//    }
//}
//

 //sruthi's code
//  ItineraryView.swift
//  TripPlanner3
//
//  Created by stlp on 9/14/24.
//

//import SwiftUI
//
//// For the itinerary page display right after user input
//struct ItineraryView: View {
//    var location: String  // name of the location
//    var days: Int  // number of days for the trip
//    var userUID: String  // Add userUID
//    @ObservedObject var planController: PlanController
//
//    // height and width of the buttons for each day
//    let buttonHeight: CGFloat = 120
//    let buttonWidth: CGFloat = UIScreen.main.bounds.width * 0.85
//    
//    var body: some View {
//        VStack(spacing: 15) {
//            // Header Section with Location and Days
//            VStack(alignment: .leading) {
//                // Location text and align it to the left
//                Text(location)
//                    .font(.largeTitle)
//                    .fontWeight(.bold)
//                    .multilineTextAlignment(.leading)
//                    .lineLimit(2)
//                    .padding(.top, 30)
//                
//                // Display the number of days below the location
//                Text("\(days) Days")
//                    .font(.title3)
//                    .foregroundColor(.gray)
//            }
//            .frame(maxWidth: .infinity, alignment: .leading) // Left align the whole VStack
//            .padding(.leading, 20) // Add padding for a better left alignment appearance
//            .padding(.bottom, 20)  // bottom padding for spacing
//            
//            // Day Buttons Section
//            ScrollView {
//                VStack(spacing: 25) {
//                    // loop through activities ny each day
//                    ForEach(planController.locationActivitiesByDay) { dayActivities in
//                        // screen navigates to DayActivityView when the day button is pressed
//                        NavigationLink(
//                            destination: DayActivityView(location: location, dayActivities: dayActivities)) {
//                            HStack {
//                                VStack(alignment: .leading) {
//                                    // display the day number on the button
//                                    Text("Day \(dayActivities.day)")
//                                        .font(.title2)
//                                        .fontWeight(.bold)
//                                    // displays extra 'view activites' text but can be changed
//                                    Text("View Activities")
//                                        .font(.subheadline)
//                                        .foregroundColor(.gray)
//                                }
//                                .padding(.leading, 15)
//                                
//                                Spacer()
//                                
//                                // right arrow on button
//                                Image(systemName: "chevron.right")
//                                    .foregroundColor(.blue)
//                                    .padding(.trailing, 15)
//                            }
//                            // button sizing and color details
//                            .frame(width: buttonWidth, height: buttonHeight)
//                            .background(Color(.systemGray6))
//                            .cornerRadius(10)
//                            .shadow(radius: 2)
//                            .padding(.horizontal)
//                            // add top padding for the first button only
//                            .padding(.top, dayActivities.day == 1 ? 10 : 0)
//                        }
//                    }
//                }
//            }
//            .padding(.bottom, 20)
//            Spacer()
//        }
//        
//        .onAppear {
//            // Only fetch the data once if not already generated
//            if !planController.hasGeneratedActivities {
//                planController.sendNewMessage(userUID: userUID, location: location, filter: "Relaxing", days: days)
//            }
//        }
//    }
//}
//

//import SwiftUI
//import Combine
//
//struct ItineraryView: View {
//    var location: String
//    var days: Int
//    var userUID: String
//    @ObservedObject var planController: PlanController
//    @State private var refreshToggle = false  // State to force view refresh
//
//    let buttonHeight: CGFloat = 120
//    let buttonWidth: CGFloat = UIScreen.main.bounds.width * 0.85
//
//    var body: some View {
//        VStack(spacing: 15) {
//            Text(location)
//                .font(.largeTitle)
//                .fontWeight(.bold)
//                .multilineTextAlignment(.leading)
//                .lineLimit(2)
//                .padding(.top, 30)
//
//            Text("\(days) Days")
//                .font(.title3)
//                .foregroundColor(.gray)
//
//            ScrollView {
//                VStack(spacing: 25) {
//                    if planController.isLoading {
//                        Text("Loading...")  // Show loading text
//                    } else if planController.locationActivitiesByDay.isEmpty {
//                        Text("No activities available.")
//                    } else {
//                        ForEach(planController.locationActivitiesByDay) { dayActivities in
//                            NavigationLink(destination: DayActivityView(location: location, dayActivities: dayActivities)) {
//                                DayButtonView(dayActivities: dayActivities, buttonWidth: buttonWidth, buttonHeight: buttonHeight)
//                            }
//                        }
//                    }
//                }
//            }
//            .padding(.bottom, 20)
//            Spacer()
//        }
//        .navigationBarItems(trailing: Button("Refresh") {
//            forceRefresh()
//        })
//        .onAppear {
//            resetAndLoadData()  // Call reset and load data
//        }
//        .onReceive(NotificationCenter.default.publisher(for: UIApplication.willEnterForegroundNotification)) { _ in
//            loadDataIfNeeded()
//        }
//    }
//
//    /// Function to reset data and load new results
//    private func resetAndLoadData() {
//        print("Resetting data and preparing for a new search.")
//        // Clear previous results
//        planController.locationActivitiesByDay = []
//        planController.isLoading = true  // Set loading state to true
//        planController.hasGeneratedActivities = false  // Ensure the new trip data will be generated
//
//        // Trigger data loading
//        loadDataIfNeeded()
//    }
//
//    private func loadDataIfNeeded() {
//        print("Data check on appear: \(planController.locationActivitiesByDay.count) activities loaded.")
//        if planController.locationActivitiesByDay.isEmpty && !planController.hasGeneratedActivities && planController.isLoading {
//            print("Data is empty and not loading - triggering data fetch.")
//            planController.sendNewMessage(userUID: userUID, location: location, filter: "Relaxing", days: days)
//        }
//    }
//
//    private func forceRefresh() {
//        resetAndLoadData()
//    }
//}


//import SwiftUI
//import Combine
//
//struct ItineraryView: View {
//    var location: String
//    var days: Int
//    var userUID: String
//    @ObservedObject var planController: PlanController
//    @State private var refreshToggle = false  // State to force view refresh
//
//    let buttonHeight: CGFloat = 120
//    let buttonWidth: CGFloat = UIScreen.main.bounds.width * 0.85
//
//    var body: some View {
//        VStack(spacing: 15) {
//            Text(location)
//                .font(.largeTitle)
//                .fontWeight(.bold)
//                .multilineTextAlignment(.leading)
//                .lineLimit(2)
//                .padding(.top, 30)
//
//            Text("\(days) Days")
//                .font(.title3)
//                .foregroundColor(.gray)
//
//            ScrollView {
//                VStack(spacing: 25) {
//                    if planController.isLoading {
//                        Text("Loading...")  // Show loading text
//                    } else if planController.locationActivitiesByDay.isEmpty {
//                        Text("No activities available.")
//                    } else {
//                        ForEach(planController.locationActivitiesByDay) { dayActivities in
//                            NavigationLink(destination: DayActivityView(location: location, dayActivities: dayActivities)) {
//                                DayButtonView(dayActivities: dayActivities, buttonWidth: buttonWidth, buttonHeight: buttonHeight)
//                            }
//                        }
//                    }
//                }
//            }
//            .padding(.bottom, 20)
//            Spacer()
//        }
//        .navigationBarItems(trailing: Button("Refresh") {
//            forceRefresh()
//        })
//        .onAppear {
//            // Only load data if we haven't generated activities already
//            if !planController.hasGeneratedActivities {
//                resetAndLoadData()  // Call reset and load data
//            }
//        }
//        .onReceive(NotificationCenter.default.publisher(for: UIApplication.willEnterForegroundNotification)) { _ in
//            loadDataIfNeeded()
//        }
//    }
//
//    /// Function to reset data and load new results
//    private func resetAndLoadData() {
//        print("Resetting data and preparing for a new search.")
//        // Clear previous results
//        planController.locationActivitiesByDay = []
//        planController.isLoading = true  // Set loading state to true
//        planController.hasGeneratedActivities = false  // Ensure the new trip data will be generated
//
//        // Trigger data loading
//        loadDataIfNeeded()
//    }
//
//    private func loadDataIfNeeded() {
//        print("Data check on appear: \(planController.locationActivitiesByDay.count) activities loaded.")
//        if planController.locationActivitiesByDay.isEmpty && !planController.hasGeneratedActivities && planController.isLoading {
//            print("Data is empty and not loading - triggering data fetch.")
//            planController.sendNewMessage(userUID: userUID, location: location, filter: "Relaxing", days: days)
//        }
//    }
//
//    private func forceRefresh() {
//        resetAndLoadData()
//    }
//}
//
//

//import SwiftUI
//import Combine
//
//struct ItineraryView: View {
//    var location: String
//    var days: Int
//    var userUID: String
//    @ObservedObject var planController: PlanController
//    @State private var refreshToggle = false  // State to force view refresh
//
//    let buttonHeight: CGFloat = 120
//    let buttonWidth: CGFloat = UIScreen.main.bounds.width * 0.85
//
//    var body: some View {
//        VStack(spacing: 15) {
//            Text(location)
//                .font(.largeTitle)
//                .fontWeight(.bold)
//                .multilineTextAlignment(.leading)
//                .lineLimit(2)
//                .padding(.top, 30)
//
//            Text("\(days) Days")
//                .font(.title3)
//                .foregroundColor(.gray)
//
//            ScrollView {
//                VStack(spacing: 25) {
//                    if planController.isLoading {
//                        Text("Loading...")  // Show loading text
//                    } else if planController.locationActivitiesByDay.isEmpty {
//                        Text("No activities available.")
//                    } else {
//                        ForEach(planController.locationActivitiesByDay) { dayActivities in
//                            NavigationLink(destination: DayActivityView(location: location, dayActivities: dayActivities)) {
//                                DayButtonView(dayActivities: dayActivities, buttonWidth: buttonWidth, buttonHeight: buttonHeight)
//                            }
//                        }
//                    }
//                }
//            }
//            .padding(.bottom, 20)
//            Spacer()
//        }
//        .navigationBarItems(trailing: Button("Refresh") {
//            resetAndLoadData()  // Trigger refresh
//        })
//        .onAppear {
//            if !planController.hasGeneratedActivities {
//                resetAndLoadData()  // Only load data if not generated
//            }
//        }
//        .onReceive(NotificationCenter.default.publisher(for: UIApplication.willEnterForegroundNotification)) { _ in
//            loadDataIfNeeded()
//        }
//    }
//
//    private func resetAndLoadData() {
//        // Reset data before fetching new results
//        planController.resetBeforeNewSearch()
//        loadDataIfNeeded()
//    }
//
//    private func loadDataIfNeeded() {
//        if planController.locationActivitiesByDay.isEmpty && !planController.hasGeneratedActivities && planController.isLoading {
//            // Trigger data fetch
//            planController.sendNewMessage(userUID: userUID, location: location, filter: "Relaxing", days: days)
//        }
//    }
//}
//


//best working version//

//import SwiftUI
//import Combine
//
//struct ItineraryView: View {
//    var location: String
//    var days: Int
//    var userUID: String
//    @ObservedObject var planController: PlanController
//    @State private var refreshToggle = false  // State to force view refresh
//
//    let buttonHeight: CGFloat = 120
//    let buttonWidth: CGFloat = UIScreen.main.bounds.width * 0.85
//
//    var body: some View {
//        VStack(spacing: 15) {
//            Text(location)
//                .font(.largeTitle)
//                .fontWeight(.bold)
//                .multilineTextAlignment(.leading)
//                .lineLimit(2)
//                .padding(.top, 30)
//
//            Text("\(days) Days")
//                .font(.title3)
//                .foregroundColor(.gray)
//
//            ScrollView {
//                VStack(spacing: 25) {
//                    if planController.isLoading {
//                        Text("Loading...")  // Show loading text
//                    } else if planController.locationActivitiesByDay.isEmpty {
//                        Text("No activities available.")
//                    } else {
//                        ForEach(planController.locationActivitiesByDay) { dayActivities in
//                            NavigationLink(destination: DayActivityView(location: location, dayActivities: dayActivities)) {
//                                DayButtonView(dayActivities: dayActivities, buttonWidth: buttonWidth, buttonHeight: buttonHeight)
//                            }
//                        }
//                    }
//                }
//            }
//            .padding(.bottom, 20)
//            Spacer()
//        }
//        .navigationBarItems(trailing: Button("Refresh") {
//            forceRefresh()
//        })
//        .onAppear {
//            // Only load data if activities haven't been generated yet
//            if planController.locationActivitiesByDay.isEmpty && !planController.hasGeneratedActivities {
//                loadDataIfNeeded()
//            }
//        }
//    }
//
//    private func loadDataIfNeeded() {
//        print("Data check on appear: \(planController.locationActivitiesByDay.count) activities loaded.")
//        if planController.locationActivitiesByDay.isEmpty && !planController.hasGeneratedActivities {
//            print("Data is empty and not loading - triggering data fetch.")
//            planController.sendNewMessage(userUID: userUID, location: location, filter: "Relaxing", days: days)
//        }
//    }
//
//    private func forceRefresh() {
//        // Clear previous results and refresh the data
//        planController.hasGeneratedActivities = false
//        loadDataIfNeeded()
//    }
//}
//

//import SwiftUI
//import Combine
//
//struct ItineraryView: View {
//    var location: String
//    var days: Int
//    var userUID: String
//    var selectedTripType: String
//    @ObservedObject var planController: PlanController
//    @State private var refreshToggle = false  // State to force view refresh
//
//    let buttonHeight: CGFloat = 120
//    let buttonWidth: CGFloat = UIScreen.main.bounds.width * 0.85
//
//    var body: some View {
//        VStack(spacing: 15) {
//            Text(location)
//                .font(.largeTitle)
//                .fontWeight(.bold)
//                .multilineTextAlignment(.leading)
//                .lineLimit(2)
//                .padding(.top, 30)
//
//            Text("\(days) Days")
//                .font(.title3)
//                .foregroundColor(.gray)
//
//            ScrollView {
//                VStack(spacing: 25) {
//                    if planController.isLoading {
//                        Text("Loading...")  // Show loading text
//                    } else if planController.locationActivitiesByDay.isEmpty {
//                        Text("No activities available.")
//                    } else {
//                        ForEach(planController.locationActivitiesByDay) { dayActivities in
//                            NavigationLink(destination: DayActivityView(location: location, dayActivities: dayActivities)) {
//                                DayButtonView(dayActivities: dayActivities, buttonWidth: buttonWidth, buttonHeight: buttonHeight)
//                            }
//                        }
//                    }
//                }
//            }
//            .padding(.bottom, 20)
//            Spacer()
//        }
//        .onAppear {
//            // Only load data if activities haven't been generated yet
//            if planController.locationActivitiesByDay.isEmpty && !planController.hasGeneratedActivities {
//                loadDataIfNeeded()
//            }
//        }
//    }
//
//    private func loadDataIfNeeded() {
//        print("Data check on appear: \(planController.locationActivitiesByDay.count) activities loaded.")
//        if planController.locationActivitiesByDay.isEmpty && !planController.hasGeneratedActivities {
//            print("Data is empty and not loading - triggering data fetch.")
//            planController.sendNewMessage(userUID: userUID, location: location, filter: selectedTripType, days: days)
//        }
//    }
//
//    private func forceRefresh() {
//        // Clear previous results and refresh the data
//        planController.hasGeneratedActivities = false
//        loadDataIfNeeded()
//    }
//}

//import SwiftUI
//import Combine
//
//struct ItineraryView: View {
//    var location: String
//    var days: Int
//    var userUID: String
//    var selectedTripType: String
//    @ObservedObject var planController: PlanController
//    @State private var refreshToggle = false  // State to force view refresh
//
//    let buttonHeight: CGFloat = 120
//    let buttonWidth: CGFloat = UIScreen.main.bounds.width * 0.85
//
//    var body: some View {
//        ScrollView {
//            ZStack {
//                VStack(spacing: 0) {
//                    // Top Image Section
//                    ZStack {
//                        // Background image
//                        Image("image0") // Your asset image
//                            .resizable()
//                            .scaledToFill()
//                            .frame(height: 300) // Adjust the height of the image
//                            .clipped()
//
//                        // Gradient overlay for better text readability
//                        LinearGradient(gradient: Gradient(colors: [Color.black.opacity(0.6), Color.black.opacity(0)]),
//                                       startPoint: .top,
//                                       endPoint: .bottom)
//                            .frame(height: 300)
//
//                        // Text overlay (location and days)
//                        VStack {
//                            Spacer()  // Push text down
//                            VStack(alignment: .leading) {
//                                Text(location)
//                                    .font(.largeTitle)
//                                    .fontWeight(.bold)
//                                    .foregroundColor(.white)
//                                    .padding(.bottom, 2)
//
//                                Text("\(days) Days")
//                                    .font(.title2)
//                                    .foregroundColor(.white)
//                            }
//                            .padding(.leading, 20)
//                            .frame(maxWidth: .infinity, alignment: .leading)
//                            Spacer()  // Center content vertically
//                        }
//                        .frame(height: 300)
//                    }
//
//                    // White content box below the image
//                    VStack(spacing: 25) {
//                        if planController.isLoading {
//                            Text("Loading...")  // Show loading text
//                        } else if planController.locationActivitiesByDay.isEmpty {
//                            Text("No activities available.")
//                        } else {
//                            ForEach(planController.locationActivitiesByDay) { dayActivities in
//                                NavigationLink(destination: DayActivityView(location: location, dayActivities: dayActivities)) {
//                                    DayButtonView(dayActivities: dayActivities, buttonWidth: buttonWidth, buttonHeight: buttonHeight)
//                                }
//                            }
//                        }
//                    }
//                    .padding()
//                    .background(Color.white)
//                    .cornerRadius(25)
//                    .shadow(radius: 5)
//                    .padding(.top, -30) // Overlap effect
//                }
//            }
//        }
//        .edgesIgnoringSafeArea(.top)
//        .onAppear {
//            // Only load data if activities haven't been generated yet
//            if planController.locationActivitiesByDay.isEmpty && !planController.hasGeneratedActivities {
//                loadDataIfNeeded()
//            }
//        }
//    }
//
//    private func loadDataIfNeeded() {
//        if planController.locationActivitiesByDay.isEmpty && !planController.hasGeneratedActivities {
//            planController.sendNewMessage(userUID: userUID, location: location, filter: selectedTripType, days: days)
//        }
//    }
//}
//
//
//
//


import SwiftUI
import Combine

struct ItineraryView: View {
    var location: String
    var days: Int
    var userUID: String
    var selectedTripType: String
    @ObservedObject var planController: PlanController
    @State private var refreshToggle = false  // State to force view refresh

    let buttonHeight: CGFloat = 120
    let buttonWidth: CGFloat = UIScreen.main.bounds.width * 0.85

    var body: some View {
        ScrollView {
            ZStack {
                VStack(spacing: 0) {
                    // Top Image Section
                    ZStack {
                        // Background image
                        Image(locationImageName(for: location))
                            .resizable()
                            .scaledToFill()
                            .frame(height: 300) // Adjust the height of the image
                            .clipped()

                        // Gradient overlay for better text readability
                        LinearGradient(gradient: Gradient(colors: [Color.black.opacity(0.6), Color.black.opacity(0)]),
                                       startPoint: .top,
                                       endPoint: .bottom)
                            .frame(height: 300)

                        // Text overlay (location and days)
                        VStack {
                            Spacer()  // Push text down
                            VStack(alignment: .leading) {
                                Text(location)
                                    .font(.largeTitle)
                                    .fontWeight(.bold)
                                    .foregroundColor(.white)
                                    .padding(.bottom, 2)

                                Text("\(days) Days")
                                    .font(.title2)
                                    .foregroundColor(.white)
                            }
                            .padding(.leading, 20)
                            .frame(maxWidth: .infinity, alignment: .leading)
                            Spacer()  // Center content vertically
                        }
                        .frame(height: 300)
                    }

                    // White content box below the image
                    VStack(spacing: 25) {
                        if planController.isLoading {
                            Text("Loading...")  // Show loading text
                        } else {
                            ForEach(planController.locationActivitiesByDay) { dayActivities in
                                // Extract city name and convert to lowercase without spaces or commas
                                let cityName = location.split(separator: ",")[0].lowercased().replacingOccurrences(of: " ", with: "")
                                let imageName = "\(cityName)day\(dayActivities.day)"
                                
                                // Screen navigates to DayActivityView when the day button is pressed
                                NavigationLink(destination: DayActivityView(location: location, dayActivities: dayActivities)) {
                                    VStack {
                                        // Load the image from assets
                                        Image(imageName)
                                            .resizable()
                                            .aspectRatio(contentMode: .fill)
                                            .frame(width: buttonWidth, height: buttonHeight)
                                            .clipped()
                                            .cornerRadius(10)
                                            .overlay(
                                                VStack(alignment: .leading, spacing: 10) {
                                                    // Display the day number on the button
                                                    Text("Day \(dayActivities.day)")
                                                        .font(.title2)
                                                        .fontWeight(.black)
                                                        .foregroundColor(.white)

                                                    // Displays extra 'view activities' text
                                                    Text("View Activities")
                                                        .font(.subheadline)
                                                        .fontWeight(.heavy)
                                                        .foregroundColor(.white)
                                                }
                                                .padding(.leading, 15) // Adjust padding for text
                                                .padding(.top, 20),
                                                alignment: .topLeading
                                            )
                                    }
                                    // Button styling details
                                    .frame(width: buttonWidth, height: buttonHeight)
                                    //.background(Color(.systemGray6))
                                  //  .background(Color(kCGColorWhite))
                                    .cornerRadius(10)
                                    .shadow(radius: 2)
                                    .padding(.horizontal)
                                    // Add top padding for the first button only
                                    .padding(.top, dayActivities.day == 1 ? 10 : 0)
                                }
                            }
                        }
                    }
                    .padding()
                    .background(Color.white)
                    .cornerRadius(25)
                    .shadow(radius: 5)
                    .padding(.top, -30) // Overlap effect
                }
            }
        }
        .edgesIgnoringSafeArea(.top)
        .onAppear {
            // Only load data if activities haven't been generated yet
            if planController.locationActivitiesByDay.isEmpty && !planController.hasGeneratedActivities {
                loadDataIfNeeded()
            }
        }
    }

    private func loadDataIfNeeded() {
        if planController.locationActivitiesByDay.isEmpty && !planController.hasGeneratedActivities {
            planController.sendNewMessage(userUID: userUID, location: location, filter: selectedTripType, days: days)
        }
    }
    
    func locationImageName(for location: String) -> String {
        switch location {
        case "Los Angeles, USA":
            return "losangelesBackground"
        case "Honolulu, USA":
            return "honoluluBackground"
        case "Paris, France":
            return "parisBackground"
        case "Santorini, Greece":
            return "santoriniBackground"
        case "Mumbai, India":
            return "mumbaiBackground"
        case "Shanghai, China":
            return "shanghaiBackground"
        case "Tokyo, Japan":
            return "tokyoBackground"
        case "New York City, USA":
            return "newyorkcityBackground"
        case "Cancun, Mexico":
            return "cancunBackground"
        case "London, England":
            return "londonBackground"
        default:
            return "default"
        }
    }
}

