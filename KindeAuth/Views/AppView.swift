import SwiftUI
import KindeSDK

struct AppView: View {
    @State private var isAuthenticated: Bool
    @State private var user: UserProfile?
    @State private var presentAlert = false
    @State private var alertMessage = ""
    
    private let logger: Logger?
    
    init() {
        self.logger = Logger()
        
        // The Kinde authentication service must be configured before use
        KindeSDKAPI.configure(self.logger ?? DefaultLogger())
        
        _isAuthenticated = State(initialValue: KindeSDKAPI.auth.isAuthorized())
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
        Task {
            await asyncGetUserProfile()
        }
    }
    
    private func asyncGetUserProfile() async -> Bool {
        do {
            let userProfile = try await OAuthAPI.getUser()
            self.user = userProfile
            let userName = "\(userProfile.givenName ?? "") \(userProfile.familyName ?? "")"
            self.logger?.info(message: "Got profile for user \(userName)")
            return true
        } catch {
            alertMessage = "Failed to get user profile: \(error.localizedDescription)"
            self.logger?.error(message: alertMessage)
            presentAlert = true
            return false
        }
    }
}
