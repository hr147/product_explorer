import Foundation

extension OperationQueue {
    public static let defaultOperationQueue: OperationQueue = {
        let operationQueue = OperationQueue()
        operationQueue.maxConcurrentOperationCount = 5
        operationQueue.qualityOfService = .userInitiated
        return operationQueue
    }()
}
