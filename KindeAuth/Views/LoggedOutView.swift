import SwiftUI
import KindeSDK

struct LoggedOutView: View {
    @State private var presentAlert = false
    @State private var alertMessage = ""
    
    private let logger: Logger?
    private let onLoggedIn: () -> Void
    private let auth: Auth = KindeSDKAPI.auth

    init(logger: Logger?, onLoggedIn: @escaping () -> Void) {
        self.logger = logger
        self.onLoggedIn = onLoggedIn
    }
    
    var body: some View {
        VStack {
            VStack {
                HStack {
                    Text("KindeAuth").font(.title)
                    Spacer()
                    Button("Sign In", action: {
                        self.login()
                    })
                    Button("Sign Up", action: {
                        self.register()
                    })
                }
            }
            .padding(.bottom)
            VStack {
                Spacer()
                Text("Let’s start authenticating with KindeAuth").font(.largeTitle).multilineTextAlignment(.center).foregroundColor(Color.white).padding()
                Text("Configure your app").font(.title3).multilineTextAlignment(.center).foregroundColor(Color.white).padding()
                Link("Go to docs", destination: URL(string: "https://kinde.com/docs/sdks/swift-sdk")!)
                Spacer()
            }
            .frame(maxWidth: .infinity)
            .background(.black)
            .cornerRadius(20)
            .overlay(
                RoundedRectangle(cornerRadius: 20)
                    .stroke(.black, lineWidth: 5)
            )
        }
        .alert(Text("Error"), isPresented: $presentAlert) {
            Button("OK") {
                presentAlert = false
            }
        } message: {
            Text(alertMessage)
        }
    }
}

struct LoggedOutView_Previews: PreviewProvider {
    static var previews: some View {
        LoggedOutView(logger: nil) {}
    }
}

extension LoggedOutView {
    func register() {
        auth.enablePrivateAuthSession(true)
        auth.register { result in
            switch result {
            case let .failure(error):
                if !auth.isUserCancellationErrorCode(error) {
                    alertMessage = "Registration failed: \(error.localizedDescription)"
                    self.logger?.error(message: alertMessage)
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                        presentAlert = true
                    }
                }
            case .success:
                self.onLoggedIn()
            }
        }
    }
    
    func login() {
        auth.enablePrivateAuthSession(true)
        auth.login { result in
            switch result {
            case let .failure(error):
                if !auth.isUserCancellationErrorCode(error) {
                    alertMessage = "Login failed: \(error.localizedDescription)"
                    self.logger?.error(message: alertMessage)
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                        presentAlert = true
                    }
                }
            case .success:
                self.onLoggedIn()
            }
        }
    }
}
