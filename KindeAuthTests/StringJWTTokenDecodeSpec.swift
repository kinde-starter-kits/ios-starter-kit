import Quick
import Nimble
import KindeSDK

class StringJWTTokenDecodeSpec: QuickSpec {
    override class func spec() {
        describe("Config") {

            it("can parse a valid jwt token") {
                let exampleToken: String = "eyJhbGciOiJSUzI1NiIsImtpZCI6IjJjOjA3OjI0OmRmOjExOjUxOjRjOjI5OmY5OjlmOjEyOjc0OmMxOjM4OjRiOjU3IiwidHlwIjoiSldUIn0.eyJhdF9oYXNoIjoidGE0SjY4UVhBbmk2cm8yeEtyQzhtdyIsImF1ZCI6WyJodHRwczovL2RhdGFyb2NrZXRzLmtpbmRlLmNvbSIsIjczZjNiMmIyZjk2ZDQ4NmVhMGZlZDliMzQ5YjU1ZjcyIl0sImF1dGhfdGltZSI6MTY4MDUzODUzNSwiYXpwIjoiNzNmM2IyYjJmOTZkNDg2ZWEwZmVkOWIzNDliNTVmNzIiLCJlbWFpbCI6InQueWFrc2hpbWJldG92YUBkYXRhcm9ja2V0cy5jb20iLCJleHAiOjE2ODA1NjAxMzUsImZhbWlseV9uYW1lIjoiWWFrc2hpbWJldG92YSIsImdpdmVuX25hbWUiOiJUYW56aWx5YSIsImlhdCI6MTY4MDUzODUzNiwiaXNzIjoiaHR0cHM6Ly9kYXRhcm9ja2V0cy5raW5kZS5jb20iLCJqdGkiOiJhMDg1MjQ0MC1kNTliLTQ2OGQtOTViZC02NDMwYTYxYjRiZDYiLCJuYW1lIjoiVGFuemlseWEgWWFrc2hpbWJldG92YSIsIm9yZ19jb2RlcyI6WyJvcmdfNzc1ZDhiMWQxYzYiXSwicGljdHVyZSI6bnVsbCwicmF0IjoxNjgwNTM4NTM1LCJzdWIiOiJrcDo4OTgwYTc0NTdhY2Q0ZGU1YjkzMWM5Njk3OTM0ODNmNCIsInVwZGF0ZWRfYXQiOjEuNjgwNTM4NTM1ZSswOX0.Zf0NLf0uCUIoBOOAhT98Ykev4f0JAt3UQZK2s1aztyPqvNKJj2WtjbENUCTsCuQ8dGgYhpjH8LyToZj2EggjgF2Mo-6vby4JdExmEmpqWqRtLMyxeX19cOPDrTVQk6NK7AKYm4IhMBo39eJU1SSky6OXnqc9ZsNFY9N4pku303Z6G0aljpPKShVQ1jRqfLEPq8bqOG_QlFgE215iehhaKeGgM6IMGZAqCGGVuRScXD82TXXDoEBb3ooSd6uCeGjAu5itvle3x7lv-9zMkLyYx9cgZf9XLI4F61zJnHvYP6FWmTDZHP7lbjwrkqBCKWBwSi4F9vgDrJSr3vAJFVcOWg"
                
                let jwtData = exampleToken.parsedJWT
                expect(jwtData).toNot(beNil())
            }
            
            it("unsuccessful jwt token parsing") {
                let exampleToken: String = ""
                
                let jwtData = exampleToken.parsedJWT
                expect(jwtData.isEmpty).to(beTrue())
            }
        }
    }
}
