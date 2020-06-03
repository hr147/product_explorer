import Foundation
import Combine
import CommonUtilities
 
final class SessionNetworkService: NetworkService {
    // MARK: - Private Properties
    
    private let session: URLSession

    // MARK: - Init
    
    public init(session: URLSession) {
        self.session = session
    }

    // MARK: - Public Methods
    
    @discardableResult
    func execute<T>(_ resource: Resource<T>) -> AnyPublisher<Result<T, NetworkError>, Never> {
        guard let request = resource.request else {
            return .just(.failure(NetworkError.invalidRequest))
        }
        
        return session.dataTaskPublisher(for: request)
            .mapError { _ in NetworkError.invalidRequest }
            .print()
            .flatMap { data, response -> AnyPublisher<Data, Error> in
                guard let response = response as? HTTPURLResponse else {
                    return .fail(NetworkError.invalidResponse)
                }

                guard 200..<300 ~= response.statusCode else {
                    return .fail(NetworkError.dataLoadingError(statusCode: response.statusCode, data: data))
                }
                return .just(data)
            }
        .decode(type: T.self, decoder: resource.decoder)
        .map { .success($0) }
        .catch ({ error -> AnyPublisher<Result<T, NetworkError>, Never> in
            return .just(.failure(NetworkError.jsonDecodingError(error: error)))
        })
        .eraseToAnyPublisher()
    }
}
