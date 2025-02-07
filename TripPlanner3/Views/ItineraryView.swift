//Hinal's code
//import SwiftUI
//
//struct ItineraryView: View {
//    var location: String
//    var days: Int
//    var userUID: String
//    var selectedTripType: String
//    @ObservedObject var planController: PlanController
//    @State private var refreshToggle = false  // State to force view refresh
//    @State private var imageNames: [Int: String] = [:]
//
//    let buttonHeight: CGFloat = UIScreen.main.bounds.height * 0.12
//    let buttonWidth: CGFloat = UIScreen.main.bounds.width * 0.85
//
//    var body: some View {
//        // Embed in a NavigationView to get the back button
//        if planController.isLoading {
//            ZStack {
//                Image(randomBackgroundImageName()) // Replace with your image name
//                    .resizable()
//                    .scaledToFill()
//                    .edgesIgnoringSafeArea(.all)
//                
//                VStack(spacing: 5) {
//                    Text("Loading...")
//                        .foregroundColor(.white)
//                        .font(.system(size: 24, weight: .bold, design: .default)) // Larger font
//                        .shadow(radius: 3, x: 2, y: 2) // More prominent shadow
//
//                    ProgressView()
//                        .progressViewStyle(CircularProgressViewStyle(tint: .white))
//                        .scaleEffect(1.5)
//                        .frame(width: 80, height: 80)
//                        .shadow(color: Color.black.opacity(0.8), radius: 3, x: 2, y: 2)
//                }
//            }
//            .onAppear {
//                imageNames = [:]
//                generateImageNamesAndLoadImages()
//            }
//        } else {
//            ScrollView {
//                ZStack {
//                    VStack(spacing: 0) {
//                        // Top Image Section
//                        ZStack {
//                            // Background image
//                            Image(randomBackgroundImageName())
//                                .resizable()
//                                .scaledToFill()
//                                .frame(height: UIScreen.main.bounds.height * 0.40) // Adjust the height of the image
//                                .clipped()
//                            
//                            // Gradient overlay for better text readability
//                            LinearGradient(gradient: Gradient(colors: [Color.black.opacity(0.6), Color.black.opacity(0)]),
//                                           startPoint: .top,
//                                           endPoint: .bottom)
//                            .frame(height: UIScreen.main.bounds.height * 0.40)
//                            
//                            // Text overlay (location and days)
//                            VStack {
//                                Spacer()  // Push text down
//                                VStack(alignment: .leading) {
//                                    Text(location)
//                                        .font(.largeTitle)
//                                        .fontWeight(.bold)
//                                        .foregroundColor(.white)
//                                        .padding(.bottom, UIScreen.main.bounds.height * 0.005)
//                                        .padding(.leading, UIScreen.main.bounds.width * 0.005)
//                                        .multilineTextAlignment(.leading) // Ensures proper text alignment
//                                        .lineLimit(2) // Allows the text to wrap to a second line
//                                        .frame(maxWidth: UIScreen.main.bounds.width * 0.9, alignment: .leading)
//                                    
//                                    Text("\(days) Days")
//                                        .font(.title2)
//                                        .foregroundColor(.white)
//                                }
//                                .padding(.leading, UIScreen.main.bounds.width * 0.1)
//                                .frame(maxWidth: .infinity, alignment: .leading)
//                                Spacer()  // Center content vertically
//                            }
//                            .frame(height: UIScreen.main.bounds.height * 0.35)
//                        }
//                        
//                        // White content box below the image
//                        VStack(spacing: UIScreen.main.bounds.height * 0.03) {
//                            if planController.isLoading {
//                                //Text("Loading...")  // Show loading text
//                            } else {
//                                ForEach(planController.locationActivitiesByDay) { dayActivities in
//                                    // Extract city name and convert to lowercase without spaces or commas
//                                    let cityName = location.split(separator: ",")[0].lowercased().replacingOccurrences(of: " ", with: "")
//                                    let imageName = imageNames[dayActivities.day] ?? "defaultImage"
//                                    
//                                    // Correct the NavigationLink for day button navigation
//                                    NavigationLink(destination: DayActivityView(location: location, days: days, dayActivities: dayActivities)) {
//                                        VStack {
//                                            // Load the image from assets
//                                            Image(imageName)
//                                                .resizable()
//                                                .aspectRatio(contentMode: .fill)
//                                                .frame(width: buttonWidth, height: buttonHeight)
//                                                .clipped()
//                                                .cornerRadius(UIScreen.main.bounds.height * 0.015)
//                                                .overlay(
//                                                    VStack(alignment: .leading, spacing: UIScreen.main.bounds.height * 0.01) {
//                                                        // Display the day number on the button
//                                                        Text("Day \(dayActivities.day)")
//                                                            .font(.system(size: UIScreen.main.bounds.width * 0.06, weight: .black))
//                                                            .foregroundColor(.white)
//                                                        
//                                                        // Displays extra 'view activities' text
//                                                        Text("View Activities")
//                                                            .font(.system(size: UIScreen.main.bounds.width * 0.04, weight: .heavy))
//                                                            .foregroundColor(.white)
//                                                    }
//                                                        .padding(.leading, UIScreen.main.bounds.width * 0.04) // Adjust padding for text
//                                                        .padding(.top, UIScreen.main.bounds.height * 0.02),
//                                                    alignment: .topLeading
//                                                )
//                                        }
//                                        // Button styling details
//                                        .frame(width: buttonWidth, height: buttonHeight)
//                                        .cornerRadius(UIScreen.main.bounds.height * 0.015)
//                                        .shadow(radius: UIScreen.main.bounds.height * 0.005)
//                                        .padding(.horizontal, UIScreen.main.bounds.width * 0.05)
//                                        // Add top padding for the first button only
//                                        .padding(.top, dayActivities.day == 1 ? UIScreen.main.bounds.height * 0.03 : 0)
//                                    }
//                                }
//                            }
//                        }
//                        .padding(UIScreen.main.bounds.height * 0.02)
//                        .background(Color.white)
//                        .cornerRadius(UIScreen.main.bounds.height * 0.09)
//                        //.shadow(radius: UIScreen.main.bounds.height * 0.01)
//                        .padding(.top, -UIScreen.main.bounds.height * 0.06)  // stopped here
//                    }
//                    .background(GeometryReader { geo -> Color in
//                            let yOffset = -geo.frame(in: .global).origin.y
//                            DispatchQueue.main.async {
//                                NotificationCenter.default.post(name: NSNotification.Name("ScrollViewDidScroll"), object: nil, userInfo: ["yOffset": yOffset])
//                            }
//                            return Color.clear
//                        })
//                }
//            }
//            .edgesIgnoringSafeArea(.top)
//            .navigationBarTitleDisplayMode(.inline)
//            .onAppear {
//                    if let navigationController = UIApplication.shared.windows.first?.rootViewController as? UINavigationController {
//                        navigationController.setupNavBarColor()
//                    }
//
//                // Only load data if activities haven't been generated yet
//                if planController.locationActivitiesByDay.isEmpty && !planController.hasGeneratedActivities {
//                    loadDataIfNeeded()
//                }
//            }
//            
//        }
//
//    }
//
//    private func loadDataIfNeeded() {
//        if planController.locationActivitiesByDay.isEmpty && !planController.hasGeneratedActivities {
//            planController.sendNewMessage(userUID: userUID, location: location, filter: selectedTripType, days: days)
//        }
//    }
//    
//    func randomBackgroundImageName() -> String {
//        let imageCount = 8 // Update this based on the number of images available
//        let index = (days - 1) % imageCount + 1 // Ensures cycling through images
//        return "bgImage\(index)"
//    }
//
//    func randomButtonImageName(for day: Int) -> String {
//        // Day-specific button images should be named "dayXImage1", "dayXImage2", etc.
//        let imageCount = 3 // Update this to the number of images in each day folder
//        let randomIndex = Int.random(in: 1...imageCount)
//        return "day\(day)Image\(randomIndex)"
//    }
//
//    
//    private func generateImageNamesAndLoadImages() {
//        // Generate random image names for each day and store them in the dictionary
//        imageNames = [:]
//        for day in 1...days {
//            let randomImageName = randomButtonImageName(for: day)
//            imageNames[day] = randomImageName
//        }
//    }
//
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
////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////
///
///
///


