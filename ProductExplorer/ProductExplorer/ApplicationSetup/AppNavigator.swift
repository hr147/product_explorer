import UIKit

final class AppNavigator {
    // MARK: - Private Properties
    
    private let window: UIWindow
    
    // MARK: - Init
    
    init(window: UIWindow) {
        self.window = window
    }
    
    // MARK: - Public Methods
    
    func startNavigation() {
        let navigationController = AppNavigationController()
        let navigator = ProductNavigator(rootController: navigationController,
                                         factory: ServiceLocator.shared.productSceneFactory())
        navigator.startNavigation()
        window.rootViewController = navigationController
    }
}
