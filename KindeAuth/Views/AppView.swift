import SwiftUI
import KindeAuthSwift

struct AppView: View {
    @State private var isAuthenticated: Bool
    @State private var user: UserProfile?
    @State private var presentAlert = false
    @State private var alertMessage = ""
    
    private let logger: Logger?
    
    init() {
        self.logger = Logger()
        
        // The Kinde authentication service must be configured before use
        Auth.configure(logger: self.logger)
        
        // If the Kinde Management API is required, it must be configured before use
        KindeManagementApiClient.configure()
        
        _isAuthenticated = State(initialValue: Auth.isAuthorized())
    }
    
    var body: some View {
        return VStack {
            VStack {
                if self.isAuthenticated {
                    LoggedInView(user: self.$user, logger: self.logger, onLoggedOut: onLoggedOut)
                } else {
                    LoggedOutView(logger: self.logger, onLoggedIn: onLoggedIn)
                }
                FooterView()
            }.padding().frame(maxWidth: .infinity).onAppear {
                if isAuthenticated, user == nil {
                    // Fetch the user profile, which is not persisted
                    self.getUserProfile()
                }
            }
            .alert(isPresented: $presentAlert) {
                Alert(
                    title: Text("Error"),
                    message: Text(alertMessage)
                )
            }
        }
    }
}

struct AppView_Previews: PreviewProvider {
    static var previews: some View {
        AppView()
    }
}

extension AppView {
    
    func onLoggedIn() {
        self.isAuthenticated = true
        self.getUserProfile()
    }

    func onLoggedOut() {
        self.isAuthenticated = false
        self.user = nil
    }
    
    /// Get the current user's profile via the Kinde Management API
    private func getUserProfile() {
        Auth.performWithFreshTokens { tokens in
            switch tokens {
            case let .failure(error):
                alertMessage = "Failed to get access token: \(error.localizedDescription)"
                self.logger?.error(message: alertMessage)
                presentAlert = true
            case let .success(tokens):
                KindeManagementApiClient.getUser(accessToken: tokens.accessToken) { (userProfile, error) in
                    if let userProfile = userProfile {
                        self.user = userProfile
                        let userName = "\(userProfile.firstName ?? "") \(userProfile.lastName ?? "")"
                        self.logger?.info(message: "Got profile for user \(userName)")
                    }

                    if let error = error {
                        alertMessage = "Failed to get user profile: \(error.localizedDescription)"
                        self.logger?.error(message: alertMessage)
                        presentAlert = true
                    }
                }
            }
        }
    }
}
