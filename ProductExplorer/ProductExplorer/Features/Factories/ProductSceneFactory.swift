//
//  ProductSceneFactory.swift
//  ProductExplorer
//
//  Created by Haroon Ur Rasheed on 03/06/2020.
//  Copyright © 2020 hr147. All rights reserved.
//

import AbstractFeature

final class ProductSceneFactory {
    // MARK: - Private Properties
    
    private let useCaseFactory: UseCaseFactory
    
    // MARK: - Init
    
    init(useCaseFactory: UseCaseFactory) {
        self.useCaseFactory = useCaseFactory
    }
    
    // MARK: - Public Methods
    
    func makeProductViewController() -> ProductViewController {
        return .init(viewModel: .init(productUseCase: useCaseFactory.makeProductUseCase()))
    }
}
