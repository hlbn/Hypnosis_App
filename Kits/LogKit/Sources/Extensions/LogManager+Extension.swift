//

import Foundation


extension LogManager {
    
    /**
     Function for logging debug occasion with URL Request information
     - Parameters:
        - request: URL Request of function where is logging situated
        - message: Message which appear in log. Default value is empty string
     
     Debug logging is a mode that contains information that may be useful during development or while troubleshooting a specific problem.
     More over, this function can provide information of URL Request for detailed information.
     
     Message is empty string because it could be use just to specify occasion, main scope is the request.
     
     ### Usage Example: ###
     ```
     SDKManager.shared.logger.logDebug(request)
     ```
     */
    public static func logDebug(
        _ request: URLRequest,
        message: @autoclosure () -> String = "",
        fileName: String = #file,
        functionName: String = #function,
        lineNumber: UInt = #line
    ) {
        log(.debug, message(), fileName: fileName, functionName: functionName, lineNumber: lineNumber, data: request)
    }
    
    /**
     Function for logging debug occasion with URL Response information
     - Parameters:
        - response: URL Response of function where is logging situated
        - message: Message which appear in log. Default value is empty string
     
     Debug logging is a mode that contains information that may be useful during development or while troubleshooting a specific problem.
     More over, this function can provide information of URL Response for detailed information.
     
     Message is empty string because it could be use just to specify occasion, main scope is the response.
     
     ### Usage Example: ###
     ```
     SDKManager.shared.logger.logDebug(response)
     ```
     */
    public static func logDebug(
        _ response: HTTPURLResponse?,
        message: @autoclosure () -> String = "",
        fileName: String = #file,
        functionName: String = #function,
        lineNumber: UInt = #line
    ) {
        log(.debug, message(), fileName: fileName, functionName: functionName, lineNumber: lineNumber, data: response)
    }
    
    public static func logDebug(
        _ response: HTTPURLResponse?,
        data: Data?,
        message: @autoclosure () -> String = "",
        fileName: String = #file,
        functionName: String = #function,
        lineNumber: UInt = #line
    ) {
        var dataString = "-"
        if let data = data {
            dataString = String(data: data, encoding: .utf8) ?? "-"
        }
        
        let composedMessage = """
        
        <---- RESPONSE
        STATUS:  \(response?.statusCode ?? 0)
        URL:     \(response?.url?.absoluteString ?? "-none-")
        HEADERS: \(response?.allHeaderFields as? [String: Any] ?? [:])
        BODY: \(dataString)
        """
        
        log(.debug, composedMessage, fileName: fileName, functionName: functionName, lineNumber: lineNumber)
    }
    
    public static func logDebug(
        _ response: URLResponse?,
        data: Data?,
        message: @autoclosure () -> String = "",
        fileName: String = #file,
        functionName: String = #function,
        lineNumber: UInt = #line
    ) {
        var dataString = "-"
        if let data = data {
            dataString = String(data: data, encoding: .utf8) ?? "-"
        }
        
        let composedMessage = """
        
        <---- RESPONSE
        CONTENT:  \(response?.debugDescription ?? "URLResponse has no debugDescription")
        BODY: \(dataString)
        """
        
        log(.debug, composedMessage, fileName: fileName, functionName: functionName, lineNumber: lineNumber)
    }
}
