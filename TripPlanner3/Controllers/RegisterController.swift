import UIKit

class RegisterController: UIViewController {
   
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
   
    private let signUpLabel: UILabel = {  // "Sign Up" heading
        let label = UILabel()
        label.text = "Create Your Account"
        label.textColor = UIColor(white: 1, alpha: 0.95)  // Dark white color
        label.font = UIFont.systemFont(ofSize: 32, weight: .bold)  // Adjust font size and weight as needed
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
   
    private let usernameField = CustomTextField(fieldType: .username)
    private let emailField = CustomTextField(fieldType: .email)
    private let passwordField = CustomTextField(fieldType: .password)
   
    private let signUpButton = CustomButton(title: "Sign Up", hasBackground: true, fontSize: .big)
   
    private let signInButton: UIButton = {  // Styled button for "Already have an account? Sign In."
        let button = UIButton(type: .system)
        let fullText = "Already have an account? Sign In"
        let attributedString = NSMutableAttributedString(string: fullText)
       
        // Color styling
        let softBlueColor = UIColor(red: 97/255, green: 156/255, blue: 203/255, alpha: 1)
        let tealColor = UIColor(red: 45/255, green: 85/255, blue: 93/255, alpha: 1)
       
        // Calculate the ranges dynamically to avoid out-of-bounds error
        if let range1 = fullText.range(of: "Already have an account?") {
            let nsRange1 = NSRange(range1, in: fullText)
            attributedString.addAttribute(.foregroundColor, value: softBlueColor, range: nsRange1)
        }
       
        if let range2 = fullText.range(of: "Sign In") {
            let nsRange2 = NSRange(range2, in: fullText)
            attributedString.addAttribute(.foregroundColor, value: tealColor, range: nsRange2)
        }
       
        // Apply the font attributes to the entire string
        attributedString.addAttribute(.font, value: UIFont.systemFont(ofSize: 17, weight: .bold), range: NSRange(location: 0, length: fullText.count))  // Larger size and bold
       
        button.setAttributedTitle(attributedString, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
   
    private let backToSignInButton: UIButton = {  // New button to go back to the LoginController
        let button = UIButton(type: .system)
        button.setTitle("Back to Sign In", for: .normal)
        button.setTitleColor(UIColor.systemBlue, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
   
    private let termsTextView: UITextView = {
        let termsText = "By creating an account, you agree to our Terms & Conditions and you acknowledge that you have read our Privacy Policy."
       
        let attributedString = NSMutableAttributedString(string: termsText)
       
        // Calculate ranges for the links dynamically
        if let termsRange = termsText.range(of: "Terms & Conditions") {
            let nsRange = NSRange(termsRange, in: termsText)
            attributedString.addAttribute(.link, value: "terms://termsAndConditions", range: nsRange)
        }
       
        if let privacyRange = termsText.range(of: "Privacy Policy") {
            let nsRange = NSRange(privacyRange, in: termsText)
            attributedString.addAttribute(.link, value: "privacy://privacyPolicy", range: nsRange)
        }
       
        let tv = UITextView()
        tv.linkTextAttributes = [.foregroundColor: UIColor.systemBlue]
        tv.backgroundColor = .clear
        tv.attributedText = attributedString
        tv.textColor = .label
        tv.isSelectable = true
        tv.isEditable = false
        tv.delaysContentTouches = false
        tv.isScrollEnabled = false
        tv.translatesAutoresizingMaskIntoConstraints = false
        return tv
    }()
   
    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupUI()
       
        self.termsTextView.delegate = self
       
        self.signUpButton.addTarget(self, action: #selector(didTapSignUp), for: .touchUpInside)
        self.signInButton.addTarget(self, action: #selector(didTapSignIn), for: .touchUpInside)
        self.backToSignInButton.addTarget(self, action: #selector(didTapBackToSignIn), for: .touchUpInside)  // New target
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
            containerView.heightAnchor.constraint(equalToConstant: 450)  // Adjusted height for added components
        ])
       
        // Add UI components inside the containerView
        containerView.addSubview(signUpLabel)
        containerView.addSubview(usernameField)
        containerView.addSubview(emailField)
        containerView.addSubview(passwordField)
        containerView.addSubview(signUpButton)
        containerView.addSubview(termsTextView)
        containerView.addSubview(signInButton)
        containerView.addSubview(backToSignInButton)  // New button added
       
        signUpLabel.translatesAutoresizingMaskIntoConstraints = false
        usernameField.translatesAutoresizingMaskIntoConstraints = false
        emailField.translatesAutoresizingMaskIntoConstraints = false
        passwordField.translatesAutoresizingMaskIntoConstraints = false
        signUpButton.translatesAutoresizingMaskIntoConstraints = false
        termsTextView.translatesAutoresizingMaskIntoConstraints = false
        signInButton.translatesAutoresizingMaskIntoConstraints = false
        backToSignInButton.translatesAutoresizingMaskIntoConstraints = false  // New button
       
        NSLayoutConstraint.activate([
            // Sign Up Label
            signUpLabel.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 20),
            signUpLabel.centerXAnchor.constraint(equalTo: containerView.centerXAnchor),
           
            // Username Field
            usernameField.topAnchor.constraint(equalTo: signUpLabel.bottomAnchor, constant: 15),
            usernameField.centerXAnchor.constraint(equalTo: containerView.centerXAnchor),
            usernameField.heightAnchor.constraint(equalToConstant: 55),
            usernameField.widthAnchor.constraint(equalTo: containerView.widthAnchor, multiplier: 0.85),
           
            // Email Field
            emailField.topAnchor.constraint(equalTo: usernameField.bottomAnchor, constant: 15),
            emailField.centerXAnchor.constraint(equalTo: containerView.centerXAnchor),
            emailField.heightAnchor.constraint(equalToConstant: 55),
            emailField.widthAnchor.constraint(equalTo: containerView.widthAnchor, multiplier: 0.85),
           
            // Password Field
            passwordField.topAnchor.constraint(equalTo: emailField.bottomAnchor, constant: 15),
            passwordField.centerXAnchor.constraint(equalTo: containerView.centerXAnchor),
            passwordField.heightAnchor.constraint(equalToConstant: 55),
            passwordField.widthAnchor.constraint(equalTo: containerView.widthAnchor, multiplier: 0.85),
           
            // Sign Up Button
            signUpButton.topAnchor.constraint(equalTo: passwordField.bottomAnchor, constant: 20),
            signUpButton.centerXAnchor.constraint(equalTo: containerView.centerXAnchor),
            signUpButton.heightAnchor.constraint(equalToConstant: 50),
            signUpButton.widthAnchor.constraint(equalTo: containerView.widthAnchor, multiplier: 0.85),
           
            // Terms TextView
            termsTextView.topAnchor.constraint(equalTo: signUpButton.bottomAnchor, constant: 10),
            termsTextView.centerXAnchor.constraint(equalTo: containerView.centerXAnchor),
            termsTextView.widthAnchor.constraint(equalTo: containerView.widthAnchor, multiplier: 0.85),
           
            // Sign In Button
            signInButton.topAnchor.constraint(equalTo: termsTextView.bottomAnchor, constant: 10),
            signInButton.centerXAnchor.constraint(equalTo: containerView.centerXAnchor),
           
            // Back to Sign In Button
            backToSignInButton.topAnchor.constraint(equalTo: signInButton.bottomAnchor, constant: 10),
            backToSignInButton.centerXAnchor.constraint(equalTo: containerView.centerXAnchor),
        ])
    }
   
    // MARK: - Selectors
    @objc func didTapSignUp() {
        let registerUserRequest = RegiserUserRequest(
            username: self.usernameField.text ?? "",
            email: self.emailField.text ?? "",
            password: self.passwordField.text ?? ""
        )
       
        // Username check
        if !Validator.isValidUsername(for: registerUserRequest.username) {
            AlertManager.showInvalidUsernameAlert(on: self)
            return
        }
       
        // Email check
        if !Validator.isValidEmail(for: registerUserRequest.email) {
            AlertManager.showInvalidEmailAlert(on: self)
            return
        }
       
        // Password check
        if !Validator.isPasswordValid(for: registerUserRequest.password) {
            AlertManager.showInvalidPasswordAlert(on: self)
            return
        }
       
        AuthService.shared.registerUser(with: registerUserRequest) { [weak self] wasRegistered, error in
            guard let self = self else { return }
           
            if let error = error {
                AlertManager.showRegistrationErrorAlert(on: self, with: error)
                return
            }
           
            if wasRegistered {
                if let sceneDelegate = self.view.window?.windowScene?.delegate as? SceneDelegate {
                    sceneDelegate.checkAuthentication()
                }
            } else {
                AlertManager.showRegistrationErrorAlert(on: self)
            }
        }
    }
   
    @objc private func didTapSignIn() {
        // Navigate back to LoginController
        self.navigationController?.popViewController(animated: false)  // No animation
    }
   
    @objc private func didTapBackToSignIn() {
        // Navigate directly to LoginController without animation
        self.navigationController?.popViewController(animated: false)
    }
}

extension RegisterController: UITextViewDelegate {
   
    func textView(_ textView: UITextView, shouldInteractWith URL: URL, in characterRange: NSRange, interaction: UITextItemInteraction) -> Bool {
       
        if URL.scheme == "terms" {
            self.showWebViewerController(with: "https://policies.google.com/terms?hl=en")
        } else if URL.scheme == "privacy" {
            self.showWebViewerController(with: "https://policies.google.com/privacy?hl=en")
        }
       
        return true
    }
   
    private func showWebViewerController(with urlString: String) {
        let vc = WebViewerController(with: urlString)
        let nav = UINavigationController(rootViewController: vc)
        self.present(nav, animated: true, completion: nil)
    }
   
    func textViewDidChangeSelection(_ textView: UITextView) {
        textView.delegate = nil
        textView.selectedTextRange = nil
        textView.delegate = self
    }
}

