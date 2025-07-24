import UIKit

class ForgotPasswordController: UIViewController {
   
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
   
    private let forgotPasswordLabel: UILabel = {  // "Forgot Password" heading
        let label = UILabel()
        label.text = "Forgot Password ?"
        label.textColor = UIColor(white: 1, alpha: 1.10)  // Dark white color
        label.font = UIFont.systemFont(ofSize: 35, weight: .bold)  // Adjust font size and weight as needed
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
   
    private let emailField = CustomTextField(fieldType: .email)
    private let resetPasswordButton = CustomButton(title: "Reset Password", hasBackground: true, fontSize: .big)

    // Custom back button as a UIButton
//    private let backButton: UIButton = {
//        let button = UIButton(type: .system)
//        button.setTitle("◀︎ Back", for: .normal)  // Arrow with Back text
//        //button.setTitleColor(UIColor(red: 97/255, green: 156/255, blue: 203/255, alpha: 1), for: .normal)  // Soft blue color
//        button.setTitleColor(.black, for: .normal)  //black color
//        button.titleLabel?.font = UIFont.systemFont(ofSize: 17, weight: .bold)
//        button.translatesAutoresizingMaskIntoConstraints = false
//        return button
//    }()
   
    private let backButton: UIButton = {
        var configuration = UIButton.Configuration.filled()
        configuration.title = "◀︎ Back"
        configuration.baseForegroundColor = UIColor.white  // White text to match theme
        configuration.baseBackgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.3)
        configuration.cornerStyle = .medium
        configuration.buttonSize = .medium
        configuration.contentInsets = NSDirectionalEdgeInsets(top: 4, leading: 8, bottom: 4, trailing: 8)
        let button = UIButton(configuration: configuration)
       
        // Apply shadow to create a lifted effect
        button.layer.shadowColor = UIColor.black.cgColor
        button.layer.shadowOpacity = 0.1  // Subtle shadow
        button.layer.shadowOffset = CGSize(width: 0, height: 2)  // Light downward shadow
        button.layer.shadowRadius = 2
       
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()


   
    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupUI()
       
        self.resetPasswordButton.addTarget(self, action: #selector(didTapForgotPassword), for: .touchUpInside)
        self.backButton.addTarget(self, action: #selector(goToSignInPage), for: .touchUpInside)  // Add target for back button
    }
   
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: false)  // Hide the default navigation bar
    }
   
    // MARK: - UI Setup
    private func setupUI() {
        // Set up the background image
        self.view.backgroundColor = .systemBackground
        self.view.addSubview(backgroundImageView)
        self.view.addSubview(containerView)
        self.view.addSubview(backButton)
        NSLayoutConstraint.activate([
            backgroundImageView.topAnchor.constraint(equalTo: view.topAnchor),
            backgroundImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            backgroundImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            backgroundImageView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
       
        self.view.backgroundColor = .systemBackground
       
        // Add back button to the main view
        self.view.addSubview(backButton)
        NSLayoutConstraint.activate([
            backButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),  // Position it slightly inside from the left
            backButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 8)  // Position it below the safe area
        ])
       
        // Set up the container view (faded white box)
        self.view.addSubview(containerView)
        NSLayoutConstraint.activate([
            containerView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            containerView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            containerView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.85),
            containerView.heightAnchor.constraint(equalToConstant: 250)  // Reduced height for more compact look
        ])
       
        // Add UI components inside the containerView
        containerView.addSubview(forgotPasswordLabel)
        containerView.addSubview(emailField)
        containerView.addSubview(resetPasswordButton)
       
        forgotPasswordLabel.translatesAutoresizingMaskIntoConstraints = false
        emailField.translatesAutoresizingMaskIntoConstraints = false
        resetPasswordButton.translatesAutoresizingMaskIntoConstraints = false
       
        NSLayoutConstraint.activate([
            // Forgot Password Label
            forgotPasswordLabel.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 20),
            forgotPasswordLabel.centerXAnchor.constraint(equalTo: containerView.centerXAnchor),
           
            // Email Field
            emailField.topAnchor.constraint(equalTo: forgotPasswordLabel.bottomAnchor, constant: 20),
            emailField.centerXAnchor.constraint(equalTo: containerView.centerXAnchor),
            emailField.heightAnchor.constraint(equalToConstant: 55),
            emailField.widthAnchor.constraint(equalTo: containerView.widthAnchor, multiplier: 0.85),
           
            // Reset Password Button
            resetPasswordButton.topAnchor.constraint(equalTo: emailField.bottomAnchor, constant: 20),
            resetPasswordButton.centerXAnchor.constraint(equalTo: containerView.centerXAnchor),
            resetPasswordButton.heightAnchor.constraint(equalToConstant: 55),
            resetPasswordButton.widthAnchor.constraint(equalTo: containerView.widthAnchor, multiplier: 0.85)
        ])
    }
   
    // MARK: - Selectors
    @objc private func didTapForgotPassword() {
        let email = self.emailField.text ?? ""
       
        if !Validator.isValidEmail(for: email) {
            AlertManager.showInvalidEmailAlert(on: self)
            return
        }
       
        AuthService.shared.forgotPassword(with: email) { [weak self] error in
            guard let self = self else { return }
            if let error = error {
                AlertManager.showErrorSendingPasswordReset(on: self, with: error)
                return
            }
           
            AlertManager.showPasswordResetSent(on: self)
        }
    }

    @objc private func goToSignInPage() {
        // Use navigation controller to pop back to the previous controller without animation
        navigationController?.popViewController(animated: false)
    }
}

