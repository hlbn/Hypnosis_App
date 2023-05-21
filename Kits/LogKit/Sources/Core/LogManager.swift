//

import Foundation


/// Class Manager for easier logging
public final class LogManager {
    
    // MARK: - Internal variables
    
    public static var logLevel: LogLevel {
        get {
            Logger.shared.logLevel
        }
        set {
            Logger.shared.logLevel = newValue
        }
    }
    
    
    // MARK: - Private variables
    
    private static var shared = LogManager()
    private var fileLogHandler: FileLogHandler?
    
    
    // MARK: - Setting up where to log
    
    public static func addConsoleLogHandler() {
        let consoleHandler = ConsoleLogHandler()
        Logger.shared.add(handler: consoleHandler)
    }
    
    public static func addFileLogHandler() {
        let fileHandler = FileLogHandler()
        Logger.shared.add(handler: fileHandler)
        shared.fileLogHandler = fileHandler
    }
    
    
    // MARK: - Logging Functions
    
    /**
     Function for logging verbose occasion.
     - Parameters:
        - message: Message which appear in log.
     
     Verbose logging is a logging mode that records more information than the usual logging mode.
     
     ### Usage Example: ###
     ```
     SDKManager.shared.logger.logVerbose("Response JSON: \(jsonObject)")
     ```
     */
    public static func logVerbose(
        _ message: @autoclosure () -> String,
        fileName: String = #file,
        functionName: String = #function,
        lineNumber: UInt = #line,
        data: Any? = nil
    ) {
        log(.verbose, message(), fileName: fileName, functionName: functionName, lineNumber: lineNumber, data: data)
    }
    
    /**
     Function for logging debug occasion.
     - Parameters:
        - message: Message which appear in log.
     
     Debug logging is a mode that contains information that may be useful during development or while troubleshooting a specific problem.
     
     ### Usage Example: ###
     ```
     SDKManager.shared.logger.logDebug("InitiatePairingVC will disappear")
     ```
     */
    public static func logDebug(
        _ message: @autoclosure () -> String,
        fileName: String = #file,
        functionName: String = #function,
        lineNumber: UInt = #line,
        data: Any? = nil
    ) {
        log(.debug, message(), fileName: fileName, functionName: functionName, lineNumber: lineNumber, data: data)
    }
    
    /**
     Function for logging info occasion
     - Parameters:
        - message: Message which appear in log.
     
     Info is used when you want to inform about something such as result of an operation, user interaction, etc.
     
     ### Usage Example: ###
     ```
     SDKManager.shared.logger.logInfo("Payment was successful")
     ```
     */
    public static func logInfo(
        _ message: @autoclosure () -> String,
        fileName: String = #file,
        functionName: String = #function,
        lineNumber: UInt = #line,
        data: Any? = nil
    ) {
        log(.info, message(), fileName: fileName, functionName: functionName, lineNumber: lineNumber, data: data)
    }
    
    /**
     Function for logging warning occasion
     - Parameters:
        - message: Message which appear in log.
     
     Warning is used in situation when you want to point out on something which is not error but should not been like that.
     
     ### Usage Example: ###
     ```
     SDKManager.shared.logger.logWarning("Request took \(endTime - startTime) s")
     ```
     */
    public static func logWarning(
        _ message: @autoclosure () -> String,
        fileName: String = #file,
        functionName: String = #function,
        lineNumber: UInt = #line,
        data: Any? = nil
    ) {
        log(.warning, message(), fileName: fileName, functionName: functionName, lineNumber: lineNumber, data: data)
    }
    
    /**
     Function for logging error occasion
     - Parameters:
        - message: Message which appear in log.
     
     Error is used in situation when happened something what should not.
     
     ### Usage Example: ###
     ```
     SDKManager.shared.logger.logError("Trying to dismiss VC, but no VC is presented!")
     ```
     */
    public static func logError(
        _ message: @autoclosure () -> String,
        fileName: String = #file,
        functionName: String = #function,
        lineNumber: UInt = #line,
        data: Any? = nil
    ) {
        log(.error, message(), fileName: fileName, functionName: functionName, lineNumber: lineNumber, data: data)
    }
    
    /**
     Function for logging occasion
     - Parameters:
        - level: Level of log
        - message: Message which appear in log.
        - data: Addition info / data that is appended to log
     
     ### Usage Example: ###
     ```swift
     SDKManager.shared.logger.log(.info, "Payment was successful")
     ```
     */
    public static func log(
        _ level: LogLevel,
        _ message: @autoclosure () -> String,
        fileName: String = #file,
        functionName: String = #function,
        lineNumber: UInt = #line,
        data: Any? = nil
    ) {
        Log.log(level) {
            Log.message(message(), fileName: fileName, functionName: functionName, lineNumber: lineNumber).attachInfo(data)
        }
    }
    
    
    // MARK: - Log Files Functions
    
    /**
     Function for retrieving all log files.
     
     Logger storing logs in 5 separate files, based on the day when log appear.
     This function retrieves those files for the possibility to send those logs e.g. via email.
     
     ### Usage Example: ###
     ```
     let files = SDKManager.shared.logger.allLogFiles()
     let activityVC = UIActivityViewController(activityItems: files, applicationActivities: nil)
     
     self.present(activityVC, animated: true, completion: nil)
     ```
     
     - Returns: URL addresses of required log files
     */
    public static func allLogFiles() -> [URL] {
        guard let fileLogHandler = shared.fileLogHandler else {
            logWarning("FileLogHandler not found!")
            return []
        }
        return fileLogHandler.allLogFiles()
    }
    
    public static func deleteAllLogFiles() {
        guard let fileLogHandler = shared.fileLogHandler else {
            logWarning("FileLogHandler not found!")
            return
        }
        fileLogHandler.deleteAllLogs()
    }
    
    
    // MARK: - Other Functions
    
    public static func isLoggable(_ level: LogLevel) -> Bool {
        Logger.shared.isLoggable(level)
    }
}
