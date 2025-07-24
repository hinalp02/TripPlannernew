//
//  iteneraryModels.swift
//  TripPlanner3
//
//  Created by stlp on 10/6/24.
//

import Foundation

// Define the struct for DayActivities1, which conforms to Identifiable, Hashable, and Equatable
struct DayActivities1: Identifiable, Hashable, Equatable {
    var id: UUID = .init()  // identifier for the day
    var day: Int  // day number
    var summary: String  // summary for the day's activities
    var locations: [LocationActivities1]  // array of activities for the day

    // Conform to Hashable and Equatable
    static func == (lhs: DayActivities1, rhs: DayActivities1) -> Bool {
        return lhs.id == rhs.id
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}

// Define the struct for LocationActivities1, which also conforms to Identifiable, Hashable, and Equatable
struct LocationActivities1: Identifiable, Hashable, Equatable {
    var id: UUID = .init()  // identifier for the location
    var location: String  // location name
    var description: String  // description of the activity
    var address: String  // address of the location
    var imageUrl: String?  // optional image URL

    // Conform to Hashable and Equatable
    static func == (lhs: LocationActivities1, rhs: LocationActivities1) -> Bool {
        return lhs.id == rhs.id
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}
