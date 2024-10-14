//
//  DayActivityView.swift
//  TripPlanner
//
//  Created by Sruthi Padisetty on 9/12/24.
//

//import SwiftUI
//
//// displayed when user clicks on a day from itinerary view
//struct DayActivityView: View {
//    var location: String  // name of location (city, country)
//    var dayActivities: DayActivities  // activities for the specific day
//
//    var body: some View {
//        ScrollView {
//            VStack(spacing: 15) {
//                // Header Section with Location and Day
//                VStack(alignment: .leading) {
//                    // Display the city, country
//                    Text(location)
//                        .font(.largeTitle)
//                        .fontWeight(.bold)
//                        .multilineTextAlignment(.leading)
//                        .lineLimit(2)
//                        .padding(.top, 30)
//
//                    // display the day number below the location
//                    Text("Day \(dayActivities.day)")
//                        .font(.title3)
//                        .foregroundColor(.gray)
//                }
//                .frame(maxWidth: .infinity, alignment: .leading) // Left align the whole VStack
//                .padding(.leading, 20) // Add padding for a better left alignment appearance
//                .padding(.bottom, 20)
//                
//                // Display the day number centered above the summary
//                Text("Day \(dayActivities.day)")
//                    .font(.title)
//                    .fontWeight(.bold)
//                    .foregroundColor(.teal)  // teal
//                    .padding(.bottom, 10)
//
//                // Display the day's summary at the top
//                Text(dayActivities.summary)
//                    .font(.headline)
//                    .padding(.horizontal, 20)
//
//                // iterate through the locations the user will visit in a day
//                // has index for numbering
//                ForEach(Array(dayActivities.locations.enumerated()), id: \.element.id) { index, locationActivity in
//                    VStack(alignment: .leading) {
//                        // Display the location name with numbering and in a teal color
//                        Text("\(index + 1)) \(locationActivity.location)")
//                            .font(.title2)
//                            .foregroundColor(.teal) // teal
//                            .bold()
//                            .padding(.bottom, 5)
//                        
//                            .lineLimit(1) // Try to keep it on one line
//                            .minimumScaleFactor(0.8) // Adjust the text scale if needed to fit in one line
//
//                        // Display the address of the location
//                        Text(locationActivity.address)
//                            .font(.subheadline)
//                            .foregroundColor(.gray)
//                            .padding(.bottom, 10)
//
//                        // Check if an image URL exists and display it
//                        if let imageUrl = locationActivity.imageUrl, let url = URL(string: imageUrl) {
//                            AsyncImage(url: url) { phase in
//                                switch phase {
//                                case .empty:
//                                    ProgressView()
//                                case .success(let image):
//                                    image
//                                        .resizable()
//                                        .scaledToFit()
//                                        .frame(maxWidth: .infinity)  // lets image take the maximum available width
//                                case .failure:
//                                    Image(systemName: "photo")
//                                @unknown default:
//                                    Image(systemName: "photo")
//                                }
//                            }
//                            .padding(.bottom, 20)
//                        }
//
//                        // displays the detailed description for the location under the image
//                        Text(locationActivity.description)
//                            .padding(.vertical, 10)
//                    }
//                    .padding(.horizontal, 20) // aligns content with header text
//                    .padding(.bottom, 20)
//                }
//                Spacer()
//            }
//        }
//    }
//}
//

//import SwiftUI
//
//// displayed when user clicks on a day from itinerary view
//struct DayActivityView: View {
//    var location: String  // name of location (city, country)
//    var dayActivities: DayActivities  // activities for the specific day
//
//    var body: some View {
//        ScrollView {
//            ZStack {
//                VStack(spacing: 0) {
//                    // Top Image Section
//                    ZStack {
//                        // Background image (can be changed to a fixed image for now)
//                        Image("image0") // Replace with your own image asset
//                            .resizable()
//                            .scaledToFill()
//                            .frame(height: 300) // Adjust the height of the image
//                            .clipped()
//                        
//                        // Gradient overlay for better text readability (optional)
//                        LinearGradient(gradient: Gradient(colors: [Color.black.opacity(0.6), Color.black.opacity(0)]),
//                                       startPoint: .top,
//                                       endPoint: .bottom)
//                        .frame(height: 300)
//                        
//                        // Text overlay (location and day)
//                        VStack {
//                            Spacer()  // This spacer pushes the text down
//                            VStack(alignment: .leading) {  // Align text to the left
//                                Text(location)
//                                    .font(.largeTitle)
//                                    .fontWeight(.bold)
//                                    .foregroundColor(.white)
//                                    .padding(.bottom, 2)
//                                
//                                Text("Day \(dayActivities.day)")
//                                    .font(.title2)
//                                    .fontWeight(.bold)
//                                    .foregroundColor(.white)
//                                    .padding(.bottom, 20)
//                            }
//                            .padding(.leading, 20)  // Add left padding for better spacing
//                            .frame(maxWidth: .infinity, alignment: .leading)  // Align to the left side within the image
//                            Spacer()  // This spacer centers the content vertically
//                        }
//                        .frame(height: 300)
//                    }
//
//                    // White content box below the image
//                    VStack(alignment: .leading, spacing: 15) {
//                        Text("Day \(dayActivities.day)")
//                            .font(.largeTitle)
//                            .fontWeight(.bold)
//                            .foregroundColor(Color(red: 0.25, green: 0.65, blue: 0.95)) // Light blue color
//                            .frame(maxWidth: .infinity, alignment: .center) // Center the text
//
//                        // Display the day's summary at the top
//                        Text(dayActivities.summary)
//                            .font(.headline)
//                            .padding(.horizontal, 5)
//
//                        // Display all locations and their activities for the day
//                        ForEach(Array(dayActivities.locations.enumerated()), id: \.element.id) { index, locationActivity in
//                            VStack(alignment: .leading) {
//                                // Location name and numbering
//                                Text("\(index + 1)) \(locationActivity.location)")
//                                    .font(.title2)
//                                    .foregroundColor(.teal) // teal
//                                    .bold()
//
//                                // Address of the location
//                                Text(locationActivity.address)
//                                    .font(.subheadline)
//                                    .foregroundColor(.gray)
//
//                                // Optional image from the URL
//                                if let imageUrl = locationActivity.imageUrl, let url = URL(string: imageUrl) {
//                                    AsyncImage(url: url) { phase in
//                                        switch phase {
//                                        case .empty:
//                                            ProgressView()
//                                        case .success(let image):
//                                            image
//                                                .resizable()
//                                                .scaledToFill()
//                                                .frame(maxWidth: .infinity, maxHeight: 200)
//                                                .clipped()
//                                                .cornerRadius(10)
//                                        case .failure:
//                                            Image(systemName: "image0")
//                                        @unknown default:
//                                            Image(systemName: "image0")
//                                        }
//                                    }
//                                    .padding(.bottom, 10)
//                                }
//
//                                // Description of the activity
//                                Text(locationActivity.description)
//                                    .font(.body)
//                                    .padding(.vertical, 5)
//                            }
//                            .padding(.horizontal, 5) // Inner padding for each location
//                        }
//                    }
//                    .padding()
//                    .background(Color.white)
//                    .cornerRadius(25)
//                    .shadow(radius: 5)
//                    .padding(.top, -40) // This creates the overlap with the image
//                }
//            }
//        }
//        .edgesIgnoringSafeArea(.top)
//    }
//}


