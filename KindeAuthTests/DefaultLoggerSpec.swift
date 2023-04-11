import Quick
import Nimble
import KindeSDK

class MockLogger: LoggerProtocol {
    var receivedMessage: String?

    func debug(message: String) {
        receivedMessage = message
    }
    
    func info(message: String) {
        receivedMessage = message
    }
    
    func error(message: String) {
        receivedMessage = message
    }
    
    func fault(message: String) {
        receivedMessage = message
    }
}

class DefaultLoggerSpec: QuickSpec {
    override func spec() {
        describe("DefaultLogger") {

            it("can successfully receive debug message") {
                let defaultLogger: MockLogger = MockLogger()
                defaultLogger.debug(message: "debug")
                expect(defaultLogger.receivedMessage).to(equal("debug"))
            }
            
            it("can successfully receive info message") {
                let defaultLogger: MockLogger = MockLogger()
                defaultLogger.debug(message: "info")
                expect(defaultLogger.receivedMessage).to(equal("info"))
            }
            
            it("can successfully receive error message") {
                let defaultLogger: MockLogger = MockLogger()
                defaultLogger.debug(message: "error")
                expect(defaultLogger.receivedMessage).to(equal("error"))
            }

            it("can successfully receive fault message") {
                let defaultLogger: MockLogger = MockLogger()
                defaultLogger.debug(message: "fault")
                expect(defaultLogger.receivedMessage).to(equal("fault"))
            }
        }
    }
}
