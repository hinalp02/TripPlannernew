//
//  ImageController.swift
//  TripPlanner3
//
//  Created by stlp on 9/14/24.
//

import Foundation
import SwiftUI

// This class is responsible for fetching images from the Unsplash API
class ImageController: ObservableObject {
    // An ImageController instance for shared usage
    static let shared = ImageController()
    private init() {}
    
    // Unsplash API access key
    var token = "DSGVIqrflJklVgCo2cqZ6gyBhm-xSvZk99P-jfIL9Dc"
    // Published results array to store fetched results
    @Published var results = [Result]()
    
    
    private var rateLimitReached = false
    
    
    // This function is to search images based on a location
    func search(for location: String, completion: @escaping (String?) -> Void) {
        
        // Check if rate limit has been reached
        if rateLimitReached {
            // Use fallback image
            let fallbackImageName = randomImageName(for: location)
            completion(fallbackImageName)
            return
        }
        
        
        
        // Construct the URL string with a search query
        let urlString = "https://api.unsplash.com/search/photos?query=\(location)&orientation=landscape"
        guard let url = URL(string: urlString) else {
            completion(nil)
            return
        }
        
        // Create a URLRequest object with the URL
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue("Client-ID \(token)", forHTTPHeaderField: "Authorization")

        // Create a data task to perform the network request
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            // Handle the response headers to check rate limit
            if let httpResponse = response as? HTTPURLResponse {
                self.logRateLimitHeaders(httpResponse.allHeaderFields)
            }
            
            guard let data = data else {
                completion(nil)
                return
            }
            
            // Decode the JSON response
            do {
                let res = try JSONDecoder().decode(Results.self, from: data)
                let imageUrl = res.results.first?.urls.small
                completion(imageUrl)
            } catch {
                print("❗️ Decoding error:", error)
                completion(nil)
            }
        }
        task.resume()
    }
    
    // Logs rate limit information
    private func logRateLimitHeaders(_ headers: [AnyHashable: Any]) {
        // Attempt to read headers by exact and lowercase matches for reliability
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
                    // Set rateLimitReached to true when limit is reached
                    rateLimitReached = true
                    let resetDate = Date(timeIntervalSince1970: TimeInterval(reset) ?? 0)
                    print("⚠️ Rate limit reached. Next reset at \(resetDate)")
                } else if remainingRequests == 50 {
                    // Reset rateLimitReached to false when the limit resets
                    rateLimitReached = false
                    print("✅ Rate limit has been reset. API access restored.")
                }
            }
        } else {
            print("⚠️ Rate limit headers are missing or could not be parsed.")
        }
    }
    
    
    
    private func randomImageName(for location: String) -> String {
        let locationPrefix = location.replacingOccurrences(of: " ", with: "").lowercased()
        let imageNumber = Int.random(in: 1...8)
        return "\(locationPrefix)day\(imageNumber)"
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


