//
//  ProductCellViewModel.swift
//  ProductExplorer
//
//  Created by Haroon Ur Rasheed on 03/06/2020.
//  Copyright © 2020 hr147. All rights reserved.
//

import UIKit.UIImage
import AbstractFeature

struct ProductCellViewModel {
    // MARK: - Public Properties
    
    let name: String
    let imageURL: URL?
    let userType: String
    let placeHolderImage = #imageLiteral(resourceName: "placeholder")
    
    // MARK: - Private Properties
    
    private let product: Product
    
    // MARK: - Init
    
    init(_ product: Product) {
        self.name = product.name
        self.imageURL = product.imageURL
        self.userType = "User Type: \(product.type)"
        self.product = product
    }
    
}

extension ProductCellViewModel: Hashable {
    static func == (lhs: ProductCellViewModel, rhs: ProductCellViewModel) -> Bool {
        lhs.product.id == rhs.product.id
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(product.id)
    }
}
