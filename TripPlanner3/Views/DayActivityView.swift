//import SwiftUI
//
//struct DayActivityView: View {
//    var location: String  // Name of the location (e.g., city, country)
//    var dayActivities: DayActivities  // Activities for the specific day
//
//    var body: some View {
//        ScrollView {
//            ZStack {
//                VStack(spacing: 0) {
//                    // Top Image Section
//                    ZStack {
//                        // Background image based on the location
//                        Image(locationImageName(for: location))
//                            .resizable()
//                            .scaledToFill()
//                            .frame(height: UIScreen.main.bounds.height * 0.4)
//                            .clipped()
//
//                        // Gradient overlay
//                        LinearGradient(gradient: Gradient(colors: [Color.black.opacity(0.6), Color.black.opacity(0)]),
//                                       startPoint: .top,
//                                       endPoint: .bottom)
//                            .frame(height: UIScreen.main.bounds.height * 0.4)
//
//                        // Location and day text overlay
//                        VStack {
//                            Spacer()
//                            VStack(alignment: .leading) {
//                                Text(location)
//                                    .font(.system(size: UIScreen.main.bounds.width * 0.08, weight: .bold)) // Responsive font
//                                    .foregroundColor(.white)
//                                    .padding(.bottom, UIScreen.main.bounds.height * 0.01)
//                                
//                                Text("Day \(dayActivities.day)")
//                                    .font(.system(size: UIScreen.main.bounds.width * 0.06, weight: .bold)) // Responsive font
//                                    .foregroundColor(.white)
//                                    .padding(.bottom, UIScreen.main.bounds.height * 0.02)
//                            }
//                            .padding(.leading, UIScreen.main.bounds.width * 0.05) // Dynamic padding
//                            .frame(maxWidth: .infinity, alignment: .leading)
//                            Spacer()
//                        }
//                        .frame(height: UIScreen.main.bounds.height * 0.4)
//                    }
//
//                    // White content box below the image
//                    VStack(alignment: .leading, spacing: UIScreen.main.bounds.height * 0.02) {
//                        Text("Day \(dayActivities.day)")
//                            .font(.system(size: UIScreen.main.bounds.width * 0.07, weight: .bold))
//                            .foregroundColor(Color(red: 0.25, green: 0.65, blue: 0.95))
//                            .frame(maxWidth: .infinity, alignment: .center)
//
//                        // Display the day's summary
//                        Text(dayActivities.summary)
//                            .font(.system(size: UIScreen.main.bounds.width * 0.05)) // Responsive font
//                            .padding(.horizontal, UIScreen.main.bounds.width * 0.02)
//
//                        // Display all locations and their activities for the day
//                        ForEach(dayActivities.locations) { locationActivity in
//                            VStack(alignment: .leading) {
//                                Text(locationActivity.location)
//                                    .font(.system(size: UIScreen.main.bounds.width * 0.06, weight: .bold))
//                                    .foregroundColor(.teal)
//
//                                Text(locationActivity.address)
//                                    .font(.system(size: UIScreen.main.bounds.width * 0.045))
//                                    .foregroundColor(.gray)
//
//                                // Generate a random fallback image name for each activity
//                                let cityName = location.split(separator: ",")[0].lowercased().replacingOccurrences(of: " ", with: "")
//                                let randomImageNumber = Int.random(in: 1...8)
//                                let fallbackImageName = "\(cityName)day\(randomImageNumber)"
//
//                                // Load image from assets if fallback name is generated
//                                if let imageUrl = locationActivity.imageUrl, !imageUrl.isEmpty {
//                                    // Load image from URL if available
//                                    AsyncImage(url: URL(string: imageUrl)) { phase in
//                                        switch phase {
//                                        case .empty:
//                                            ProgressView()
//                                        case .success(let image):
//                                            image
//                                                .resizable()
//                                                .scaledToFill()
//                                                .frame(width: UIScreen.main.bounds.width * 0.9, height: UIScreen.main.bounds.height * 0.25)
//                                                .clipped()
//                                                .cornerRadius(UIScreen.main.bounds.width * 0.03)
//                                        case .failure:
//                                            Image(fallbackImageName) // Fallback asset image
//                                                .resizable()
//                                                .scaledToFill()
//                                                .frame(width: UIScreen.main.bounds.width * 0.9, height: UIScreen.main.bounds.height * 0.25)
//                                                .clipped()
//                                                .cornerRadius(UIScreen.main.bounds.width * 0.03)
//                                        @unknown default:
//                                            Image(fallbackImageName)
//                                                .resizable()
//                                                .scaledToFill()
//                                                .frame(width: UIScreen.main.bounds.width * 0.9, height: UIScreen.main.bounds.height * 0.25)
//                                                .clipped()
//                                                .cornerRadius(UIScreen.main.bounds.width * 0.03)
//                                        }
//                                    }
//                                    .padding(.bottom, UIScreen.main.bounds.height * 0.02)
//                                } else {
//                                    // Use a unique fallback image for each activity if no URL is provided
//                                    Image(fallbackImageName)
//                                        .resizable()
//                                        .scaledToFill()
//                                        .frame(width: UIScreen.main.bounds.width * 0.9, height: UIScreen.main.bounds.height * 0.25)
//                                        .clipped()
//                                        .cornerRadius(UIScreen.main.bounds.width * 0.03)
//                                }
//
//                                // Description of the activity
//                                Text(locationActivity.description)
//                                    .font(.body)
//                                    .padding(.vertical, UIScreen.main.bounds.height * 0.005)
//                            }
//                            .padding(.horizontal, UIScreen.main.bounds.width * 0.013)
//                        }
//                    }
//                    .padding(UIScreen.main.bounds.height * 0.02) // Outer padding
//                    .background(Color.white)
//                    .cornerRadius(UIScreen.main.bounds.width * 0.06)
//                    .padding(.top, -UIScreen.main.bounds.height * 0.09)
//                }
//            }
//        }
//        .edgesIgnoringSafeArea(.top)
//    }
//
//    // Function to map location names to background image assets
//    func locationImageName(for location: String) -> String {
//        switch location {
//        case "Los Angeles, USA":
//            return "losangelesBackground"
//        case "Honolulu, USA":
//            return "honoluluBackground"
//        case "Paris, France":
//            return "parisBackground"
//        case "Santorini, Greece":
//            return "santoriniBackground"
//        case "Mumbai, India":
//            return "mumbaiBackground"
//        case "Shanghai, China":
//            return "shanghaiBackground"
//        case "Tokyo, Japan":
//            return "tokyoBackground"
//        case "New York City, USA":
//            return "newyorkcityBackground"
//        case "Cancun, Mexico":
//            return "cancunBackground"
//        case "London, England":
//            return "londonBackground"
//        default:
//            return "default"
//        }
//    }
//}
//
//
//
//
//
//
import SwiftUI

