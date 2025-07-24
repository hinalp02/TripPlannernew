import SwiftUI
import PDFKit
import UIKit


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
    
    let gradientStartColor = Color(UIColor(red: 141/255, green: 172/255, blue: 225/255, alpha: 1))
    let gradientEndColor = Color(UIColor(red: 41/255, green: 102/255, blue: 117/255, alpha: 1))

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
                            if imageNames.isEmpty { // Prevents unnecessary resets
                                   imageNames = [:]
                                   generateImageNamesAndLoadImages()
                               }
                               if planeOffset == -100 { // Ensures animation starts only once
                                   withAnimation(Animation.easeInOut(duration: 2).repeatForever(autoreverses: false)) {
                                       planeOffset = 100
                                   }
                               }
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
                            
//                            withAnimation(Animation.easeInOut(duration: 2).repeatForever(autoreverses: false)) {
//                                planeOffset = 100 // Move plane from left to right
//                            }
                            if planeOffset == 0 { // Prevents restarting animation
                                        withAnimation(Animation.easeInOut(duration: 2).repeatForever(autoreverses: false)) {
                                            planeOffset = UIScreen.main.bounds.width / 2
                                        }
                                    }
                        }
                }
            }
            .onAppear {
                if imageNames.isEmpty { // Prevents unnecessary resets
                       imageNames = [:]
                       generateImageNamesAndLoadImages()
                   }
                if planeOffset == 0 { // Prevents restarting animation
                        withAnimation(Animation.easeInOut(duration: 2).repeatForever(autoreverses: false)) {
                            planeOffset = UIScreen.main.bounds.width / 2
                        }
                    }
            }
            .onDisappear {
                if planController.isLoading {
                    planeOffset = 0 // Reset position when leaving
                }
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
                            Button(action: {
                                print("Share button pressed") // Debugging
                                shareItinerary()
                            }) {
                                HStack {
                                    Image(systemName: "square.and.arrow.up") // Share icon
                                        .font(.title2)
                                    Text("Share Itinerary")
                                        .font(.headline)
                                }
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
                            .buttonStyle(PlainButtonStyle()) // Prevents unwanted navigation behavior
                            .simultaneousGesture(TapGesture().onEnded {}) // Prevents SwiftUI from thinking it's a navigation button
                            .padding(.horizontal, 20)


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
            .onDisappear {
                if !planController.hasGeneratedActivities && !planController.isLoading {
                       planController.switchToBackupKey()
                       planController.resetBeforeNewSearch()
                   }
            }
            

            
        }

    }

    private func loadDataIfNeeded() {
        if planController.locationActivitiesByDay.isEmpty && !planController.hasGeneratedActivities {
            planController.sendNewMessage(userUID: userUID, location: location, filter: selectedTripType, days: days)
        }
    }

    
    
    
    func shareItinerary() {
        generatePDF { pdfURL in
            guard let pdfURL = pdfURL else { return }

            DispatchQueue.main.async {
                let activityViewController = UIActivityViewController(activityItems: [pdfURL], applicationActivities: nil)

                if let topController = UIApplication.shared.connectedScenes
                    .compactMap({ $0 as? UIWindowScene })
                    .first?.windows.first?.rootViewController {
                    topController.present(activityViewController, animated: true, completion: nil)
                }
            }
        }
    }

    func generatePDF(completion: @escaping (URL?) -> Void) {
        let pageWidth: CGFloat = 612 // Standard A4 width
        let pageHeight: CGFloat = 792 // Standard A4 height
        let sideMargin: CGFloat = 72 // 1-inch margin on left & right
        let topMargin: CGFloat = 30 // Keep existing top margin
        let contentWidth: CGFloat = pageWidth - (2 * sideMargin) // Adjust width inside side margins
        let imageWidth: CGFloat = 220 // Wider images
        let imageHeight: CGFloat = 180 // Maintain aspect ratio
        let centerX = (pageWidth - imageWidth) / 2 // Center images

        let pdfRenderer = UIGraphicsPDFRenderer(bounds: CGRect(x: 0, y: 0, width: pageWidth, height: pageHeight))
        let url = FileManager.default.temporaryDirectory.appendingPathComponent("TripItinerary.pdf")

        let group = DispatchGroup()
        var imageCache: [String: UIImage] = [:] // Store downloaded images

        // ✅ **Step 1: Download images first**
        for dayActivity in planController.locationActivitiesByDay {
            for location in dayActivity.locations {
                if let imageUrl = location.imageUrl, let url = URL(string: imageUrl) {
                    group.enter()
                    DispatchQueue.global(qos: .background).async {
                        if let data = try? Data(contentsOf: url), let image = UIImage(data: data) {
                            DispatchQueue.main.async {
                                imageCache[imageUrl] = image
                                group.leave()
                            }
                        } else {
                            print("⚠️ Failed to load image from URL: \(imageUrl)")
                            group.leave()
                        }
                    }
                }
            }
        }

        // ✅ **Step 2: Wait until all images are downloaded**
        group.notify(queue: .main) {
            do {
                try pdfRenderer.writePDF(to: url) { context in
                    var yOffset: CGFloat = topMargin // Keep existing top margin

                    // ✅ **First Page - Itinerary Title (Centered)**
                    context.beginPage()
                    let titleAttributes: [NSAttributedString.Key: Any] = [
                        .font: UIFont.boldSystemFont(ofSize: 28),
                        .foregroundColor: UIColor.black
                    ]
                    let itineraryTitle = "Itinerary for \(self.location)"
                    let titleSize = itineraryTitle.size(withAttributes: titleAttributes)
                    let titleX = (pageWidth - titleSize.width) / 2 // Center horizontally
                    itineraryTitle.draw(in: CGRect(x: titleX, y: yOffset, width: titleSize.width, height: 50), withAttributes: titleAttributes)
                    yOffset += 50

                    // ✅ **Loop through all days**
                    for (index, dayActivity) in self.planController.locationActivitiesByDay.enumerated() {
                        // Start a new page for every day except the first
                        if index > 0 {
                            context.beginPage()
                            yOffset = topMargin // Reset yOffset to maintain spacing
                        }

                        // **Font Styling (Matching SwiftUI)**
                        let dayTitleAttributes: [NSAttributedString.Key: Any] = [
                            .font: UIFont.boldSystemFont(ofSize: 24),
                            .foregroundColor: UIColor(red: 0.25, green: 0.65, blue: 0.95, alpha: 1) // Light Blue
                        ]
                        let daySummaryAttributes: [NSAttributedString.Key: Any] = [
                            .font: UIFont.italicSystemFont(ofSize: 16),
                            .foregroundColor: UIColor.darkGray
                        ]
                        let locationNameAttributes: [NSAttributedString.Key: Any] = [
                            .font: UIFont.boldSystemFont(ofSize: 20),
                            .foregroundColor: UIColor.systemTeal // Teal
                        ]
                        let addressAttributes: [NSAttributedString.Key: Any] = [
                            .font: UIFont.italicSystemFont(ofSize: 14),
                            .foregroundColor: UIColor.darkGray
                        ]
                        let descriptionAttributes: [NSAttributedString.Key: Any] = [
                            .font: UIFont.systemFont(ofSize: 14),
                            .foregroundColor: UIColor.black
                        ]

                        // ✅ **Add "Day X" Title**
                        let dayTitle = "Day \(dayActivity.day)"
                        dayTitle.draw(in: CGRect(x: sideMargin, y: yOffset, width: contentWidth, height: 30), withAttributes: dayTitleAttributes)
                        yOffset += 35

                        // ✅ **Add Day Summary**
                        dayActivity.summary.draw(in: CGRect(x: sideMargin, y: yOffset, width: contentWidth, height: 40), withAttributes: daySummaryAttributes)
                        yOffset += 50

                        // ✅ **Loop through all locations for this day**
                        for location in dayActivity.locations {
                            // **Check if there's enough space; if not, start a new page**
                            if yOffset + imageHeight + 80 > (pageHeight - topMargin) {
                                context.beginPage()
                                yOffset = topMargin
                            }

                            // ✅ **Location Name**
                            location.location.draw(in: CGRect(x: sideMargin, y: yOffset, width: contentWidth, height: 30), withAttributes: locationNameAttributes)
                            yOffset += 25

                            // ✅ **Address**
                            location.address.draw(in: CGRect(x: sideMargin, y: yOffset, width: contentWidth, height: 20), withAttributes: addressAttributes)
                            yOffset += 25

                            // ✅ **Centered & Wider Image**
                            if let imageUrl = location.imageUrl, let image = imageCache[imageUrl] {
                                let imageRect = CGRect(x: centerX, y: yOffset, width: imageWidth, height: imageHeight) // Centered & wider
                                image.draw(in: imageRect)
                                yOffset += imageHeight + 10
                            } else {
                                print("⚠️ Image not found in cache for: \(location.imageUrl ?? "Unknown Image")")
                            }

                            // ✅ **Location Description**
                            location.description.draw(in: CGRect(x: sideMargin, y: yOffset, width: contentWidth, height: 60), withAttributes: descriptionAttributes)
                            yOffset += 70
                        }
                    }
                }

                DispatchQueue.main.async {
                    completion(url)
                }
            } catch {
                print("❌ Failed to generate PDF: \(error)")
                DispatchQueue.main.async {
                    completion(nil)
                }
            }
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
            if planController.isLoading {
                dotCount = (dotCount + 1) % (maxDots + 1)
            } else {
                timer.invalidate() // Stop timer when loading is done
            }
        }
    }

    
    func captureView<T: View>(view: T, completion: @escaping (UIImage?) -> Void) {
        let controller = UIHostingController(rootView: view)
        controller.view.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)

        // Add view to the key window to ensure rendering
        let keyWindow = UIApplication.shared.connectedScenes
            .compactMap { $0 as? UIWindowScene }
            .first?.windows.first

        keyWindow?.rootViewController?.view.addSubview(controller.view)

        // Delay to ensure images load before capturing
        DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) {
            if let screenshot = controller.view.takeScreenshot() {
                completion(screenshot)
            } else {
                completion(nil)
            }
            controller.view.removeFromSuperview() // Cleanup
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
extension UIView {
    func takeScreenshot() -> UIImage? {
        UIGraphicsBeginImageContextWithOptions(bounds.size, false, 0.0)
        drawHierarchy(in: self.bounds, afterScreenUpdates: true)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image
    }
}
