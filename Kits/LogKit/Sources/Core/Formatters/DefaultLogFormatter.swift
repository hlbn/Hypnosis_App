// swiftlint:disable wrong_use_of_current_date force_unwrapping

import Foundation


/**
 Represents a default log formatter.
 */
internal class DefaultLogFormatter: LogFormatterType {
    
    // MARK: - Internal properties
    
    /// Date formatter used for logging.
    internal let dateFormatter: DateFormatter?
    
    
    // MARK: - Initialization
    
    /// Default initializer, uses `en_US_POSIX` locale date formatting.
    internal init() {
        dateFormatter = DateFormatter()
        dateFormatter!.locale = Locale(identifier: "en_US_POSIX")
        dateFormatter!.dateFormat = "yyyy-MM-dd HH:mm:ss.SSS Z"
    }
    
    /// Creates a new instance with given `DateFormatter`.
    internal init(dateFormatter: DateFormatter? = nil) {
        self.dateFormatter = dateFormatter
    }
    
    
    // MARK: - LogFormatterType
    
    /// Creates a message with given debug level from `Log`.
    /// If no date formatter is present, leaves out the `date`.
    /// Outputs someting like this: "[Level 📋] [AppDelegate.swift:37] My message".
    internal final func createMessage(from log: Log, level: LogLevel) -> String {
        createLogMessage(
            timestamp: formatTimestamp(log.date),
            level: formatLevel(level),
            fileName: formatFileName(log.fileName),
            functionName: level <= .verbose ? formatFunctionName(log.functionName) : nil,
            lineNumber: formatLineNumber(log.lineNumber),
            message: formatMessage(log.message),
            customInfo: formatCustomInfo(log.customInfo)
        )
    }
    
    // swiftlint:disable:next function_parameter_count
    internal func createLogMessage(
        timestamp: String?,
        level: String?,
        fileName: String?,
        functionName: String?,
        lineNumber: String?,
        message: String?,
        customInfo: String?
    ) -> String {
        var result = ""
        
        if let timestamp {
            result += timestamp
            result += " "
        }
        
        if let level {
            result += level
            result += " "
        }
        
        result += "["
        if let fileName {
            result += fileName
        }
        
        if let lineNumber {
            result += ":"
            result += lineNumber
        }
        
        if let functionName {
            if result.last != "[" {
                result += " "
            }
            result += functionName
        }
        result += "]"
        
        if let message {
            result += " "
            result += message
        }
        
        if let customInfo {
            result += customInfo
        }
        
        return result
    }
    
    internal func formatTimestamp(_ value: Date) -> String? {
        dateFormatter?.string(from: value)
    }
    
    internal func formatLevel(_ value: LogLevel) -> String? {
        value.description
    }
    
    internal func formatFileName(_ value: String) -> String? {
        let name = value.components(separatedBy: "/").last
        return name?.isEmpty == false ? name : nil
    }
    
    internal func formatFunctionName(_ value: String) -> String? {
        !value.isEmpty ? value : nil
    }
    
    internal func formatLineNumber(_ value: UInt) -> String? {
        value != 0 ? value.description : nil
    }
    
    internal func formatMessage(_ value: String) -> String? {
        !value.isEmpty ? value : nil
    }
    
    internal func formatCustomInfo(_ value: Any?) -> String? {
        guard let value else {
            return nil
        }
        
        return descriptionFromCustomInfo(value)
    }
    
    /// Description for custom info object. Has special formatting for `Log*Type`s.
    internal func descriptionFromCustomInfo(_ info: Any) -> String {
        if let info = info as? LogInfoCustomMessageType {
            return info.customLogMessage
        }
        return "\n\(info)"
    }
}
