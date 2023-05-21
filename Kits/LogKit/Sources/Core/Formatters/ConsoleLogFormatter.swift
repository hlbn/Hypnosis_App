//

import Foundation


/**
 Handles formatting for console-type outputs.
 */
internal final class ConsoleLogFormatter: DefaultLogFormatter {
    
    override func formatTimestamp(_ value: Date) -> String? {
        nil // skip
    }
    
    override func formatLevel(_ value: LogLevel) -> String? {
        nil // skip
    }
}
