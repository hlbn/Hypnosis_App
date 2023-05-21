// swiftlint:disable wrong_use_of_current_date

import Foundation


/**
 Log handler that logs given `Log` messages into files in user's documents directory.
 In documents directory, a new directory with name given in the initializer is created if needed.
 Maximum files is specified with given count and the handlers clears old logs automatically.
 */
internal final class FileLogHandler: LogHandlerType {
    
    // MARK: - Internal properties
    
    internal var identifier: String
    internal let formatter: LogFormatterType
    internal let logsDirectoryName: String
    internal let maxFiles: Int
    
    
    // MARK: - Private properties
    
    private var fileHandle: FileHandle?
    private var fileManager: FileManager = .default
    private var currentFileName: String {
        let comps = Calendar.current.dateComponents([.day, .month, .year], from: Date())
        return "\(comps.year ?? 0)-\(comps.month ?? 0)-\(comps.day ?? 0).log"
    }
    
    
    // MARK: - Initialization
    
    internal init(
        formatter: LogFormatterType = DefaultLogFormatter(),
        identifier: String = UUID().uuidString,
        directoryName: String = "logs",
        maxFiles: Int = 7
    ) {
        self.identifier = identifier
        self.formatter = formatter
        self.logsDirectoryName = directoryName
        self.maxFiles = maxFiles
        // Create logs directory if needed
        createLogsDirectoryIfNeeded()
        // Delete old logs if needed
        deleteOldLogsIfNeeded()
        // Open new/current log file
        openFile()
    }
    
    deinit {
        closeFile()
    }
    
    
    // MARK: - LogHandlerType
    
    /// Logs given `Log` message to current log file.
    internal func handle(log: Log, level: LogLevel) {
        var message = formatter.createMessage(from: log, level: level)
        message += "\n"
        if let data = message.data(using: .utf8), let handle = fileHandle {
            handle.write(data)
        }
    }
    
    
    // MARK: - Public
    
    /// Returns a file URL of current log file.
    internal func currentFileURL() -> URL {
        logsDirectory().appendingPathComponent(currentFileName)
    }
    
    /// Returns all log files in logs directory.
    internal func allLogFiles() -> [URL] {
        let directory = logsDirectory()
        let files = try? fileManager.contentsOfDirectory(
            at: directory,
            includingPropertiesForKeys: [.contentModificationDateKey],
            options: .skipsHiddenFiles
        )
        
        return files ?? []
    }
    
    /// Returns all log files to be deleted. Sorted by modification date - oldest last.
    internal func logsToBeDeleted() -> [URL] {
        // Get all logs
        var files = allLogFiles()
        if files.count < maxFiles {
            return []
        }
        
        // Sort by modification date - newest first
        files.sort { u1, u2 in
            let date1 = (try? u1.resourceValues(forKeys: [.contentModificationDateKey]))?.contentModificationDate ?? Date()
            let date2 = (try? u2.resourceValues(forKeys: [.contentModificationDateKey]))?.contentModificationDate ?? Date()
            return date1 > date2
        }
        return files
    }
    
    /// Deletes all logs
    internal func deleteAllLogs() {
        var files = allLogFiles()
        while files.isEmpty == false {
            let last = files.removeLast()
            try? fileManager.removeItem(at: last)
        }
        fileHandle = nil
        openFile() // open a new file after delete
    }
    
    
    // MARK: - Private
    
    /// Returns logs directory - documents + logs directory name.
    private func logsDirectory() -> URL {
        let documents = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first
        return URL(fileURLWithPath: logsDirectoryName, relativeTo: documents)
    }
    
    /// Creates logs directory (with any intermediate directories) if needed.
    private func createLogsDirectoryIfNeeded() {
        guard fileManager.fileExists(atPath: logsDirectory().path) == false else {
            return
        }
        
        try? fileManager.createDirectory(at: logsDirectory(), withIntermediateDirectories: true, attributes: nil)
    }
    
    /// Deletes old logs if needed.
    private func deleteOldLogsIfNeeded() {
        // Delete oldest files over limit
        var files = logsToBeDeleted()
        while files.count > maxFiles {
            let last = files.removeLast()
            try? fileManager.removeItem(at: last)
        }
    }

    /// Opens a new/existing log file. Closes current handle if any exists.
    private func openFile() {
        if fileHandle != nil {
            closeFile()
        }
        do {
            let fileURL = currentFileURL()
            if !fileManager.fileExists(atPath: fileURL.path) {
                fileManager.createFile(atPath: fileURL.path, contents: nil, attributes: nil)
            }
            fileHandle = try FileHandle(forWritingTo: fileURL)
            fileHandle?.seekToEndOfFile()
            if let fileHandle = fileHandle, let data = "\n==== START of session ====\n".data(using: .utf8) {
                fileHandle.write(data)
            }
        } catch _ {
            fileHandle = nil
        }
    }
    
    /// Closes current log file.
    private func closeFile() {
        if let fileHandle = fileHandle, let data = "\n==== END of session ====\n".data(using: .utf8) {
            fileHandle.write(data)
            fileHandle.closeFile()
        }
        
        fileHandle = nil
    }
}
