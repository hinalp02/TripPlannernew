import UIKit
import SwiftUI
import FirebaseAuth

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        self.setupWindow(with: scene)
        self.showIntroScreen()
    }
    
    private func setupWindow(with scene: UIScene) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        let window = UIWindow(windowScene: windowScene)
        self.window = window
        self.window?.makeKeyAndVisible()
    }

    private func showIntroScreen() {
        let introController = IntroController()
        self.goToController(with: introController)
    }
    
    public func checkAuthentication() {
        if Auth.auth().currentUser == nil {
            // If the user is not authenticated, show the LoginController
            self.goToController(with: LoginController())
        } else {
            // If the user is authenticated, show the SecondView
            self.showSecondView()
        }
    }
    
    private func goToController(with viewController: UIViewController) {
        DispatchQueue.main.async { [weak self] in
            UIView.animate(withDuration: 0.0) {
                self?.window?.layer.opacity = 0
            } completion: { [weak self] _ in
                let nav = UINavigationController(rootViewController: viewController)
                nav.modalPresentationStyle = .fullScreen
                self?.window?.rootViewController = nav
                
                UIView.animate(withDuration: 0.0) {
                    self?.window?.layer.opacity = 1
                }
            }
        }
    }
    
    private func showSecondView() {
        DispatchQueue.main.async { [weak self] in
            if let user = Auth.auth().currentUser {
                let userUID = user.uid

                UIView.animate(withDuration: 0.0) {
                    self?.window?.layer.opacity = 0
                } completion: { [weak self] _ in

                    let mainView = MainView(userUID: userUID)
                    
                    let mainViewController = UIHostingController(rootView: mainView)

                    //self?.window?.rootViewController = mainViewController
                    
                    let navController = UINavigationController(rootViewController: mainViewController)
                    self?.window?.rootViewController = navController

                    UIView.animate(withDuration: 0.0) {
                        self?.window?.layer.opacity = 1
                    }
                }
            } else {

                self?.goToController(with: LoginController())
            }
        }
    }


}
