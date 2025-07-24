//
//  ProfileHeaderView.swift
//  TripPlanner3
//
//  Created by stlp on 9/14/24.
//

import Foundation
import SwiftUI

struct ProfileHeaderView: View {
    @Binding var profileImage: UIImage?
    var username: String
    @Binding var showingImagePicker: Bool
    @Binding var isEditing: Bool

    var body: some View {
        ZStack {
            // Background rectangle to match the desired style
            RoundedRectangle(cornerRadius: 20)
                .fill(Color(red: 0.19, green: 0.65, blue: 0.78))  // Use the desired color
                .frame(height: 200)
                .padding(.horizontal)
            
            VStack {
                if let image = profileImage {
                    Image(uiImage: image)
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 100, height: 100)
                        .clipShape(Circle())
                        .overlay(Circle().stroke(Color.white, lineWidth: 2))
                        .padding(.top, -50)
                } else {
                    Text(initials(for: username))
                        .font(.largeTitle)
                        .foregroundColor(.white)
                        .frame(width: 100, height: 100)
                        .background(Circle().fill(Color.gray))
                        .overlay(Circle().stroke(Color.white, lineWidth: 2))
                        .padding(.top, -50)
                }

                if isEditing {
                    Button(action: {
                        showingImagePicker.toggle()
                    }) {
                        Image(systemName: "pencil.circle.fill")
                            .font(.system(size: 24))
                            .foregroundColor(.blue)
                            .background(Circle().fill(Color.white))
                            .offset(x: 40, y: -30)
                    }
                    
                    // Small text button to remove the profile picture
                    if profileImage != nil {
                        Button(action: {
                            profileImage = nil
                        }) {
                            Text("Remove Profile Picture")
                                .foregroundColor(.red)
                                .underline()
                        }
                        .padding(.top, 8)
                    }
                }
            }
        }
    }

    private func initials(for name: String) -> String {
        let components = name.split(separator: " ")
        let initials = components.compactMap { $0.first }.map { String($0) }.joined()
        return String(initials.prefix(2)).uppercased()
    }
}
