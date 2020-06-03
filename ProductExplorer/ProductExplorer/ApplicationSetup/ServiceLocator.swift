//
//  ServiceLocator.swift
//  ProductExplorer
//
//  Created by Haroon Ur Rasheed on 03/06/2020.
//  Copyright © 2020 hr147. All rights reserved.
//

import UIKit

final class ServiceLocator {
    static let shared = ServiceLocator()
    
    private init() {}
    
    // MARK: - Resolve Dependencies
    
    func productSceneFactory() -> ProductSceneFactory {
        .init()
    }
}
