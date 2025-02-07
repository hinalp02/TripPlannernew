//
//  NavigationBarExtensions.swift
//  TripPlanner3
//
//  Created by Hinal Patel on 2/4/25.
//

//import UIKit
//
//extension UINavigationController {
//    func setupNavBarColor() {
//        let transparentAppearance = UINavigationBarAppearance()
//        transparentAppearance.configureWithTransparentBackground()
//        transparentAppearance.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
//        transparentAppearance.largeTitleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
//
//        let whiteAppearance = UINavigationBarAppearance()
//        whiteAppearance.configureWithOpaqueBackground()
//        whiteAppearance.backgroundColor = UIColor.white // White bar when scrolling
//        whiteAppearance.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.black]
//        whiteAppearance.largeTitleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.black]
//
//        self.navigationBar.standardAppearance = whiteAppearance
//        self.navigationBar.scrollEdgeAppearance = transparentAppearance
//        self.navigationBar.compactAppearance = whiteAppearance
//
//        self.navigationBar.tintColor = .white // Default back button color
//        UIBarButtonItem.appearance().setTitleTextAttributes([.foregroundColor: UIColor.white], for: .normal)
//
//        trackScrollPosition() // Track scroll to update back button color
//    }
//
//    private func trackScrollPosition() {
//        NotificationCenter.default.addObserver(self, selector: #selector(updateBackButtonColor), name: NSNotification.Name("ScrollViewDidScroll"), object: nil)
//    }
//
//    @objc private func updateBackButtonColor(notification: Notification) {
//        guard let yOffset = notification.userInfo?["yOffset"] as? CGFloat else { return }
//
//        if yOffset > 50 { // When scrolling, turn back button black
//            self.navigationBar.tintColor = .black
//            UIBarButtonItem.appearance().setTitleTextAttributes([.foregroundColor: UIColor.black], for: .normal)
//        } else { // Default state, keep it white
//            self.navigationBar.tintColor = .white
//            UIBarButtonItem.appearance().setTitleTextAttributes([.foregroundColor: UIColor.white], for: .normal)
//        }
//    }
//}

import UIKit

extension UINavigationController {
    func setupNavBarColor() {
        let transparentAppearance = UINavigationBarAppearance()
        transparentAppearance.configureWithTransparentBackground()
        transparentAppearance.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        transparentAppearance.largeTitleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]

        let semiTransparentWhiteAppearance = UINavigationBarAppearance()
        semiTransparentWhiteAppearance.configureWithOpaqueBackground()
        semiTransparentWhiteAppearance.backgroundColor = UIColor.white.withAlphaComponent(0.85) // Adjust opacity (0.0 - 1.0)
        semiTransparentWhiteAppearance.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.black]
        semiTransparentWhiteAppearance.largeTitleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.black]

        self.navigationBar.standardAppearance = semiTransparentWhiteAppearance
        self.navigationBar.scrollEdgeAppearance = transparentAppearance
        self.navigationBar.compactAppearance = semiTransparentWhiteAppearance

        self.navigationBar.tintColor = .white // Default back button color
        UIBarButtonItem.appearance().setTitleTextAttributes([.foregroundColor: UIColor.white], for: .normal)

        trackScrollPosition() // Track scroll to update back button color
    }

    private func trackScrollPosition() {
        NotificationCenter.default.addObserver(self, selector: #selector(updateBackButtonColor), name: NSNotification.Name("ScrollViewDidScroll"), object: nil)
    }

    @objc private func updateBackButtonColor(notification: Notification) {
        guard let yOffset = notification.userInfo?["yOffset"] as? CGFloat else { return }

        if yOffset > 50 { // When scrolling, turn back button black
            self.navigationBar.tintColor = .black
            UIBarButtonItem.appearance().setTitleTextAttributes([.foregroundColor: UIColor.black], for: .normal)
        } else { // Default state, keep it white
            self.navigationBar.tintColor = .white
            UIBarButtonItem.appearance().setTitleTextAttributes([.foregroundColor: UIColor.white], for: .normal)
        }
    }
}
