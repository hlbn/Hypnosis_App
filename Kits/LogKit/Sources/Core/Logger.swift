//

import Foundation


/**
 Performs all logging operations asynchronously.
 
 Uses:
 
 *To enable logging:*
 
 Logger.shared.logLevel = .verbose
 
 
 *To add a log handler:*
 
 Logger.shared.add(handler: ConsoleLogHandler())
 
 */
internal final class Logger {
    
    static let shared = Logger()
    
    
    // MARK: - Internal properties
    
    /// Desired log level, used for filtering messages. Defaults to `.none`.
    internal var logLevel: LogLevel = .none
    
    
    // MARK: - Private properties
    
    /// Queue used for logging so it happens outside the main thread.
    private let queue = DispatchQueue(label: "cz.eman.utilities.loggerQueue")
    
    /// Log handlers to forward `Log` messages to.
    private var handlers: [LogHandlerType] = []
    
    
    // MARK: Internal methods
    
    /// Registers given handler.
    internal func add(handler: LogHandlerType) {
        queue.async { [weak self] in
            self?.handlers.append(handler)
        }
    }
    
    /// Registers given handlers.
    internal func add(handlers: [LogHandlerType]) {
        queue.async { [weak self] in
            self?.handlers.append(contentsOf: handlers)
        }
    }
    
    /// Returns a log with given identifier if any exists.
    internal func handler(withIdentifier: String) -> LogHandlerType? {
        var result: LogHandlerType?
        queue.sync {
            result = handlers.first { $0.identifier == withIdentifier }
        }
        return result
    }
    
    /// Asynchronously logs given work on desired level.
    internal func log(_ level: LogLevel, _ stuff: () -> Log) {
        guard isLoggable(level) else {
            return
        }
        
        let dataToLog = stuff()
        queue.async { [weak self] in
            guard let handlers = self?.handlers, !handlers.isEmpty else {
                return
            }
            handlers.forEach {
                $0.handle(log: dataToLog, level: level)
            }
        }
    }
    
    /// Checks if passed `level` is logged or ignored
    internal func isLoggable(_ level: LogLevel) -> Bool {
        if logLevel == .none {
            return false
        }
        
        return logLevel <= level
    }
}