struct DayActivityView: View {
    var location: String  // Name of the location (e.g., city, country)
    var days: Int
    var dayActivities: DayActivities  // Activities for the specific day

    var body: some View {
        ScrollView {
            ZStack {
                VStack(spacing: 0) {
                    // Top Image Section
                    ZStack {
                        // Background image based on the location
                        Image(randomBackgroundImageName())
                            .resizable()
                            .scaledToFill()
                            .frame(height: UIScreen.main.bounds.height * 0.4)
                            .clipped()

                        // Gradient overlay
                        LinearGradient(gradient: Gradient(colors: [Color.black.opacity(0.6), Color.black.opacity(0)]),
                                       startPoint: .top,
                                       endPoint: .bottom)
                            .frame(height: UIScreen.main.bounds.height * 0.4)

                        // Location and day text overlay
                        VStack {
                            Spacer()
                            VStack(alignment: .leading) {
                                Text(location)
                                    .font(.system(size: UIScreen.main.bounds.width * 0.08, weight: .bold)) // Responsive font
                                    .foregroundColor(.white)
                                    .padding(.bottom, UIScreen.main.bounds.height * 0.01)
                                
                                Text("Day \(dayActivities.day)")
                                    .font(.system(size: UIScreen.main.bounds.width * 0.06, weight: .bold)) // Responsive font
                                    .foregroundColor(.white)
                                    .padding(.bottom, UIScreen.main.bounds.height * 0.02)
                            }
                            .padding(.leading, UIScreen.main.bounds.width * 0.05) // Dynamic padding
                            .frame(maxWidth: .infinity, alignment: .leading)
                            Spacer()
                        }
                        .frame(height: UIScreen.main.bounds.height * 0.4)
                    }

                    // White content box below the image
                   
                    VStack(alignment: .leading, spacing: UIScreen.main.bounds.height * 0.02) {
                        Text("Day \(dayActivities.day)")
                            .font(.system(size: UIScreen.main.bounds.width * 0.07, weight: .bold))
                            .foregroundColor(Color(red: 0.25, green: 0.65, blue: 0.95))
                            .frame(maxWidth: .infinity, alignment: .center)

                        // Display the day's summary
                        Text(dayActivities.summary)
                            .font(.system(size: UIScreen.main.bounds.width * 0.05)) // Responsive font
                            .padding(.horizontal, UIScreen.main.bounds.width * 0.02)

                        // Display all locations and their activities for the day
                        ForEach(dayActivities.locations) { locationActivity in
                            VStack(alignment: .leading) {
                                Text(locationActivity.location)
                                    .font(.system(size: UIScreen.main.bounds.width * 0.06, weight: .bold))
                                    .foregroundColor(.teal)

                                Text(locationActivity.address)
                                    .font(.system(size: UIScreen.main.bounds.width * 0.045))
                                    .foregroundColor(.gray)

                                // Generate a random fallback image name for each activity
                                let cityName = location.split(separator: ",")[0].lowercased().replacingOccurrences(of: " ", with: "")
                                let randomImageNumber = Int.random(in: 1...8)
                                let fallbackImageName = "\(cityName)day\(randomImageNumber)"

                                // Load image from assets if fallback name is generated
                                if let imageUrl = locationActivity.imageUrl, !imageUrl.isEmpty {
                                    // Load image from URL if available
                                    AsyncImage(url: URL(string: imageUrl)) { phase in
                                        switch phase {
                                        case .empty:
                                            ProgressView()
                                        case .success(let image):
                                            image
                                                .resizable()
                                                .scaledToFill()
                                                .frame(width: UIScreen.main.bounds.width * 0.9, height: UIScreen.main.bounds.height * 0.25)
                                                .clipped()
                                                .cornerRadius(UIScreen.main.bounds.width * 0.03)
                                        case .failure:
                                            Image(fallbackImageName) // Fallback asset image
                                                .resizable()
                                                .scaledToFill()
                                                .frame(width: UIScreen.main.bounds.width * 0.9, height: UIScreen.main.bounds.height * 0.25)
                                                .clipped()
                                                .cornerRadius(UIScreen.main.bounds.width * 0.03)
                                        @unknown default:
                                            Image(fallbackImageName)
                                                .resizable()
                                                .scaledToFill()
                                                .frame(width: UIScreen.main.bounds.width * 0.9, height: UIScreen.main.bounds.height * 0.25)
                                                .clipped()
                                                .cornerRadius(UIScreen.main.bounds.width * 0.03)
                                        }
                                    }
                                    .padding(.bottom, UIScreen.main.bounds.height * 0.02)
                                } else {
                                    // Use a unique fallback image for each activity if no URL is provided
                                    Image(fallbackImageName)
                                        .resizable()
                                        .scaledToFill()
                                        .frame(width: UIScreen.main.bounds.width * 0.9, height: UIScreen.main.bounds.height * 0.25)
                                        .clipped()
                                        .cornerRadius(UIScreen.main.bounds.width * 0.03)
                                }

                                // Description of the activity
                                Text(locationActivity.description)
                                    .font(.body)
                                    .padding(.vertical, UIScreen.main.bounds.height * 0.005)
                            }
                            .padding(.horizontal, UIScreen.main.bounds.width * 0.013)
                        }
                    }
                    .padding(UIScreen.main.bounds.height * 0.02) // Outer padding
                    .background(Color.white)
                    .cornerRadius(UIScreen.main.bounds.width * 0.17)
                    .padding(.top, -UIScreen.main.bounds.height * 0.09)
                }
            }
        }
        .edgesIgnoringSafeArea(.top)
    }

    func randomBackgroundImageName() -> String {
        let imageCount = 8 // Update this based on the number of images available
        let index = (days - 1) % imageCount + 1 // Ensures cycling through images
        return "bgImage\(index)"
    }
}
