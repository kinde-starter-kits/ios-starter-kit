import UIKit
import KindeSDK

class LoggedInViewController: UIViewController {
    @IBOutlet weak var userLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        Task {
            await asyncGetUserProfile()
        }
    }
    
    private func asyncGetUserProfile() async -> Bool {
        do {
            let userProfile = try await OAuthAPI.getUser()
            let userName = "\(userProfile.givenName ?? "") \(userProfile.familyName ?? "")"
            print("Got profile for user \(userName)")
            let userLabel = "\(userProfile.givenName?.first?.uppercased() ?? "")\(userProfile.givenName?[1]?.uppercased() ?? "")"
            self.userLabel.text = userLabel
            return true
        } catch {
            alert(message: "Failed to get user profile: \(error.localizedDescription)", viewController: self)
            return false
        }
    }
    
    @IBAction func signOut(_ sender: Any) {
        KindeSDKAPI.auth.logout { result in
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
