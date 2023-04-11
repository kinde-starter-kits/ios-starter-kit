import Quick
import Nimble
import KindeSDK

class AuthErrorSpec: QuickSpec {
    override func spec() {
        describe("AuthError") {

            it("can parse a configuration auth error") {
                let expectedError = "Failed to retrieve local or remote configuration."
                
                let error = AuthError.configuration
                
                expect(error.errorDescription).to(equal(expectedError))
            }
            
            it("can parse a notAuthenticated auth error") {
                let expectedError = "Failed to obtain valid authentication state."
                
                let error = AuthError.notAuthenticated
                
                expect(error.errorDescription).to(equal(expectedError))
            }
            
            it("can parse a notAuthenticated auth error") {
                let expectedError = "Failed to save authentication state on device."
                
                let error = AuthError.failedToSaveState
                
                expect(error.errorDescription).to(equal(expectedError))
            }
        }
    }
}