import SwiftUI

// displayed when user clicks on a day from itinerary view
struct DayActivityView: View {
    var location: String  // name of location (city, country)
    var dayActivities: DayActivities  // activities for the specific day

    var body: some View {
        ScrollView {
            ZStack {
                VStack(spacing: 0) {
                    // Top Image Section
                    ZStack {
                        // Background image depending on the location
                        Image(locationImageName(for: location))
                            .resizable()
                            .scaledToFill()
                            .frame(height: 300) // Adjust the height of the image
                            .clipped()
                        
                        // Gradient overlay for better text readability (optional)
                        LinearGradient(gradient: Gradient(colors: [Color.black.opacity(0.6), Color.black.opacity(0)]),
                                       startPoint: .top,
                                       endPoint: .bottom)
                        .frame(height: 300)
                        
                        // Text overlay (location and day)
                        VStack {
                            Spacer()  // This spacer pushes the text down
                            VStack(alignment: .leading) {  // Align text to the left
                                Text(location)
                                    .font(.largeTitle)
                                    .fontWeight(.bold)
                                    .foregroundColor(.white)
                                    .padding(.bottom, 2)
                                
                                Text("Day \(dayActivities.day)")
                                    .font(.title2)
                                    .fontWeight(.bold)
                                    .foregroundColor(.white)
                                    .padding(.bottom, 20)
                            }
                            .padding(.leading, 20)  // Add left padding for better spacing
                            .frame(maxWidth: .infinity, alignment: .leading)  // Align to the left side within the image
                            Spacer()  // This spacer centers the content vertically
                        }
                        .frame(height: 300)
                    }

                    // White content box below the image
                    VStack(alignment: .leading, spacing: 15) {
                        Text("Day \(dayActivities.day)")
                            .font(.largeTitle)
                            .fontWeight(.bold)
                            .foregroundColor(Color(red: 0.25, green: 0.65, blue: 0.95)) // Light blue color
                            .frame(maxWidth: .infinity, alignment: .center) // Center the text

                        // Display the day's summary at the top
                        Text(dayActivities.summary)
                            .font(.headline)
                            .padding(.horizontal, 5)

                        // Display all locations and their activities for the day
                        ForEach(Array(dayActivities.locations.enumerated()), id: \.element.id) { index, locationActivity in
                            VStack(alignment: .leading) {
                                // Location name and numbering
                                Text("\(index + 1)) \(locationActivity.location)")
                                    .font(.title2)
                                    .foregroundColor(.teal) // teal
                                    .bold()

                                // Address of the location
                                Text(locationActivity.address)
                                    .font(.subheadline)
                                    .foregroundColor(.gray)

                                // Optional image from the URL
                                if let imageUrl = locationActivity.imageUrl, let url = URL(string: imageUrl) {
                                    AsyncImage(url: url) { phase in
                                        switch phase {
                                        case .empty:
                                            ProgressView()
                                        case .success(let image):
                                            image
                                                .resizable()
                                                .scaledToFill()
                                                .frame(maxWidth: .infinity, maxHeight: 200)
                                                .clipped()
                                                .cornerRadius(10)
                                        case .failure:
                                            Image(systemName: "default")
                                        @unknown default:
                                            Image(systemName: "default")
                                        }
                                    }
                                    .padding(.bottom, 10)
                                }

                                // Description of the activity
                                Text(locationActivity.description)
                                    .font(.body)
                                    .padding(.vertical, 5)
                            }
                            .padding(.horizontal, 5) // Inner padding for each location
                        }
                    }
                    .padding()
                    .background(Color.white)
                    .cornerRadius(25)
                    .shadow(radius: 5)
                    .padding(.top, -40) // This creates the overlap with the image
                }
            }
        }
        .edgesIgnoringSafeArea(.top)
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
