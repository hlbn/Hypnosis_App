//

import Foundation


/**
 Protocol for formatting a `Log` messages.
 */
internal protocol LogFormatterType {
    
    /// Creates a message from given `Log` and `LogLevel`.
    func createMessage(from log: Log, level: LogLevel) -> String
    
}
