import XCTest

// Test configuration
struct Config {
    // Add credentials for a registered user
    static let userEmail = "test_user@example.com"
    static let password = "P@ssword"
    static let name = "User"

    // App
    static let signInButtonLabel = "Sign In"
    static let signUpButtonLabel = "Sign Up"
    static let signOutButtonLabel = "Sign Out"

    static let signInContinueAlertButtonLabel = "Continue"
    
    static let signUpNextKeyboardButtonLabel = "Next"
    static let signUpDoneKeyboardButtonLabel = "Done"

    // OpenID Connect User Agent
    static let signInCancelButtonLabel = "Cancel"
    static let signInContinueButtonLabel = "Continue"
    static let signUpRegisterButtonLabel = "Register"
    
    static let uiElementWaitTimeout = 10.0
}

class KindeAuthUITests: XCTestCase {

    override func setUp() {
        continueAfterFailure = false
        let app = XCUIApplication()
        app.launch()
    }
    
    func testSignInAndSignOut() {
        // Sign in
        waitThenTapButton(button: Config.signInButtonLabel)
        waitThenTapAlertButton(button: Config.signInContinueAlertButtonLabel)
        
        let app = XCUIApplication()
        // User ID is assumed to be the first text field
        let userIdInput = app.webViews.textFields.firstMatch
        XCTAssertTrue(userIdInput.waitForExistence(timeout: Config.uiElementWaitTimeout))
        userIdInput.tap()
        userIdInput.typeText("\(Config.userEmail)\n")
        
        // Password is assumed to be the first secure text field
        let passwordInput = app.webViews.secureTextFields.firstMatch
        passwordInput.tap()
        passwordInput.typeText(Config.password)
        
        // Complete login
        waitThenTapButton(button: Config.signInContinueButtonLabel)
        
        // Sign out
        waitThenTapButton(button: Config.signOutButtonLabel)
    }
    
    func testSignUpAndSignOut() {
        // Sign up with existed user
        waitThenTapButton(button: Config.signUpButtonLabel)
        waitThenTapAlertButton(button: Config.signInContinueAlertButtonLabel)
        
        let app = XCUIApplication()
        // First Name is assumed to be the first text field
        let userFirstName = app.webViews.textFields.firstMatch
        XCTAssertTrue(userFirstName.waitForExistence(timeout: Config.uiElementWaitTimeout))
        userFirstName.tap()
        userFirstName.typeText("\(Config.name)")
        
        waitThenTapButton(button: Config.signUpNextKeyboardButtonLabel)
        // Last Name is assumed to be the first text field
        app.typeText("\(Config.name)")

        waitThenTapButton(button: Config.signUpNextKeyboardButtonLabel)
        // Email is assumed to be the first text field
        app.typeText("\(Config.userEmail)")

        waitThenTapButton(button: Config.signUpDoneKeyboardButtonLabel)
        
        // Register
        waitThenTapButton(button: Config.signUpRegisterButtonLabel)
        
        // Password is assumed to be the first secure text field
        let passwordInput = app.webViews.secureTextFields.firstMatch
        passwordInput.tap()
        passwordInput.typeText(Config.password)
        waitThenTapButton(button: Config.signUpDoneKeyboardButtonLabel)
        // Complete register
        waitThenTapButton(button: Config.signInContinueButtonLabel)
        
        // Sign out
        waitThenTapButton(button: Config.signOutButtonLabel)
    }

    func testSignInCancellation() {
        waitThenTapButton(button: Config.signInButtonLabel)
        waitThenTapAlertButton(button: Config.signInCancelButtonLabel)
        
        // Confirm the Sign In button is visible after cancellation
        let signInButton = XCUIApplication().buttons[Config.signInButtonLabel]
        XCTAssertTrue(signInButton.waitForExistence(timeout: Config.uiElementWaitTimeout))
    }
    
    func testMakeAuthenticatedRequest() {
        // Sign in
        waitThenTapButton(button: Config.signInButtonLabel)
        waitThenTapAlertButton(button: Config.signInContinueAlertButtonLabel)
        
        let app = XCUIApplication()
        // User ID is assumed to be the first text field
        let userIdInput = app.webViews.textFields.firstMatch
        XCTAssertTrue(userIdInput.waitForExistence(timeout: Config.uiElementWaitTimeout))
        userIdInput.tap()
        userIdInput.typeText("\(Config.userEmail)\n")
        
        // Password is assumed to be the first secure text field
        let passwordInput = app.webViews.secureTextFields.firstMatch
        XCTAssertTrue(passwordInput.waitForExistence(timeout: Config.uiElementWaitTimeout))
        passwordInput.tap()
        passwordInput.typeText(Config.password)
                
        waitThenTapButton(button: Config.signInContinueButtonLabel)
                
        // Sign out
        waitThenTapButton(button: Config.signOutButtonLabel)
    }
}

private extension KindeAuthUITests {
    /// Wait for an app button to appear and tap it
    func waitThenTapButton(button label: String) {
        let button = XCUIApplication().buttons[label]
        XCTAssertTrue(button.waitForExistence(timeout: Config.uiElementWaitTimeout))
        button.tap()
    }

    /// Wait for a button on the system Alert to appear and tap it
    func waitThenTapAlertButton(button label: String) {
        let alertButton = XCUIApplication(bundleIdentifier: "com.apple.springboard").buttons[label]
        XCTAssertTrue(alertButton.waitForExistence(timeout: Config.uiElementWaitTimeout))
        alertButton.tap()
    }
}
