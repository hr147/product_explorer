import Foundation
import Combine

public protocol ProductUseCase {
    /// it will return products
    func products() -> AnyPublisher<Result<ProductScreenContent, Error>, Never>
}
