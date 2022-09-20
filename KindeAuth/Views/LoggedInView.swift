import SwiftUI
import KindeAuthSwift

struct LoggedInView: View {
    @Binding var user: UserProfile?
    @State private var presentAlert = false
    @State private var alertMessage = ""

    private let logger: Logger?
    private let onLoggedOut: () -> Void

    init(user: Binding<UserProfile?>, logger: Logger?, onLoggedOut: @escaping () -> Void) {
        self.logger = logger
        self.onLoggedOut = onLoggedOut
        _user = user
    }
    
    var body: some View {
        VStack {
            HStack {
                Text("KindeAuth").font(.title)
                Spacer()
                Text("\(self.user?.firstName?.first?.uppercased() ?? "")\(self.user?.firstName?[1]?.uppercased() ?? "")").font(.title3).overlay(
                    Circle()
                    .stroke(Color.black, lineWidth: 4)
                    .padding(-6)
                ).padding(.trailing)
                Button("Sign Out", action: {
                    self.logout(viewController: self.getViewController())
                })
            }
        }
        .padding(.bottom)
        VStack {
            Spacer()
            Text("Woohoo!").font(.title3).foregroundColor(Color.white)
            Text("Your authentication is all sorted").font(.largeTitle).multilineTextAlignment(.center).foregroundColor(Color.white).padding()
            Text("Build the important stuff").font(.largeTitle).multilineTextAlignment(.center).foregroundColor(Color.white).multilineTextAlignment(.center).padding()
            Text("Next steps for you").foregroundColor(Color.white)
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

struct LoggedInView_Previews: PreviewProvider {
    static var previews: some View {
        LoggedInView(user: .constant(UserProfile(id: "id", preferredEmail: "bob@example.com", lastName: "Dylan", firstName: "Bob")), logger: nil) {}
    }
}

extension LoggedInView {
    func logout(viewController: UIViewController) {
        Auth.logout(viewController: viewController) { result in
            if result {
                self.onLoggedOut()
            } else {
                alertMessage = "Logout failed"
                self.logger?.error(message: alertMessage)
                presentAlert = true
            }
        }
    }
}
