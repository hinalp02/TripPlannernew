//
//  IntroController.swift
//  TripPlanner3
//
//  Created by stlp on 9/7/24.
//

import UIKit

class IntroController: UIViewController {
    
    var onTapCompletion: (() -> Void)?
    
    private var textOptions: [NSAttributedString] = [
        NSAttributedString(string: "Ever wanted to go on vacation without the hassle of planning out your trip?",
                           attributes: [.foregroundColor: UIColor.systemTeal, .font: UIFont.boldSystemFont(ofSize: 20)]),
        
        {
            let fullText = "TripPlanner creates your itinerary for you, simplifying your travel experience!\n\n"
            let highlightedText = "Get started today!"
            
            let tealColor = UIColor(red: 45/255, green: 85/255, blue: 93/255, alpha: 1)
            let attributedString = NSMutableAttributedString(string: fullText, attributes: [
                .foregroundColor: tealColor,
                .font: UIFont.boldSystemFont(ofSize: 22)
            ])

            
            let blackAttributes: [NSAttributedString.Key: Any] = [
                .foregroundColor: UIColor.black,
                .font: UIFont.boldSystemFont(ofSize: 19)
            ]
            
            let range = (fullText as NSString).length
            attributedString.append(NSAttributedString(string: highlightedText, attributes: blackAttributes))
            
            return attributedString
        }()
    ]

    
    private var currentIndex = 0

    private let introImageView: UIImageView = {  // Background Image
        let imageView = UIImageView()
        imageView.image = UIImage(named: "beachBackground")  // Ensure "splashImage" is in Assets
        imageView.contentMode = .scaleAspectFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.isUserInteractionEnabled = true  // Enable interaction to detect taps
        return imageView
    }()
    
    private let textBoxView: UIView = {  // White rounded box for text
        let view = UIView()
        view.backgroundColor = UIColor.white.withAlphaComponent(0.85) // Matching transparency
        view.layer.cornerRadius = 30
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let textLabel: UILabel = {  // Label inside the text box
        let label = UILabel()
        label.text = "Ever wanted to go on vacation without the hassle of planning out your trip?"
        label.textAlignment = .center
        label.baselineAdjustment = .alignCenters
        label.numberOfLines = 0
        label.font = UIFont.boldSystemFont(ofSize: 22)  // Matches .title2.bold()
        let tealColor = UIColor(red: 45/255, green: 85/255, blue: 93/255, alpha: 1)
        label.textColor = tealColor
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let arrowButton: UIButton = {
        let button = UIButton(type: .custom)
        
        let size: CGFloat = 50 // Button size

        // Outer White Background Circle (Full button background)
        let outerCircle = UIView(frame: CGRect(x: 0, y: 0, width: size, height: size))
        outerCircle.backgroundColor = .white
        outerCircle.layer.cornerRadius = size / 2
        outerCircle.isUserInteractionEnabled = false
        
        // Inner Circle (Just the teal border)
        let innerCircleSize: CGFloat = size * 0.75 // 75% of outer size
        let innerCircle = UIView(frame: CGRect(x: size * 0.125, y: size * 0.125, width: innerCircleSize, height: innerCircleSize))
        innerCircle.backgroundColor = .clear // Background remains white
        innerCircle.layer.cornerRadius = innerCircleSize / 2
        innerCircle.layer.borderWidth = 3 // Teal border
        innerCircle.layer.borderColor = UIColor(red: 0.0, green: 0.55, blue: 0.60, alpha: 1.0).cgColor // Teal color
        innerCircle.isUserInteractionEnabled = false
        
        // Teal Arrow Icon
        let arrowImage = UIImage(systemName: "chevron.right")?.withRenderingMode(.alwaysTemplate)
        let arrowImageView = UIImageView(image: arrowImage)
        arrowImageView.tintColor = UIColor(red: 0.0, green: 0.55, blue: 0.60, alpha: 1.0) // Teal arrow color
        arrowImageView.frame = CGRect(x: (innerCircleSize - 22) / 2, y: (innerCircleSize - 22) / 2, width: 22, height: 22)
        arrowImageView.contentMode = .scaleAspectFit
        
        // Adding all elements correctly
        button.addSubview(outerCircle)
        outerCircle.addSubview(innerCircle)
        innerCircle.addSubview(arrowImageView)
        
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()


    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupUI()
        
        // Add tap gesture recognizer to **entire screen**
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(didTapScreen))
        self.view.addGestureRecognizer(tapGesture)
    }
    
    private func setupUI() {
        self.view.addSubview(introImageView)
        self.view.addSubview(textBoxView)
        textBoxView.addSubview(textLabel)
        textBoxView.addSubview(arrowButton)

        NSLayoutConstraint.activate([
            // Background Image (Full screen)
            introImageView.topAnchor.constraint(equalTo: view.topAnchor),
            introImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            introImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            introImageView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            // Text Box (Centered and made bigger)
            textBoxView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            textBoxView.centerYAnchor.constraint(equalTo: view.centerYAnchor), // Adjusted for correct placement
            textBoxView.widthAnchor.constraint(equalToConstant: 340), // Increased width
            textBoxView.heightAnchor.constraint(equalToConstant: 170), // Increased height
            
            // Text Label (Inside Box)
            textLabel.centerYAnchor.constraint(equalTo: textBoxView.centerYAnchor),// More padding at the top
            textLabel.leadingAnchor.constraint(equalTo: textBoxView.leadingAnchor, constant: 25),
            textLabel.trailingAnchor.constraint(equalTo: textBoxView.trailingAnchor, constant: -25),
            
            // Arrow Button (Positioned lower)
            arrowButton.bottomAnchor.constraint(equalTo: textBoxView.bottomAnchor, constant: 25), 
            arrowButton.centerXAnchor.constraint(equalTo: textBoxView.centerXAnchor),
            arrowButton.widthAnchor.constraint(equalToConstant: 50),
            arrowButton.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    @objc private func didTapScreen() {
        UIView.transition(with: textLabel, duration: 0.3, options: .transitionCrossDissolve, animations: {
            if self.currentIndex == 0 {
                self.currentIndex = 1
                self.textLabel.attributedText = self.textOptions[self.currentIndex] // Apply formatted text
            } else {
                let loginController = LoginController()
                self.navigationController?.pushViewController(loginController, animated: false)
            }
        }, completion: nil)
    }

}
