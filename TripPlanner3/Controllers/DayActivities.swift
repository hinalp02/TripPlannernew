//
//  DayActivities.swift
//  TripPlanner3
//
//  Created by stlp on 10/6/24.
//

import Foundation

// Define the struct for TripDayActivities, which conforms to Identifiable and Hashable
struct TripDayActivities: Identifiable, Hashable {
    var id: UUID = .init()  // identifier for the day
    var day: Int  // day number
    var summary: String  // summary for the day's activities
    var locations: [TripLocationActivities]  // array of activities for the day

    // Conform to Hashable by implementing the hash function (automatically done in Swift 5.3+)
    static func == (lhs: TripDayActivities, rhs: TripDayActivities) -> Bool {
        return lhs.id == rhs.id
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}

// Define the struct for TripLocationActivities, which also conforms to Identifiable and Hashable
struct TripLocationActivities: Identifiable, Hashable {
    var id: UUID = .init()  // identifier for the location
    var location: String  // location name
    var description: String  // description of the activity
    var address: String  // address of the location
    var imageUrl: String?  // optional URL for the image

    static func == (lhs: TripLocationActivities, rhs: TripLocationActivities) -> Bool {
        return lhs.id == rhs.id
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}
