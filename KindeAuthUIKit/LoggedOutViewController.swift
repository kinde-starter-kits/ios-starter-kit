import UIKit
import KindeSDK

class ViewController: UIViewController {
    
    @IBAction func signIn(_ sender: Any) {
        Auth.login(viewController: self) { result in
            switch result {
            case let .failure(error):
                if !Auth.isUserCancellationErrorCode(error) {
                    alert(message: "Login failed: \(error.localizedDescription)", viewController: self)
                }
            case .success:
                self.navigateToLoggedInView()
            }
        }
    }
    
    @IBAction func signUp(_ sender: Any) {
        Auth.register(viewController: self) { result in
            switch result {
            case let .failure(error):
                if !Auth.isUserCancellationErrorCode(error) {
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
