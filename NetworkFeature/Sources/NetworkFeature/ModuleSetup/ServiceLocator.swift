import Foundation
import AbstractFeature
import Swinject

/// Dependency inversion container for the package.
public final class ServiceLocator {
    public static let shared = ServiceLocator()
    
    private let container = Container()
    
    // MARK: - Init
    
    private init(){
        container.register(UseCaseFactory.self) { _ in NetworkFeatureFactory() }.inObjectScope(.container)
    }
    
    // MARK: - Public Methods
    
    public func useCaseFactory() -> UseCaseFactory {
        container.resolve(UseCaseFactory.self)!
    }
}
