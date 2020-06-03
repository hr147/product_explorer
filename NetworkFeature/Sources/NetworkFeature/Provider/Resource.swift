import Foundation

/// `Resource` is request builder for the network.
public struct Resource<T: Decodable> {
    // MARK: - Public Properties
    
    let url: URL?
    let parameters: [String: String]
    let decoder: JSONDecoder
    var request: URLRequest? {
        return url.map({ URLRequest(url: $0) })
    }

    // MARK: - Init
    
    init(url: URL?, parameters: [String: String] = [:], decoder: JSONDecoder = JSONDecoder()) {
        self.url = url
        self.parameters = parameters
        self.decoder = decoder
    }
}
