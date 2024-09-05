//
//  SecondView.swift
//  TripPlanner
//
//  Created by Drishya Nair on 9/3/24.
//

import SwiftUI

struct SecondView: View {
    @State private var selectedCity: String = "Enter destination"
    @State private var selectedDays: Int = 5
    @State private var selectedTripTypes: Set<String> = []
    let daysOptions = [1, 2, 3, 4, 5, 6, 7, 8]
    let cities = ["Los Angeles, USA", "Honolulu, USA", "Paris, France", "Santorini, Greece", "Mumbai, India", "Shanghai, China", "Tokyo, Japan", "New York City, USA", "Cancun, Mexico", "London, England"]

    let elementHeight: CGFloat = 45
    let buttonWidth: CGFloat = UIScreen.main.bounds.width * 0.75

    var body: some View {
        NavigationView {
            VStack(spacing: 25) {
                Spacer().frame(height: 60)

                Text("Where are you headed?")
                    .font(.title)
                    .padding(.top, 10)

                Menu {
                    ForEach(cities, id: \.self) { city in
                        Button(city) {
                            selectedCity = city
                            print("Selected City: \(selectedCity)")
                        }
                    }
                } label: {
                    HStack {
                        Image(systemName: "magnifyingglass")
                            .foregroundColor(.gray)
                        Text(selectedCity)
                            .foregroundColor(selectedCity == "Enter destination" ? .gray : .black)
                        Spacer()
                        Image(systemName: "chevron.down")
                            .foregroundColor(.blue)
                    }
                    .padding()
                    .frame(width: buttonWidth, height: elementHeight)
                    .background(Color(.white))
                    .cornerRadius(8)
                }
                .padding(.horizontal)

                VStack(alignment: .leading, spacing: 5) {
                    Text("Days")
                        .font(.title2.bold())
                        .foregroundColor(Color(.systemTeal))

                    Text("How many days will you be gone for?")
                        .font(.subheadline)
                        .foregroundColor(.gray)
                }
                .padding(.leading, (UIScreen.main.bounds.width - buttonWidth) / 2)
                .padding(.leading, -83)
                .padding(.bottom, 5)

                Picker("How many days will you be gone for?", selection: $selectedDays) {
                    ForEach(daysOptions, id: \.self) { day in
                        Text("\(day) Days")
                    }
                }
                .pickerStyle(MenuPickerStyle())
                .padding()
                .frame(width: buttonWidth, height: elementHeight)
                .background(Color(.white))
                .cornerRadius(8)
                .overlay(
                    RoundedRectangle(cornerRadius: 8)
                        .stroke(Color(red: 96/255, green: 131/255, blue: 153/255, opacity: 255/255), lineWidth: 3)
                )
                .padding(.horizontal)
                .onChange(of: selectedDays) { newValue in
                    print("Selected Days: \(selectedDays)")
                }

                VStack(alignment: .leading, spacing: 5) {
                    Text("Trip Type")
                        .font(.title2.bold())
                        .foregroundColor(Color(.systemTeal))

                    Text("What kind of trip do you want to go on?")
                        .font(.subheadline)
                        .foregroundColor(.gray)
                }
                .padding(.leading, (UIScreen.main.bounds.width - buttonWidth) / 2)
                .padding(.leading, -74)
                .padding(.bottom, 5)

                VStack(spacing: 10) {
                    HStack(spacing: 10) {
                        tripTypeButton(title: "Adventurous")
                        tripTypeButton(title: "Relaxing")
                    }
                    HStack(spacing: 10) {
                        tripTypeButton(title: "Party")
                        tripTypeButton(title: "Historical")
                    }
                }
                .frame(width: buttonWidth)

                Button(action: {
                    print("Planning Trip with City: \(selectedCity), Days: \(selectedDays), Trip Types: \(selectedTripTypes)")

                }) {
                    Text("Plan Your Next Trip!")
                        .font(.headline)
                        .padding()
                        .frame(width: buttonWidth, height: elementHeight)
                        .background(Color.teal)
                        .foregroundColor(.white)
                        .cornerRadius(8)
                }
                .padding(.horizontal)

                Spacer()

                HStack {
                    Spacer()
                    TabBarItem(iconName: "briefcase", label: "Past Trips")
                    Spacer()
                    TabBarItem(iconName: "globe", label: "Plan Trip")
                    Spacer()
                    TabBarItem(iconName: "person", label: "Profile")
                    Spacer()
                    TabBarItem(iconName: "gearshape", label: "Settings")
                    Spacer()
                }
                .padding(.bottom)
                .background(Color(.white))
                .cornerRadius(8)
                .shadow(radius: 5)
            }
            .background(
                LinearGradient(
                    gradient: Gradient(colors: [Color.teal.opacity(0.3), Color.white]),
                    startPoint: .top,
                    endPoint: .bottom
                )
            )
            .edgesIgnoringSafeArea(.all)
        }
    }

    private func tripTypeButton(title: String) -> some View {
        Text(title)
            .font(.headline)
            .padding()
            .frame(width: (buttonWidth - 10) / 2, height: elementHeight) // Ensuring equal width and height
            .background(selectedTripTypes.contains(title) ? Color(red: 96/255, green: 131/255, blue: 153/255) : Color(red: 200/255, green: 228/255, blue: 250/255)) // Background color when selected
            .foregroundColor(selectedTripTypes.contains(title) ? Color.white : Color.black) // Text color
            .cornerRadius(8)
            .onTapGesture {
                if selectedTripTypes.contains(title) {
                    selectedTripTypes.remove(title)
                } else {
                    selectedTripTypes.insert(title)
                }
                print("Selected Trip Types: \(selectedTripTypes)")
            }
    }

    private func TabBarItem(iconName: String, label: String) -> some View {
        VStack {
            Image(systemName: iconName)
            Text(label)
                .font(.footnote)
        }
        .padding(.vertical, 10)
        .foregroundColor(.blue)
    }
}