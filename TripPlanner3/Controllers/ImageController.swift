

// OG JUST UNSPLASH
////
////  ImageController.swift
////  TripPlanner3
////
////  Created by stlp on 9/14/24.
////
//
//import Foundation
//import SwiftUI
//
//// This class is responsible for fetching images from the Unsplash API
//class ImageController: ObservableObject {
//    // An ImageController instance for shared usage
//    static let shared = ImageController()
//    private init() {}
//    
//    // Unsplash API access key
//    var token = "DSGVIqrflJklVgCo2cqZ6gyBhm-xSvZk99P-jfIL9Dc"
//    // Published results array to store fetched results
//    @Published var results = [Result]()
//    
//    
//    private var rateLimitReached = false
//    
//    
//    // This function is to search images based on a location
//    func search(for location: String, completion: @escaping (String?) -> Void) {
//        
//        // Check if rate limit has been reached
//        if rateLimitReached {
//            // Use fallback image
//            let fallbackImageName = randomImageName(for: location)
//            completion(fallbackImageName)
//            return
//        }
//        
//        
//        
//        // Construct the URL string with a search query
//        let urlString = "https://api.unsplash.com/search/photos?query=\(location)&orientation=landscape"
//        guard let url = URL(string: urlString) else {
//            completion(nil)
//            return
//        }
//        
//        // Create a URLRequest object with the URL
//        var request = URLRequest(url: url)
//        request.httpMethod = "GET"
//        request.setValue("Client-ID \(token)", forHTTPHeaderField: "Authorization")
//
//        // Create a data task to perform the network request
//        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
//            // Handle the response headers to check rate limit
//            if let httpResponse = response as? HTTPURLResponse {
//                self.logRateLimitHeaders(httpResponse.allHeaderFields)
//            }
//            
//            guard let data = data else {
//                completion(nil)
//                return
//            }
//            
//            // Decode the JSON response
//            do {
//                let res = try JSONDecoder().decode(Results.self, from: data)
//                let imageUrl = res.results.first?.urls.small
//                completion(imageUrl)
//            } catch {
//                print("❗️ Decoding error:", error)
//                completion(nil)
//            }
//        }
//        task.resume()
//    }
//    
//    // Logs rate limit information
//    private func logRateLimitHeaders(_ headers: [AnyHashable: Any]) {
//        // Attempt to read headers by exact and lowercase matches for reliability
//        let limitKey = "X-Ratelimit-Limit"
//        let remainingKey = "X-Ratelimit-Remaining"
//        let resetKey = "X-Ratelimit-Reset"
//        
//        let limit = headers[limitKey] as? String ?? headers[limitKey.lowercased()] as? String
//        let remaining = headers[remainingKey] as? String ?? headers[remainingKey.lowercased()] as? String
//        let reset = headers[resetKey] as? String ?? headers[resetKey.lowercased()] as? String
//        
//        if let limit = limit, let remaining = remaining {
//            print("""
//            ----- API Rate Limit -----
//            Limit: \(limit)
//            Remaining: \(remaining)
//            --------------------------
//            """)
//
//            if let remainingRequests = Int(remaining) {
//                if remainingRequests == 0, let reset = reset {
//                    // Set rateLimitReached to true when limit is reached
//                    rateLimitReached = true
//                    let resetDate = Date(timeIntervalSince1970: TimeInterval(reset) ?? 0)
//                    print("⚠️ Rate limit reached. Next reset at \(resetDate)")
//                } else if remainingRequests == 50 {
//                    // Reset rateLimitReached to false when the limit resets
//                    rateLimitReached = false
//                    print("✅ Rate limit has been reset. API access restored.")
//                }
//            }
//        } else {
//            print("⚠️ Rate limit headers are missing or could not be parsed.")
//        }
//    }
//    
//    
//    
//    private func randomImageName(for location: String) -> String {
//        let locationPrefix = location.replacingOccurrences(of: " ", with: "").lowercased()
//        let imageNumber = Int.random(in: 1...8)
//        return "\(locationPrefix)day\(imageNumber)"
//    }
//    
//    
//}
//
//// Struct to represent the JSON response from the Unsplash API
//struct Results: Decodable {
//    var total: Int
//    var results: [Result]
//}
//
//// Struct to represent a single result from the Unsplash API
//struct Result: Decodable {
//    var id: String
//    var description: String?
//    var urls: URLs
//}
//
//// Struct to represent the URLs of an image
//struct URLs: Decodable {
//    var small: String
//}









