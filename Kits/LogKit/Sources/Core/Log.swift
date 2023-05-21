// swiftlint:disable wrong_use_of_current_date

import Foundation


/**
 Represents a log message.
 
 Uses:
 
 Log.debug {
    Log.message("My message").attachInfo(obj)
 }
 
 */
internal final class Log {
    
    // MARK: - Internal properties
    
    /// Message.
    internal let message: String
    /// Timestamp
    internal let date: Date
    /// Name of the file the log was created in.
    internal let fileName: String
    /// Name of a function the log was created in.
    internal let functionName: String
    /// Line number the log was created at.
    internal let lineNumber: UInt
    /// Custom info associated with the log message.
    internal private(set) var customInfo: Any?
    
    
    // MARK: - Initialization
    
    /// Private init
    private init(message: String, date: Date, fileName: String, functionName: String, lineNumber: UInt) {
        self.message = message
        self.date = date
        self.fileName = fileName
        self.functionName = functionName
        self.lineNumber = lineNumber
    }
    
    
    // MARK: Internal methods
    
    /// Logs given closure with `info` level.
    internal static func info(_ block: () -> Log) {
        log(.info, block)
    }
    
    /// Logs given closure with `warning` level.
    internal static func warning(_ block: () -> Log) {
        log(.warning, block)
    }
    
    /// Logs given closure with `error` level.
    internal static func error(_ block: () -> Log) {
        log(.error, block)
    }
    
    /// Logs given closure with `debug` level.
    internal static func debug(_ block: () -> Log) {
        log(.debug, block)
    }
    
    /// Logs given closure with `verbose` level.
    internal static func verbose(_ block: () -> Log) {
        log(.verbose, block)
    }
    
    /// Logs given closure.
    internal static func log(_ level: LogLevel, _ block: () -> Log) {
        Logger.shared.log(level, block)
    }
    
    /// Creates a log with given message.
    internal static func message(
        _ msg: String,
        fileName: String = #file,
        functionName: String = #function,
        lineNumber: UInt = #line
    ) -> Log {
        Log(message: msg, date: Date(), fileName: fileName, functionName: functionName, lineNumber: lineNumber)
    }
    
    /// Attaches a custom object to this message. Note: only one object can be attached.
    internal func attachInfo(_ obj: Any?) -> Log {
        customInfo = obj.flatMap { $0 }
        return self
    }
}
