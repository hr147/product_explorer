import Foundation
import AbstractFeature

struct ProductResponse: Decodable {
    struct Header: Decodable {
        let headerTitle: String
        let headerDescription: String
    }
    
    struct Product: Decodable {
        let id: Int
        let name: String
        let imageURL: URL
        let type: String
        let available: Bool
        let description: String
        let longDescription: String
        let rating: Double
        let colorCode: String
        let releaseDate: Double
        let color: String
    }
    
    struct Price: Decodable {
        let value: Double
        let currency: String
    }

    var products: [Product] = []
    var filters: [String] = []
    let header: Header
    
}

extension ProductScreenContent {
    static let germanFilters: [String: String] = ["Alle": "all",
                                              "Verfügbar": "available",
                                              "Vorgemerkt": "favourite"]
    
    init(_ response: ProductResponse) {
        
        let filters = response.filters.compactMap { Self.germanFilters[$0] }.compactMap(ProductFilter.init)
        let products = response.products.map(Product.init)
        
        self.init(headerTitle: response.header.headerTitle,
        headerDescription: response.header.headerDescription,
        filters: filters,
        products: products)
    }
}

extension Product {
    init(_ product: ProductResponse.Product) {
        self.init(id: "\(product.id)",
                  name: product.name,
                  imageURL: product.imageURL,
                  userType: product.type)
    }
}
