import Foundation

extension Result {
    public func error() -> Error? {
        guard case let .failure(error) = self else { return nil }
        
        return error
    }
}
