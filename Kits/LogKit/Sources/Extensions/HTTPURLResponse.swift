//

import Foundation


extension HTTPURLResponse: LogInfoCustomMessageType {
    
    internal var customLogMessage: String {
        """
        
        <---- RESPONSE
        STATUS:  \(statusCode)
        URL:     \(url?.absoluteString ?? "-none-")
        HEADERS: \(allHeaderFields as? [String: Any] ?? [:])
        """
    }
}
