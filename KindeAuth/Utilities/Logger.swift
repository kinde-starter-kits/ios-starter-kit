import os.log
import KindeAuthSwift

struct Logger: KindeAuthSwift.Logger {
    func debug(message: String) {
        os_log("%s", type: .debug, message)
    }
    
    func info(message: String) {
        os_log("%s", type: .info, message)
    }
    
    func error(message: String) {
        os_log("%s", type: .error, message)
    }

    func fault(message: String) {
        os_log("%s", type: .fault, message)
    }
}
