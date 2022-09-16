import UIKit
import KindeAuthSwift

class LoggedInViewController: UIViewController {
    @IBOutlet weak var userLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        Auth.performWithFreshTokens { tokens in
            switch tokens {
            case let .failure(error):
                alert(message: "Failed to get auth token: \(error.localizedDescription)", viewController: self)
            case let .success(tokens):
                KindeManagementApiClient.getUser(accessToken: tokens.accessToken) { (userProfile, error) in
                    if let userProfile = userProfile {
                        let userName = "\(userProfile.firstName ?? "") \(userProfile.lastName ?? "")"
                        print("Got profile for user \(userName)")
                        let userLabel = "\(userProfile.firstName?.first?.uppercased() ?? "")\(userProfile.firstName?[1]?.uppercased() ?? "")"
                        
                        self.userLabel.text = userLabel
                    }
                    if let error = error {
                        alert(message: "Failed to get user profile: \(error.localizedDescription)", viewController: self)
                    }
                }
            }
        }
    }
    
    @IBAction func signOut(_ sender: Any) {
        Auth.logout(viewController: self) { result in
            if result {
                let storyboard = UIStoryboard(name: "Main", bundle: nil)
                let loggedOutViewController = storyboard.instantiateViewController(identifier: "logged_out_vc")
                
                (UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate)?.changeRootViewController(loggedOutViewController)
                
            } else {
                alert(message: "Logout failed", viewController: self)
            }
        }
    }
}
