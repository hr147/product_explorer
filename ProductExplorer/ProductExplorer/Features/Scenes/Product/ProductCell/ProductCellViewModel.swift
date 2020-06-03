//
//  ProductCellViewModel.swift
//  ProductExplorer
//
//  Created by Haroon Ur Rasheed on 03/06/2020.
//  Copyright © 2020 hr147. All rights reserved.
//

import UIKit.UIImage

struct ProductCellViewModel {
    // MARK: - Public Properties
    let id: String = UUID().uuidString
    let name: String = "HR 123"
    let imageURL: URL? = URL(string: "https://kredit.check24.de/konto-kredit/ratenkredit/nativeapps/imgs/08.png")
    let userType: String = "user type"
    let placeHolderImage = #imageLiteral(resourceName: "placeholder")
}

extension ProductCellViewModel: Hashable {
    static func == (lhs: ProductCellViewModel, rhs: ProductCellViewModel) -> Bool {
        lhs.id == rhs.id
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}