//// testing unsplash with pexels
//import Foundation
//import SwiftUI
//
//class ImageController: ObservableObject {
//    static let shared = ImageController()
//    private init() {}
//
//    // Unsplash API
//    private let unsplashToken = "DSGVIqrflJklVgCo2cqZ6gyBhm-xSvZk99P-jfIL9Dc"
//    private var unsplashRateLimitReached = false
//
//    // Pexels API
//    private let pexelsToken = "PG0wCQZi7GG9JDjBRslVKPdKr6GEba4sQCXQMrpvfcRLBD3kcd301KMx"
//
//    // API Switch
//    private var usePexels = false
//
//    // Published results for SwiftUI updates
//    @Published var results = [Result]()
//
//    // Search for images based on location
//    func search(for location: String, completion: @escaping (String?) -> Void) {
//        if usePexels {
//            print("Using Pexels API")
//            fetchFromPexels(location: location, completion: completion)
//        } else {
//            print("Using Unsplash API")
//            fetchFromUnsplash(location: location, completion: completion)
//        }
//    }
//
//    // Fetch from Unsplash API
//    private func fetchFromUnsplash(location: String, completion: @escaping (String?) -> Void) {
//        guard let url = URL(string: "https://api.unsplash.com/search/photos?query=\(location)&orientation=landscape") else {
//            completion(nil)
//            return
//        }
//
//        var request = URLRequest(url: url)
//        request.httpMethod = "GET"
//        request.setValue("Client-ID \(unsplashToken)", forHTTPHeaderField: "Authorization")
//
//        let task = URLSession.shared.dataTask(with: request) { [weak self] (data, response, error) in
//            guard let self = self else { return }
//            if let httpResponse = response as? HTTPURLResponse {
//                self.logRateLimitHeaders(httpResponse.allHeaderFields)
//            }
//
//            guard let data = data else {
//                completion(nil)
//                return
//            }
//
//            do {
//                let res = try JSONDecoder().decode(Results.self, from: data)
//                let imageUrl = res.results.first?.urls.small
//                completion(imageUrl)
//            } catch {
//                print("❗️ Unsplash decoding error:", error)
//                completion(nil)
//            }
//        }
//        task.resume()
//    }
//
//    // Fetch from Pexels API
//    private func fetchFromPexels(location: String, completion: @escaping (String?) -> Void) {
//        guard let url = URL(string: "https://api.pexels.com/v1/search?query=\(location)&orientation=landscape") else {
//            completion(nil)
//            return
//        }
//
//        var request = URLRequest(url: url)
//        request.httpMethod = "GET"
//        request.setValue(pexelsToken, forHTTPHeaderField: "Authorization")
//
//        let task = URLSession.shared.dataTask(with: request) { [weak self] (data, response, error) in
//            guard let self = self else { return }
//            if let httpResponse = response as? HTTPURLResponse {
//                self.handleRateLimit(for: "Pexels", headers: httpResponse.allHeaderFields)
//            }
//
//            guard let data = data else {
//                completion(nil)
//                return
//            }
//
//            do {
//                let res = try JSONDecoder().decode(PexelsResults.self, from: data)
//                let imageUrl = res.photos.first?.src.medium
//                completion(imageUrl)
//            } catch {
//                print("❗️ Pexels decoding error:", error)
//                completion(nil)
//            }
//        }
//        task.resume()
//    }
//
//    // Handle rate limit headers and switch APIs if necessary
//    private func handleRateLimit(for api: String, headers: [AnyHashable: Any]) {
//        let remainingKey = api == "Unsplash" ? "X-Ratelimit-Remaining" : "X-Ratelimit-Limit-Remaining"
//        let resetKey = api == "Unsplash" ? "X-Ratelimit-Reset" : "X-Ratelimit-Reset"
//
//        if let remaining = headers[remainingKey] as? String, let remainingRequests = Int(remaining), remainingRequests == 0 {
//            if api == "Unsplash" {
//                unsplashRateLimitReached = true
//                usePexels = true
//            } else {
//                usePexels = false
//            }
//        }
//
//        if let reset = headers[resetKey] as? String {
//            let resetDate = Date(timeIntervalSince1970: TimeInterval(reset) ?? 0)
//            print("⚠️ \(api) rate limit reached. Resets at \(resetDate)")
//        }
//    }
//
//    // Log rate limit information for Unsplash
//    private func logRateLimitHeaders(_ headers: [AnyHashable: Any]) {
//        let limitKey = "X-Ratelimit-Limit"
//        let remainingKey = "X-Ratelimit-Remaining"
//        let resetKey = "X-Ratelimit-Reset"
//
//        let limit = headers[limitKey] as? String ?? headers[limitKey.lowercased()] as? String
//        let remaining = headers[remainingKey] as? String ?? headers[remainingKey.lowercased()] as? String
//        let reset = headers[resetKey] as? String ?? headers[resetKey.lowercased()] as? String
//
//        if let limit = limit, let remaining = remaining {
//            print("""
//            ----- API Rate Limit -----
//            Limit: \(limit)
//            Remaining: \(remaining)
//            --------------------------
//            """)
//
//            if let remainingRequests = Int(remaining) {
//                if remainingRequests == 0, let reset = reset {
//                    unsplashRateLimitReached = true
//                    let resetDate = Date(timeIntervalSince1970: TimeInterval(reset) ?? 0)
//                    print("⚠️ Rate limit reached. Next reset at \(resetDate)")
//                } else if remainingRequests > 0 {
//                    unsplashRateLimitReached = false
//                    usePexels = false
//                    print("✅ Rate limit has been reset. API access restored.")
//                }
//            }
//        } else {
//            print("⚠️ Rate limit headers are missing or could not be parsed.")
//        }
//    }
//}
//
//// Unsplash API response structs (as per your original code)
//struct Results: Decodable {
//    var total: Int
//    var results: [Result]
//}
//
//struct Result: Decodable {
//    var id: String
//    var description: String?
//    var urls: URLs
//}
//
//struct URLs: Decodable {
//    var small: String
//}
//
//// Pexels API response structs
//struct PexelsResults: Decodable {
//    let photos: [PexelsPhoto]
//}
//
//struct PexelsPhoto: Decodable {
//    let src: PexelsSrc
//}
//
//struct PexelsSrc: Decodable {
//    let medium: String
//}













