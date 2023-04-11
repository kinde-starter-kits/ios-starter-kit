import Quick
import Nimble
import KindeSDK

class AuthStateRepositorySpec: QuickSpec {
    override func spec() {
        describe("AuthStateRepository") {

            it("can successfully initialize authStateRepository") {
                let defaultLogger = DefaultLogger()
                
                let authStateRepository = AuthStateRepository(key: "\(Bundle.main.bundleIdentifier ?? "com.kinde.KindeAuth").authState", logger: defaultLogger)
                if authStateRepository.state?.isAuthorized == true {
                    expect(authStateRepository.state).notTo(beNil())
                }
            }
            
            it("check failed authStateRepository initialization") {
                let authStateRepository = AuthStateRepository(key: "", logger: nil)
                            
                expect(authStateRepository.state).to(beNil())
            }
            
            it("check clear action") {
                let defaultLogger = DefaultLogger()
                
                let authStateRepository = AuthStateRepository(key: "\(Bundle.main.bundleIdentifier ?? "com.kinde.KindeAuth").authState", logger: defaultLogger)
                if authStateRepository.state?.isAuthorized == true {
                    expect(authStateRepository.state).notTo(beNil())
                }
                
                let clearResult = authStateRepository.clear()
                expect(clearResult).to(beTrue())
                expect(authStateRepository.state).to(beNil())
            }
        }
    }
}
