import Foundation
import Combine

public protocol ProductUseCase {
    /// it will return products
    func products() -> AnyPublisher<Result<[Product], Error>, Never>
}
