import Quick
import Nimble
import Mockingbird
import KindeSDK
import AppAuth
import KindeAuth

class AuthSpec: QuickSpec {
    override func spec() {
        
        describe("Auth") {
            
            it("is unauthorised after initialisation") {
                KindeSDKAPI.configure()
                expect(KindeSDKAPI.auth.isAuthorized()) == false
            }
            
            it("check helper functions") {
                let auth: Auth = KindeSDKAPI.auth
                guard auth.isAuthorized() == true else { return }
                let userDetails: User? = auth.getUserDetails()
                expect(userDetails?.id).to(beGreaterThan(0))
                
                let audClaim = auth.getClaim(key: "aud")
                expect(audClaim).notTo(beNil())
                
                let permissions = auth.getPermissions()
                expect(permissions).notTo(beNil())
                
                let organization = auth.getOrganization()
                expect(organization).notTo(beNil())
                
                let userOrganizations = auth.getUserOrganizations()
                expect(userOrganizations).notTo(beNil())
            }
        }
    }
}
