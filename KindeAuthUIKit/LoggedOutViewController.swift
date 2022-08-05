import UIKit
import KindeAuthSwift

class ViewController: UIViewController {
    
    @IBAction func signIn(_ sender: Any) {
        Auth.login(viewController: self) { result in
            switch result {
            case let .failure(error):
                print("Login failed: \(error.localizedDescription)")
            case .success:
                self.navigateToLoggedInView()
            }
        }
    }
    
    @IBAction func signUp(_ sender: Any) {
        Auth.register(viewController: self) { result in
            switch result {
            case let .failure(error):
                print("Registration failed: \(error.localizedDescription)")
            case .success:
                self.navigateToLoggedInView()
            }
        }
    }
    
    @IBAction func openDocs(_ sender: Any) {
        // TODO: update the doc link
        if let url = URL(string: "https://kinde.com/docs/sdks/nextjs-sdk") {
            UIApplication.shared.open(url)
        }
    }
    
    private func navigateToLoggedInView() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let loggedInViewController = storyboard.instantiateViewController(identifier: "logged_in_vc")
        
        (UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate)?.changeRootViewController(loggedInViewController)
    }
}

