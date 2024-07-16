import UIKit
import KindeSDK

class ViewController: UIViewController {
    private let auth: Auth = KindeSDKAPI.auth
    private let hintEmail = "test@test.com"

    @IBAction func signIn(_ sender: Any) {
        auth.login(loginHint: hintEmail) { result in
            switch result {
            case let .failure(error):
                if !self.auth.isUserCancellationErrorCode(error) {
                    alert(message: "Login failed: \(error.localizedDescription)", viewController: self)
                }
            case .success:
                self.navigateToLoggedInView()
            }
        }
    }
    
    @IBAction func signUp(_ sender: Any) {
        auth.register(loginHint: hintEmail) { result in
            switch result {
            case let .failure(error):
                if !self.auth.isUserCancellationErrorCode(error) {
                    alert(message: "Registration failed: \(error.localizedDescription)", viewController: self)
                }
            case .success:
                self.navigateToLoggedInView()
            }
        }
    }
    
    @IBAction func openDocs(_ sender: Any) {
        if let url = URL(string: "https://kinde.com/docs/sdks/swift-sdk") {
            UIApplication.shared.open(url)
        }
    }
    
    private func navigateToLoggedInView() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let loggedInViewController = storyboard.instantiateViewController(identifier: "logged_in_vc")
        
        (UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate)?.changeRootViewController(loggedInViewController)
    }
}