import SwiftUI

struct ItineraryView: View {
    var location: String
    var days: Int
    var userUID: String
    var selectedTripType: String
    @ObservedObject var planController: PlanController
    @State private var refreshToggle = false  // State to force view refresh
    @State private var imageNames: [Int: String] = [:]
    
    @State private var planeOffset: CGFloat = -100
    @State private var dotCount = 0
    let maxDots = 3

    let buttonHeight: CGFloat = UIScreen.main.bounds.height * 0.12
    let buttonWidth: CGFloat = UIScreen.main.bounds.width * 0.85

    var body: some View {
        // Embed in a NavigationView to get the back button
        if planController.isLoading {
            ZStack {
                Image(randomBackgroundImageName()) // Replace with your image name
                    .resizable()
                    .scaledToFill()
                    .edgesIgnoringSafeArea(.all)
                
                VStack(spacing: 5) {
                    Text("Planning Trip\(String(repeating: ".", count: dotCount))")
                        .foregroundColor(.white)
                        .font(.system(size: 24, weight: .bold, design: .default)) // Larger font
                        .shadow(radius: 3, x: 2, y: 2) // More prominent shadow
                        .onAppear {
                            startLoadingAnimation()
                        }

                    /*ProgressView()
                        .progressViewStyle(CircularProgressViewStyle(tint: .white))
                        .scaleEffect(1.5)
                        .frame(width: 80, height: 80)
                        .shadow(color: Color.black.opacity(0.8), radius: 3, x: 2, y: 2)*/
                    
                    // Airplane animation
                    Image(systemName: "airplane")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 30, height: 30)
                        .foregroundColor(.white)
                        .offset(x: planeOffset, y: 10)
                        .onAppear {
                            withAnimation(Animation.easeInOut(duration: 2).repeatForever(autoreverses: false)) {
                                planeOffset = 100 // Move plane from left to right
                            }
                        }
                }
            }
            .onAppear {
                imageNames = [:]
                generateImageNamesAndLoadImages()
            }
        } else {
            ScrollView {
                ZStack {
                    VStack(spacing: 0) {
                        // Top Image Section
                        ZStack {
                            // Background image
                            Image(randomBackgroundImageName())
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
                                Spacer(minLength: UIScreen.main.bounds.height * 0.12)
                                VStack(alignment: .leading) {
                                    Text(location)
                                        .font(.largeTitle)
                                        .fontWeight(.bold)
                                        .foregroundColor(.white)
                                        .padding(.bottom, UIScreen.main.bounds.height * 0.005)
                                        .padding(.leading, UIScreen.main.bounds.width * 0.005)
                                        .multilineTextAlignment(.leading) // Ensures proper text alignment
                                        .lineLimit(2) // Allows the text to wrap to a second line
                                        .frame(maxWidth: UIScreen.main.bounds.width * 0.9, alignment: .leading)
                                    
                                    Text("\(days) Days")
                                        .font(.title2)
                                        .foregroundColor(.white)
                                }
                                .padding(.leading, UIScreen.main.bounds.width * 0.1)
                                .frame(maxWidth: .infinity, alignment: .leading)
                                Spacer()  // Center content vertically
                            }
                            .frame(height: UIScreen.main.bounds.height * 0.35)
                        }
                        
                        // White content box below the image
                        VStack(spacing: UIScreen.main.bounds.height * 0.03) {
                            if planController.isLoading {
                                //Text("Loading...")  // Show loading text
                            } else {
                                ForEach(planController.locationActivitiesByDay) { dayActivities in
                                    // Extract city name and convert to lowercase without spaces or commas
                                    let cityName = location.split(separator: ",")[0].lowercased().replacingOccurrences(of: " ", with: "")
                                    let imageName = imageNames[dayActivities.day] ?? "defaultImage"
                                    
                                    // Correct the NavigationLink for day button navigation
                                    NavigationLink(destination: DayActivityView(location: location, days: days, dayActivities: dayActivities)) {
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
                        .cornerRadius(UIScreen.main.bounds.height * 0.055)
                        //.shadow(radius: UIScreen.main.bounds.height * 0.01)
                        .padding(.top, -UIScreen.main.bounds.height * 0.03)  // stopped here
                    }
                    .background(GeometryReader { geo -> Color in
                           let yOffset = -geo.frame(in: .global).origin.y
                               DispatchQueue.main.async {
                                   NotificationCenter.default.post(name: NSNotification.Name("ScrollViewDidScroll"), object: nil, userInfo: ["yOffset": yOffset])
                               }
                               return Color.clear
                    })
                }
            }
            .edgesIgnoringSafeArea(.top)
            .navigationBarTitleDisplayMode(.inline)
            .onAppear {
            if let navigationController = UIApplication.shared.windows.first?.rootViewController as? UINavigationController {
                    navigationController.setupNavBarColor()
                }
                // Only load data if activities haven't been generated yet
                if planController.locationActivitiesByDay.isEmpty && !planController.hasGeneratedActivities {
                    loadDataIfNeeded()
                }
            }
            
        }

    }

    private func loadDataIfNeeded() {
        if planController.locationActivitiesByDay.isEmpty && !planController.hasGeneratedActivities {
            planController.sendNewMessage(userUID: userUID, location: location, filter: selectedTripType, days: days)
        }
    }
    
    func randomBackgroundImageName() -> String {
        let imageCount = 8 // Update this based on the number of images available
        let index = (days - 1) % imageCount + 1 // Ensures cycling through images
        return "bgImage\(index)"
    }

    func randomButtonImageName(for day: Int) -> String {
        // Day-specific button images should be named "dayXImage1", "dayXImage2", etc.
        let imageCount = 3 // Update this to the number of images in each day folder
        let randomIndex = Int.random(in: 1...imageCount)
        return "day\(day)Image\(randomIndex)"
    }

    
    private func generateImageNamesAndLoadImages() {
        // Generate random image names for each day and store them in the dictionary
        imageNames = [:]
        for day in 1...days {
            let randomImageName = randomButtonImageName(for: day)
            imageNames[day] = randomImageName
        }
    }
    
    private func startLoadingAnimation() {
       Timer.scheduledTimer(withTimeInterval: 0.5, repeats: true) { timer in
           dotCount = (dotCount + 1) % (maxDots + 1)
           
           // Stop animation when loading is done
           if !planController.isLoading {
               timer.invalidate()
           }
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

