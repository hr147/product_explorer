//
//  ServiceLocator.swift
//  ProductExplorer
//
//  Created by Haroon Ur Rasheed on 03/06/2020.
//  Copyright © 2020 hr147. All rights reserved.
//

import Swinject
import NetworkFeature

/// Service locator for the application to resolve dependencies.
final class ServiceLocator {
    // MARK: - Public Properties
    
    static let shared = ServiceLocator()
    
    // MARK: - Private Properties
    
    private let container = Container()
    
    // MARK: - init
    
    private init() {
        //Register dependencies
        container.register(ProductSceneFactory.self) { _  in
            ProductSceneFactory(useCaseFactory: NetworkFeature.ServiceLocator.shared.useCaseFactory())
        }.inObjectScope(.container)
    }
    
    // MARK: - Public Methods
    
    func productSceneFactory() -> ProductSceneFactory {
        container.resolve(ProductSceneFactory.self)!
    }
}
