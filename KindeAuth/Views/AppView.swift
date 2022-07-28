import SwiftUI
import KindeAuthSwift

struct AppView: View {
    @State private var isAuthenticated: Bool
    @State private var user: UserProfile?
    
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
            }.padding().frame(maxWidth: .infinity)
            
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
        
        // Get the current user's profile via the Kinde Management API
        // We could also fetch the user profile using the discovered endpoint, if it exists
        Auth.performWithFreshTokens { tokenResult in
            switch tokenResult {
            case let .failure(error):
                self.logger?.error(message: "Failed to get auth token: \(error.localizedDescription)")
            case let .success(accessToken):
                self.logger?.debug(message: "Calling the Kinde Management API...")
                KindeManagementApiClient.getUser(accessToken: accessToken) { (userProfile, error) in
                    self.user = userProfile
                    
                    if let error = error {
                        self.logger?.error(message: "Failed to get user profile: \(error.localizedDescription)")
                    }
                }
            }
        }
        
        // Get all users via the Kinde Management API and log them to the console
        Auth.performWithFreshTokens { tokenResult in
            switch tokenResult {
            case let .failure(error):
                self.logger?.error(message: "Failed to get auth token: \(error.localizedDescription)")
            case let .success(accessToken):
                self.logger?.debug(message: "Calling the Kinde Management API...")
                KindeManagementApiClient.getUsers(sort: UsersAPI.Sort_getUsers.nameAsc, pageSize: 100, userId: nil, nextToken: nil, accessToken: accessToken) { (response, error) in
                    
                    if let response = response, let users = response.users {
                        for user in users {
                            self.logger?.info(message: "\(String(describing: user))")
                        }
                    }
                    
                    if let error = error {
                        self.logger?.error(message: "Failed to get users: \(error.localizedDescription)")
                    }
                }
            }
        }
    }

    func onLoggedOut() {
        self.isAuthenticated = false
        self.user = nil
    }
}
