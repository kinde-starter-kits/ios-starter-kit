import SwiftUI
import KindeSDK

struct LoggedOutView: View {
    @State private var presentAlert = false
    @State private var alertMessage = ""
    
    private let logger: Logger?
    private let onLoggedIn: () -> Void

    init(logger: Logger?, onLoggedIn: @escaping () -> Void) {
        self.logger = logger
        self.onLoggedIn = onLoggedIn
    }
    
    var body: some View {
        VStack {
            HStack {
                Text("KindeAuth").font(.title)
                Spacer()
                Button("Sign In", action: {
                    self.login(viewController: self.getViewController())
                })
                Button("Sign Up", action: {
                    self.register(viewController: self.getViewController())
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
        .alert(isPresented: $presentAlert) {
            Alert(
                title: Text("Error"),
                message: Text(alertMessage)
            )
        }
    }
    
    private func getViewController() -> UIViewController {
        let scene = UIApplication.shared.connectedScenes.first as? UIWindowScene
        return (scene?.windows.first?.rootViewController)!
    }
}

struct LoggedOutView_Previews: PreviewProvider {
    static var previews: some View {
        LoggedOutView(logger: nil) {}
    }
}

extension LoggedOutView {
    func register(viewController: UIViewController) {
        Auth.register(viewController: viewController) { result in
            switch result {
            case let .failure(error):
                if !Auth.isUserCancellationErrorCode(error) {
                    alertMessage = "Registration failed: \(error.localizedDescription)"
                    self.logger?.error(message: alertMessage)
                    presentAlert = true
                }
            case .success:
                self.onLoggedIn()
            }
        }
    }
    
    func login(viewController: UIViewController) {
        Auth.login(viewController: viewController) { result in
            switch result {
            case let .failure(error):
                if !Auth.isUserCancellationErrorCode(error) {
                    alertMessage = "Login failed: \(error.localizedDescription)"
                    self.logger?.error(message: alertMessage)
                    presentAlert = true
                }
            case .success:
                self.onLoggedIn()
            }
        }
    }
}
