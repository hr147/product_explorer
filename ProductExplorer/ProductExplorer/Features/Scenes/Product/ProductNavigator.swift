//
//  ProductNavigator.swift
//  ProductExplorer
//
//  Created by Haroon Ur Rasheed on 03/06/2020.
//  Copyright © 2020 hr147. All rights reserved.
//

import UIKit

final class ProductNavigator {
    // MARK: - Private Properties
    
    private let rootController: UINavigationController
    private let factory: ProductSceneFactory
    
    // MARK: - Init
    
    init(rootController: UINavigationController, factory: ProductSceneFactory) {
        self.rootController = rootController
        self.factory = factory
    }
    
    // MARK: - Public Methods
    
    func startNavigation() {
        let controller = factory.makeProductViewController()
        rootController.setViewControllers([controller], animated: true)
    }
}