//
//  ImageController.swift
//  TripPlanner3
//
//  Created by stlp on 9/14/24.
//

import Foundation
import SwiftUI

class ImageController: ObservableObject {
    static let shared = ImageController()

    // Unsplash API
    private let unsplashToken = "DSGVIqrflJklVgCo2cqZ6gyBhm-xSvZk99P-jfIL9Dc"
    private var unsplashRateLimitReached = false

    // Pexels API
    private let pexelsToken = "PG0wCQZi7GG9JDjBRslVKPdKr6GEba4sQCXQMrpvfcRLBD3kcd301KMx"

    // API Switch flag
    private var usePexels = false

    // Published results for SwiftUI updates
    @Published var results = [Result]()

    private init() {}

    // Search for images based on location
    func search(for location: String, completion: @escaping (String?) -> Void) {
        if usePexels {
            print("Using Pexels API")
            fetchFromPexels(location: location) { imageUrl in
                if let url = imageUrl {
                    completion(url)
                }
            }
        } else {
            print("Using Unsplash API")
            fetchFromUnsplash(location: location) { imageUrl in
                if let url = imageUrl {
                    completion(url)
                } else {
                    print("❗️ Unsplash failed or rate-limited. Switching to Pexels.")
                    self.usePexels = true
                    self.search(for: location, completion: completion) // Retry with Pexels
                }
            }
        }
    }

    // Fetch from Unsplash API
    private func fetchFromUnsplash(location: String, completion: @escaping (String?) -> Void) {
        guard let url = URL(string: "https://api.unsplash.com/search/photos?query=\(location)&orientation=landscape") else {
            completion(nil)
            return
        }

        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue("Client-ID \(unsplashToken)", forHTTPHeaderField: "Authorization")

        let task = URLSession.shared.dataTask(with: request) { [weak self] (data, response, error) in
            guard let self = self else { return }

            if let httpResponse = response as? HTTPURLResponse {
                self.logRateLimitHeaders(httpResponse.allHeaderFields)

                // Detect rate limit reached
                if httpResponse.statusCode == 429 { // 429: Too Many Requests
                    print("❗️ Unsplash rate limit reached. Switching to Pexels.")
                    self.unsplashRateLimitReached = true
                    self.usePexels = true
                    completion(nil)
                    return
                }
            }

            guard let data = data else {
                print("❗️ Unsplash API returned no data")
                completion(nil)
                return
            }

            // Attempt JSON decoding
            do {
                let res = try JSONDecoder().decode(Results.self, from: data)
                let imageUrl = res.results.first?.urls.small
                completion(imageUrl)
            } catch {
                print("❗️ Unsplash decoding error:", error)
                print("Raw Unsplash response: \(String(data: data, encoding: .utf8) ?? "Unknown")")
                self.unsplashRateLimitReached = true
                self.usePexels = true
                completion(nil)
            }
        }
        task.resume()
    }

