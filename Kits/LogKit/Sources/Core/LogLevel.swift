//

import Foundation
import os.log


/**
 Log levels.
 */
public enum LogLevel: Int {
    
    case none    /// Logging is disabled.
    case verbose /// Logs messages up to `verbose` level - very verbose, including functions names.
    case debug   /// Logs messages up to `debug` level.
    case info    /// Logs messages up to `info` level.
    case warning /// Logs messages up to `warning` level.
    case error   /// Logs messages up to `error` level.
    
    
    public static func <= (lhs: LogLevel, rhs: LogLevel) -> Bool {
        lhs.rawValue <= rhs.rawValue
    }
    
    public static func >= (lhs: LogLevel, rhs: LogLevel) -> Bool {
        lhs.rawValue >= rhs.rawValue
    }
    
    public static func == (lhs: LogLevel, rhs: LogLevel) -> Bool {
        lhs.rawValue == rhs.rawValue
    }
    
}


// MARK: - CustomStringConvertible

extension LogLevel: CustomStringConvertible {
    
    public var description: String {
        switch self {
        case .none:     return ""
        case .info:     return "💬"
        case .warning:  return "⚠️"
        case .error:    return "⛔"
        case .debug:    return "🛠"
        case .verbose:  return "📋"
        }
    }
    
}


// MARK: - CustomDebugStringConvertible

extension LogLevel: CustomDebugStringConvertible {
    
    public var debugDescription: String {
        "Log level \(rawValue): \(description)"
    }
    
}



// MARK: - OSLogType conversion

internal extension LogLevel {
    
    var osLogType: OSLogType {
        switch self {
        case .none:     return .default
        case .info:     return .info
        case .warning:  return .error
        case .error:    return .fault
        case .debug:    return .debug
        case .verbose:  return .debug
        }
    }
}
