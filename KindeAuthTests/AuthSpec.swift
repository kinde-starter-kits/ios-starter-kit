import Quick
import Nimble
import Mockingbird
import KindeSDK
import AppAuth
import KindeAuth

class AuthSpec: QuickSpec {
    override class func spec() {
        describe("Auth") {
            it("is unauthorised after initialisation") {
                KindeSDKAPI.configure()
                expect(KindeSDKAPI.auth.isAuthorized()) == false
            }
            
            it("get access token") {
                Task {
                    let auth: Auth = KindeSDKAPI.auth
                    guard auth.isAuthorized() == true else { return }
                    let accessToken = try? await KindeSDKAPI.auth.getToken()
                    expect( accessToken ).notTo(beNil())
                }
            }
            
            it("check helper functions") {
                let auth: Auth = KindeSDKAPI.auth
                guard auth.isAuthorized() == true else { return }
                let userDetails: User? = auth.getUserDetails()
                expect(userDetails?.id.count).to(beGreaterThan(0))
                
                let audClaim = auth.getClaim(forKey: "aud")
                expect(audClaim).notTo(beNil())
                
                let permissions = auth.getPermissions()
                expect(permissions).notTo(beNil())
                
                let organization = auth.getOrganization()
                expect(organization).notTo(beNil())
                
                let userOrganizations = auth.getUserOrganizations()
                expect(userOrganizations).notTo(beNil())
                
                // Feature Flags
                let testFlagCode = "#__testFlagCode__#"
                
                let flagNotExistGetDefaultValue = try? auth.getFlag(code: testFlagCode, defaultValue: testFlagCode).value as? String
                expect(flagNotExistGetDefaultValue).to(equal(testFlagCode))
                expect( try auth.getFlag(code: testFlagCode) )
                    .to( throwError(FlagError.notFound) )
                
                let flagBoolNotExistGetNil = try? auth.getBooleanFlag(code: testFlagCode)
                expect(flagBoolNotExistGetNil).to(beNil())
                expect( try auth.getBooleanFlag(code: testFlagCode) )
                    .to( throwError(FlagError.notFound ) )
                
                let flagBoolNotExistGetDefaultValue = try? auth.getBooleanFlag(code: testFlagCode, defaultValue: true)
                expect(flagBoolNotExistGetDefaultValue).to(equal(true))
                expect( try auth.getBooleanFlag(code: testFlagCode, defaultValue: true) )
                    .to( equal(true) )

                let flagStringNotExistGetNil = try? auth.getStringFlag(code: testFlagCode)
                expect(flagStringNotExistGetNil).to(beNil())
                expect( try auth.getStringFlag(code: testFlagCode) )
                    .to( throwError(FlagError.notFound) )

                let flagStringNotExistGetDefaultValue = try? auth.getStringFlag(code: testFlagCode, defaultValue: testFlagCode)
                expect(flagStringNotExistGetDefaultValue).to(equal(testFlagCode))
                expect( try auth.getStringFlag(code: testFlagCode, defaultValue: testFlagCode) )
                    .to( equal(testFlagCode) )
                
                let flagIntNotExistGetNil = try? auth.getIntegerFlag(code: testFlagCode)
                expect(flagIntNotExistGetNil).to(beNil())
                expect( try auth.getIntegerFlag(code: testFlagCode) )
                    .to( throwError(FlagError.notFound) )

                let flagIntNotExistGetDefaultValue = try? auth.getIntegerFlag(code: testFlagCode, defaultValue: 1)
                expect(flagIntNotExistGetDefaultValue).to(equal(1))
                expect( try auth.getIntegerFlag(code: testFlagCode, defaultValue: 1) )
                    .to( equal(1) )
            }
            
            it("check logout functions") {
                let auth: Auth = KindeSDKAPI.auth
                Task {
                    guard auth.isAuthorized() == true else { return }
                    
                    let result = await auth.logout()
                    if result == true {
                        expect(auth.isAuthorized()).to(beFalse())
                    }
                }
            }
        }
    }
}
