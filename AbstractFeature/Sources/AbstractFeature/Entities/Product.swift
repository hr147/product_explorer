import Foundation

public struct Product {
    public let id: String
    public let name: String
    public let imageURL: URL?
    public let type: String
    
    public init(id: String, name: String, imageURL: URL?, userType: String) {
        self.id = id
        self.name = name
        self.imageURL = imageURL
        self.type = userType
    }
}
