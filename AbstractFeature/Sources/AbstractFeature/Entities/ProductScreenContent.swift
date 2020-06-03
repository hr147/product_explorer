//
//  ProductScreenContent.swift
//  
//
//  Created by Haroon Ur Rasheed on 03/06/2020.
//

import Foundation

public enum ProductFilter: String {
    case all
    case available
    case favourite
}

public struct ProductScreenContent {
    public let headerTitle: String
    public let headerDescription: String
    public let filters: [ProductFilter]
    public let products: [Product]
    
    public init(headerTitle: String,
                headerDescription: String,
                filters: [ProductFilter],
                products: [Product]) {
        self.headerTitle = headerTitle
        self.headerDescription = headerDescription
        self.filters = filters
        self.products = products
    }
}
