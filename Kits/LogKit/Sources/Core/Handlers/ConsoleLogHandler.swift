//

import Foundation
import os


/**
 Log handler that logs given `Log` messages into console.
 */
internal final class ConsoleLogHandler: LogHandlerType {
    
    // MARK: - Internal properties
    
    internal var identifier: String
    internal let formatter: LogFormatterType
    
    
    // MARK: - Initialization
    
    /// Creates a new instance with given log formatter.
    internal init(formatter: LogFormatterType = ConsoleLogFormatter(dateFormatter: nil), identifier: String = UUID().uuidString) {
        self.identifier = identifier
        self.formatter = formatter
    }
    
    
    // MARK: - Handling the logs
    
    internal func handle(log: Log, level: LogLevel) {
        let message = formatter.createMessage(from: log, level: level)
        let subsystem = Bundle.main.bundleIdentifier ?? "cz.eman.utilities.console-logger"
        let osLog = OSLog(subsystem: subsystem, category: level.description)
        os_log("%{public}@", log: osLog, type: level.osLogType, message)
    }
}
