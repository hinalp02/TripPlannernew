//
//  button.swift
//  TripPlanner3
//
//  Created by stlp on 10/5/24.
//
import SwiftUI
import Foundation
struct DayButtonView: View {
    var dayActivities: DayActivities
    var buttonWidth: CGFloat
    var buttonHeight: CGFloat
    var activities: [String]

    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                // Display the day number
                Text("Day \(dayActivities.day)")
                    .font(.title2)
                    .fontWeight(.bold)

                // Display the text "View Activities"
                Text("View Activities")
                    .font(.subheadline)
                    .foregroundColor(.gray)
            }
            .padding(.leading, 15)

            Spacer()

            // Add a chevron icon to the right side of the button
            Image(systemName: "chevron.right")
                .foregroundColor(.blue)
                .padding(.trailing, 15)
        }
        .frame(width: buttonWidth, height: buttonHeight)
        .background(Color(.systemGray6))  // Set the background color for the button
        .cornerRadius(10)
        .shadow(radius: 2)
        .padding(.horizontal)
        .padding(.top, dayActivities.day == 1 ? 10 : 0)  // Add padding for the first day only
    }
}
