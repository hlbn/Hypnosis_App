//

import Foundation


/**
 Implementing this protocol will allow the implemented to return its own
 custom message.
 */
internal protocol LogInfoCustomMessageType {
    
    /// Message that will be used when describing the receiver.
    var customLogMessage: String { get }
}
