//

import Foundation


/**
 Log handler protocol.
 */
internal protocol LogHandlerType {
    
    /// Unique of the handler.
    var identifier: String { get set }
    
    /// Formatter used for creating string messages from `Log` messages.
    var formatter: LogFormatterType { get }
    
    /// Handles given `Log` message. This function is called outside the main thread.
    func handle(log: Log, level: LogLevel)
}
