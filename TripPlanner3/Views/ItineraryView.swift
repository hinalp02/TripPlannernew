import SwiftUI

struct ItineraryView: View {
    var location: String
    var days: Int
    var userUID: String
    var selectedTripType: String
    @ObservedObject var planController: PlanController
    @State private var refreshToggle = false  // State to force view refresh

    let buttonHeight: CGFloat = UIScreen.main.bounds.height * 0.12
    let buttonWidth: CGFloat = UIScreen.main.bounds.width * 0.85

    var body: some View {
        // Embed in a NavigationView to get the back button
            ScrollView {
                ZStack {
                    VStack(spacing: 0) {
                        // Top Image Section
                        ZStack {
                            // Background image
                            Image(locationImageName(for: location))
                                .resizable()
                                .scaledToFill()
                                .frame(height: UIScreen.main.bounds.height * 0.35) // Adjust the height of the image
                                .clipped()

                            // Gradient overlay for better text readability
                            LinearGradient(gradient: Gradient(colors: [Color.black.opacity(0.6), Color.black.opacity(0)]),
                                           startPoint: .top,
                                           endPoint: .bottom)
                                .frame(height: UIScreen.main.bounds.height * 0.35)

                            // Text overlay (location and days)
                            VStack {
                                Spacer()  // Push text down
                                VStack(alignment: .leading) {
                                    Text(location)
                                        .font(.largeTitle)
                                        .fontWeight(.bold)
                                        .foregroundColor(.white)
                                        .padding(.bottom, UIScreen.main.bounds.height * 0.005)

                                    Text("\(days) Days")
                                        .font(.title2)
                                        .foregroundColor(.white)
                                }
                                .padding(.leading, UIScreen.main.bounds.width * 0.05)
                                .frame(maxWidth: .infinity, alignment: .leading)
                                Spacer()  // Center content vertically
                            }
                            .frame(height: UIScreen.main.bounds.height * 0.35)
                        }

                        // White content box below the image
                        VStack(spacing: UIScreen.main.bounds.height * 0.03) {
                            if planController.isLoading {
                                Text("Loading...")  // Show loading text
                            } else {
                                ForEach(planController.locationActivitiesByDay) { dayActivities in
                                    // Extract city name and convert to lowercase without spaces or commas
                                    let cityName = location.split(separator: ",")[0].lowercased().replacingOccurrences(of: " ", with: "")
                                    let imageName = "\(cityName)day\(dayActivities.day)"

                                    // Correct the NavigationLink for day button navigation
                                    NavigationLink(destination: DayActivityView(location: location, dayActivities: dayActivities)) {
                                        VStack {
                                            // Load the image from assets
                                            Image(imageName)
                                                .resizable()
                                                .aspectRatio(contentMode: .fill)
                                                .frame(width: buttonWidth, height: buttonHeight)
                                                .clipped()
                                                .cornerRadius(UIScreen.main.bounds.height * 0.015)
                                                .overlay(
                                                    VStack(alignment: .leading, spacing: UIScreen.main.bounds.height * 0.01) {
                                                        // Display the day number on the button
                                                        Text("Day \(dayActivities.day)")
                                                            .font(.system(size: UIScreen.main.bounds.width * 0.06, weight: .black))
                                                            .foregroundColor(.white)

                                                        // Displays extra 'view activities' text
                                                        Text("View Activities")
                                                            .font(.system(size: UIScreen.main.bounds.width * 0.04, weight: .heavy))
                                                            .foregroundColor(.white)
                                                    }
                                                    .padding(.leading, UIScreen.main.bounds.width * 0.04) // Adjust padding for text
                                                    .padding(.top, UIScreen.main.bounds.height * 0.02),
                                                    alignment: .topLeading
                                                )
                                        }
                                        // Button styling details
                                        .frame(width: buttonWidth, height: buttonHeight)
                                        .cornerRadius(UIScreen.main.bounds.height * 0.015)
                                        .shadow(radius: UIScreen.main.bounds.height * 0.005)
                                        .padding(.horizontal, UIScreen.main.bounds.width * 0.05)
                                        // Add top padding for the first button only
                                        .padding(.top, dayActivities.day == 1 ? UIScreen.main.bounds.height * 0.01 : 0)
                                    }
                                }
                            }
                        }
                        .padding(UIScreen.main.bounds.height * 0.02)
                        .background(Color.white)
                        .cornerRadius(UIScreen.main.bounds.height * 0.03)
                        //.shadow(radius: UIScreen.main.bounds.height * 0.01)
                        .padding(.top, -UIScreen.main.bounds.height * 0.04)  // stopped here
                    }
                }
            }
            .edgesIgnoringSafeArea(.top)
            .navigationBarTitleDisplayMode(.inline)
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



