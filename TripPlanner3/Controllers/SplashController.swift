//
//  SplashController.swift
//  TripPlanner3
//
//  Created by stlp on 9/7/24.
//
import UIKit

class SplashController: UIViewController {

    var onTapCompletion: (() -> Void)?  // Closure to be executed when the image is tapped

    private let splashImageView: UIImageView = {  // Image view to display the provided splash image
        let imageView = UIImageView()
        imageView.image = UIImage(named: "introImage")  // Replace "splashImage" with your image name
        imageView.contentMode = .scaleAspectFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.isUserInteractionEnabled = true  // Enable interaction to detect taps
        return imageView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupUI()

        // Hide the back button
        self.navigationItem.hidesBackButton = true
        
        // Add tap gesture recognizer to the image view
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(didTapImage))
        splashImageView.addGestureRecognizer(tapGesture)
    }
    
    private func setupUI() {
        self.view.addSubview(splashImageView)
        NSLayoutConstraint.activate([
            splashImageView.topAnchor.constraint(equalTo: view.topAnchor),
            splashImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            splashImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            splashImageView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    @objc private func didTapImage() {
        // Navigate to the LoginController without animation when the image is tapped
        let loginController = LoginController()
        self.navigationController?.pushViewController(loginController, animated: false)  // No animation
    }
}
