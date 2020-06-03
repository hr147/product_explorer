//
//  ProductViewModel.swift
//  ProductExplorer
//
//  Created by Haroon Ur Rasheed on 03/06/2020.
//  Copyright © 2020 hr147. All rights reserved.
//

import Foundation
import Combine
import AbstractFeature
import CommonUtilities

enum ProductViewModelState {
    case show([ProductCellViewModel])
    case error(Error)
    case noResults
}

extension ProductViewModelState: Equatable {
    static func == (lhs: ProductViewModelState, rhs: ProductViewModelState) -> Bool {
        switch (lhs, rhs) {
        case (.noResults, .noResults),(.error, .error) :
            return true
        case (.show(let lhsUsers), .show(let rhsUsers)):
            return lhsUsers == rhsUsers
        default:
            return false
        }
    }
}

struct ProductViewModelInput {
    // triggered when the search query is updated
    let productTriggered: AnyPublisher<Void, Never>
}

typealias ProductViewModelOutput = AnyPublisher<ProductViewModelState, Never>

final class ProductViewModel {
    // MARK: - Public Properties
    
    let screenTitle = "Products"
    
    // MARK: - Private Properties
    
    private var cancellable: [AnyCancellable] = []
    private let productUseCase: ProductUseCase
    private let productsSubject = CurrentValueSubject<[Product], Never>([])
    
    // MARK: - Init
    
    init(productUseCase: ProductUseCase) {
        self.productUseCase = productUseCase
    }
    
    // MARK: - Public Methods
    
    func transform(input: ProductViewModelInput) -> ProductViewModelOutput {
        cancellable.forEach { $0.cancel() }
        cancellable.removeAll()
        
        let productResult = input.productTriggered
            .flatMap(productUseCase.products)
            .share()
        
        let products = productResult.compactMap { try? $0.get().products }
        
        products.assign(to: \.value, on: productsSubject).store(in: &cancellable)
        
        let errorState = productResult.compactMap({ $0.error() }).map(ProductViewModelState.error)
        let usersState = products.filter { !$0.isEmpty }.mapSequenceElement(ProductCellViewModel.init).map(ProductViewModelState.show)
        let noResultState = products.filter { $0.isEmpty }.map { _ in ProductViewModelState.noResults }
        
        return Publishers.Merge3(errorState, usersState, noResultState).removeDuplicates().eraseToAnyPublisher()
    }
}
