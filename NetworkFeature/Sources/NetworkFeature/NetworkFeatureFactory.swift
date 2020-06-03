import Foundation
import AbstractFeature


public final class NetworkFeatureFactory: UseCaseFactory {
    // MARK: - Private Properties
    
    private let service: NetworkService
    
    // MARK: - Init
    
    public init() {
        let configuration = URLSessionConfiguration.default
        configuration.httpAdditionalHeaders = ["Accept":"application/vnd.github.v3+json",
                                   "Content-Type" : "application/json; charset=utf-8",
                                   "Authorization": "token d1ce14ed975c52f256bfbb618263d8925e872648"]
        service = SessionNetworkService(session: URLSession(configuration: configuration))
    }
    
    // MARK: - Public Methods
    
    public func makeProductUseCase() -> ProductUseCase {
        NetworkUserUseCase(service: service)
    } 
}
