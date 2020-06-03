import AbstractFeature
import Combine
import Foundation
import CommonUtilities


struct NetworkUserUseCase: ProductUseCase {
    // MARK: - Private Properties
    
    private let service: NetworkService
    
    // MARK: - Init
    
    init(service: NetworkService) {
        self.service = service
    }
    
    // MARK: - Public Methods
    
    func products() -> AnyPublisher<Result<ProductScreenContent, Error>, Never> {
        let url = URL(string: "http://app.check24.de/products-test.json")
        let resource: Resource<ProductResponse> = .init(url: url)
        
        return service.execute(resource)
        .map({ (result: Result<ProductResponse, NetworkError>) -> Result<ProductScreenContent, Error> in
            switch result {
            case .success(let response):
                return .success(.init(response))
            case .failure(let error):
                return .failure(error)
            }
        })
        .subscribe(on: OperationQueue.defaultOperationQueue)
        .receive(on: RunLoop.main)
        .eraseToAnyPublisher()
    }
}
