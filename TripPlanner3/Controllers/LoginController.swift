import UIKit
import SwiftUI  // Import SwiftUI to use UIHostingController
import FirebaseAuth  // Import Firebase Authentication

class LoginController: UIViewController {
   
    // MARK: - UI Components
    private let backgroundImageView: UIImageView = {  // Background image view
        let imageView = UIImageView()
        imageView.image = UIImage(named: "background")  // Replace with your image name
        imageView.contentMode = .scaleAspectFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
   
    private let containerView: UIView = {  // Semi-transparent container view
        let view = UIView()
        view.backgroundColor = UIColor(white: 1, alpha: 0.55)  // White color with 45% opacity 0.35
        view.layer.cornerRadius = 20
        view.layer.masksToBounds = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
   
    private let signInLabel: UILabel = {  // "Sign In" heading
        let label = UILabel()
        label.text = "Sign In"
        label.textColor = UIColor(white: 1, alpha: 1.00)  // Dark white color
       
        label.font = UIFont.systemFont(ofSize: 35, weight: .bold)  // Adjust font size and weight as needed
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
   
    private let emailField = CustomTextField(fieldType: .email)
    private let passwordField = CustomTextField(fieldType: .password)
   
    private let signInButton = CustomButton(title: "Sign In", hasBackground: true, fontSize: .big)
   
    private let newUserButton: UIButton = {  // Styled button for "New User? Create Account."
        let button = UIButton(type: .system)
        let fullText = "New user? Create Account"
        let attributedString = NSMutableAttributedString(string: fullText)
       
        // Exact colors based on the extracted image
        let softBlueColor = UIColor(red: 97/255, green: 156/255, blue: 203/255, alpha: 1)  // Soft blue for "New user?"
        let tealColor = UIColor(red: 45/255, green: 85/255, blue: 93/255, alpha: 1)  // Teal color for "Create Account"
       
        // Apply the colors and font attributes
        attributedString.addAttribute(.foregroundColor, value: softBlueColor, range: NSRange(location: 0, length: 9))
        attributedString.addAttribute(.foregroundColor, value: tealColor, range: NSRange(location: 10, length: 14))
        attributedString.addAttribute(.font, value: UIFont.systemFont(ofSize: 17, weight: .bold), range: NSRange(location: 0, length: fullText.count))  // Larger size and bold
        button.setAttributedTitle(attributedString, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
   
    private let forgotPasswordButton: UIButton = {  // Styled button for "Forgot Password?"
        let button = UIButton(type: .system)
       
        // New complementary color for "Forgot Password?"
        let complementaryColor = UIColor(red: 125/255, green: 98/255, blue: 176/255, alpha: 1)  // Soft purple shade
       
        button.setTitle("Forgot Password?", for: .normal)
        button.setTitleColor(complementaryColor, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 17, weight: .bold)  // Larger size and bold
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
   
    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupUI()
       
        self.signInButton.addTarget(self, action: #selector(didTapSignIn), for: .touchUpInside)
        self.newUserButton.addTarget(self, action: #selector(didTapNewUser), for: .touchUpInside)
        self.forgotPasswordButton.addTarget(self, action: #selector(didTapForgotPassword), for: .touchUpInside)
       
    }
   
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isHidden = true
    }
   
    // MARK: - UI Setup
    private func setupUI() {
        // Set up the background image
        self.view.addSubview(backgroundImageView)
        NSLayoutConstraint.activate([
            backgroundImageView.topAnchor.constraint(equalTo: view.topAnchor),
            backgroundImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            backgroundImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            backgroundImageView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
       
        self.view.backgroundColor = .systemBackground
       
        // Set up the container view (faded white box)
        self.view.addSubview(containerView)
        NSLayoutConstraint.activate([
            containerView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            containerView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            containerView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.85),
            containerView.heightAnchor.constraint(equalToConstant: 350)  // Increase height to accommodate the heading
        ])
       
        // Add UI components inside the containerView
        containerView.addSubview(signInLabel)
        containerView.addSubview(emailField)
        containerView.addSubview(passwordField)
        containerView.addSubview(signInButton)
        containerView.addSubview(newUserButton)
        containerView.addSubview(forgotPasswordButton)
       
        signInLabel.translatesAutoresizingMaskIntoConstraints = false
        emailField.translatesAutoresizingMaskIntoConstraints = false
        passwordField.translatesAutoresizingMaskIntoConstraints = false
        signInButton.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            // Sign In Label
            signInLabel.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 20),
            signInLabel.centerXAnchor.constraint(equalTo: containerView.centerXAnchor),
           
            // Email Field
            self.emailField.topAnchor.constraint(equalTo: self.signInLabel.bottomAnchor, constant: 15),
            self.emailField.centerXAnchor.constraint(equalTo: containerView.centerXAnchor),
            self.emailField.heightAnchor.constraint(equalToConstant: 50),
            self.emailField.widthAnchor.constraint(equalTo: containerView.widthAnchor, multiplier: 0.85),
           
            // Password Field
            self.passwordField.topAnchor.constraint(equalTo: emailField.bottomAnchor, constant: 15),
            self.passwordField.centerXAnchor.constraint(equalTo: containerView.centerXAnchor),
            self.passwordField.heightAnchor.constraint(equalToConstant: 50),
            self.passwordField.widthAnchor.constraint(equalTo: containerView.widthAnchor, multiplier: 0.85),
           
            // Sign In Button
            self.signInButton.topAnchor.constraint(equalTo: passwordField.bottomAnchor, constant: 20),
            self.signInButton.centerXAnchor.constraint(equalTo: containerView.centerXAnchor),
            self.signInButton.heightAnchor.constraint(equalToConstant: 50),
            self.signInButton.widthAnchor.constraint(equalTo: containerView.widthAnchor, multiplier: 0.85),
           
            // New User Button
            self.newUserButton.topAnchor.constraint(equalTo: signInButton.bottomAnchor, constant: 10),
            self.newUserButton.centerXAnchor.constraint(equalTo: containerView.centerXAnchor),
           
            // Forgot Password Button
            self.forgotPasswordButton.topAnchor.constraint(equalTo: newUserButton.bottomAnchor, constant: 5),
            self.forgotPasswordButton.centerXAnchor.constraint(equalTo: containerView.centerXAnchor),
        ])
    }
   
    // MARK: - Selectors
    @objc private func didTapSignIn() {
        let loginRequest = LoginUserRequest(
            email: self.emailField.text ?? "",
            password: self.passwordField.text ?? ""
        )
       
        // Email check
        if !Validator.isValidEmail(for: loginRequest.email) {
            AlertManager.showInvalidEmailAlert(on: self)
            return
        }

        // Password check
        if !Validator.isPasswordValid(for: loginRequest.password) {
            AlertManager.showInvalidPasswordAlert(on: self)
            return
        }

        // Attempt to sign in directly
        AuthService.shared.signIn(with: loginRequest) { error in
            if let error = error {
                self.handleSignInError(error)
                return
            }
           
            // Successful login, proceed to the next step
            if let sceneDelegate = self.view.window?.windowScene?.delegate as? SceneDelegate {
                sceneDelegate.checkAuthentication()
            }
        }
    }
   

    // Method to handle specific Firebase Auth Errors
    private func handleSignInError(_ error: Error) {
        guard let authError = AuthErrorCode(rawValue: error._code) else {
            // Fallback to a generic error alert if no specific error code matches
            AlertManager.showSignInErrorAlert(on: self, with: error)
            return
        }

        switch authError {
        case .wrongPassword:
            // Incorrect password entered for an existing account
            let customError = NSError(domain: "", code: 0, userInfo: [NSLocalizedDescriptionKey: "Incorrect password. Please try again."])
            AlertManager.showSignInErrorAlert(on: self, with: customError)
       
        case .userNotFound:
            // Email entered does not correspond to any account
            let customError = NSError(domain: "", code: 0, userInfo: [NSLocalizedDescriptionKey: "Account doesn't exist. Please create an account or sign in with an existing one."])
            AlertManager.showSignInErrorAlert(on: self, with: customError)
       
        case .invalidEmail:
            // The email format is invalid
            let customError = NSError(domain: "", code: 0, userInfo: [NSLocalizedDescriptionKey: "The email address is badly formatted. Please enter a valid email."])
            AlertManager.showSignInErrorAlert(on: self, with: customError)
       
        case .invalidCredential:
            // Handle credentials issues by suggesting possible causes
            let customError = NSError(domain: "", code: 0, userInfo: [NSLocalizedDescriptionKey: "Incorrect password or the account doesn’t exist. Please check your email or password and try again."])
            AlertManager.showSignInErrorAlert(on: self, with: customError)
       
        default:
            // For any other unspecified errors
            AlertManager.showSignInErrorAlert(on: self, with: error)
        }
    }

     
    @objc private func didTapNewUser() {
        let vc = RegisterController()
        self.navigationController?.pushViewController(vc, animated: false)
    }
   
    @objc private func goToSecondView() {
        guard let userUID = Auth.auth().currentUser?.uid else {
            print("User is not logged in.")
            return
        }
       
        let secondView = SecondView(userUID: userUID)
        let hostingController = UIHostingController(rootView: secondView)
        self.navigationController?.pushViewController(hostingController, animated: true)
    }

   
    @objc private func didTapForgotPassword() {
        let vc = ForgotPasswordController()
        self.navigationController?.pushViewController(vc, animated: false)
    }
}

