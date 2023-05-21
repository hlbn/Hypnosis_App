//

import Foundation


extension URLRequest: LogInfoCustomMessageType {
    
    internal var customLogMessage: String {
        let bodyContent: String
        if let data = httpBody, let body = String(data: data, encoding: .utf8) {
            bodyContent = body
        } else {
            bodyContent = "-none-"
        }
        
        return """
        
        ----> REQUEST
        METHOD:  \(httpMethod ?? "-none-")
        URL:     \(url?.absoluteString ?? "-none-")
        HEADERS: \(allHTTPHeaderFields ?? [:])
        BODY:    \(bodyContent)
        """
    }
}