    // Fetch from Pexels API
    private func fetchFromPexels(location: String, completion: @escaping (String?) -> Void) {
        guard let url = URL(string: "https://api.pexels.com/v1/search?query=\(location)&orientation=landscape") else {
            completion(nil)
            return
        }

        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue(pexelsToken, forHTTPHeaderField: "Authorization")

        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let httpResponse = response as? HTTPURLResponse {
                print("Pexels API Response Status Code: \(httpResponse.statusCode)")
            }

            guard let data = data else {
                print("❗️ No data received from Pexels")
                completion(nil)
                return
            }

            // Attempt JSON decoding
            do {
                let res = try JSONDecoder().decode(PexelsResults.self, from: data)
                print("Decoded Pexels response: \(res)")
                let imageUrl = res.photos.first?.src.medium
                completion(imageUrl)
            } catch {
                print("❗️ Pexels decoding error:", error)
                completion(nil)
            }
        }
        task.resume()
    }

    // Log rate limit information for Unsplash
    private func logRateLimitHeaders(_ headers: [AnyHashable: Any]) {
        let limitKey = "X-Ratelimit-Limit"
        let remainingKey = "X-Ratelimit-Remaining"
        let resetKey = "X-Ratelimit-Reset"

        let limit = headers[limitKey] as? String ?? headers[limitKey.lowercased()] as? String
        let remaining = headers[remainingKey] as? String ?? headers[remainingKey.lowercased()] as? String
        let reset = headers[resetKey] as? String ?? headers[resetKey.lowercased()] as? String

        if let limit = limit, let remaining = remaining {
            print("""
            ----- API Rate Limit -----
            Limit: \(limit)
            Remaining: \(remaining)
            --------------------------
            """)

            if let remainingRequests = Int(remaining) {
                if remainingRequests == 0, let reset = reset {
                    unsplashRateLimitReached = true
                    let resetDate = Date(timeIntervalSince1970: TimeInterval(reset) ?? 0)
                    print("⚠️ Rate limit reached. Next reset at \(resetDate)")
                } else if remainingRequests > 0 {
                    unsplashRateLimitReached = false
                    usePexels = false
                    print("✅ Rate limit has been reset. API access restored.")
                }
            }
        } else {
            print("⚠️ Rate limit headers are missing or could not be parsed.")
        }
    }
}

// Struct to represent the JSON response from the Unsplash API
struct Results: Decodable {
    var total: Int
    var results: [Result]
}

// Struct to represent a single result from the Unsplash API
struct Result: Decodable {
    var id: String
    var description: String?
    var urls: URLs
}

// Struct to represent the URLs of an image
struct URLs: Decodable {
    var small: String
}

// Pexels API response structs
struct PexelsResults: Decodable {
    let photos: [PexelsPhoto]
}

struct PexelsPhoto: Decodable {
    let src: PexelsSrc
}

struct PexelsSrc: Decodable {
    let medium: String
}






















//// no backup image - PIXABAY CODE ONLY
//import Foundation
//import SwiftUI
//
//
//// This class is responsible for fetching images from the Pixabay API
//class ImageController: ObservableObject {
//    static let shared = ImageController()
//    private init() {}
//
//    // Pixabay API key
//    private let pixabayApiKey = "47397926-71fec4d1a92f9219b79bfb44c"
//
//    @Published var results = [PixabayResult]()
//    private var rateLimitReached = false
//
//    // This function is to search images based on a location
//    func search(for location: String, completion: @escaping (String?) -> Void) {
//
//        // Pixabay API endpoint with refined query
//        let urlString = "https://pixabay.com/api/?key=\(pixabayApiKey)&q=\(location)+temple&image_type=photo&orientation=horizontal"
//        guard let url = URL(string: urlString) else {
//            completion(nil)
//            return
//        }
//
//        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
//            guard let data = data else {
//                completion(nil)
//                return
//            }
//
//            do {
//                let res = try JSONDecoder().decode(PixabayResponse.self, from: data)
//                
//                // Use a random image from the results to reduce duplication
//                if let randomHit = res.hits.randomElement() {
//                    completion(randomHit.largeImageURL)
//                } else {
//                    completion(nil) // No images found
//                }
//            } catch {
//                print("❗️ Decoding error:", error)
//                completion(nil)
//            }
//        }
//        task.resume()
//    }
//}
//
//// Structs for Pixabay API response
//struct PixabayResponse: Decodable {
//    let hits: [PixabayResult]
//}
//
//struct PixabayResult: Decodable {
//    let id: Int
//    let previewURL: String
//    let webformatURL: String  // Medium resolution
//    let largeImageURL: String // High resolution
//}
//
//
//
//
//
//
//
//
//
