import Foundation

public protocol UseCaseFactory {
    func makeProductUseCase() -> ProductUseCase
}
