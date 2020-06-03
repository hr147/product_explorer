import Combine
import Foundation

extension Publisher {
    //    The flatMapLatest operator behaves much like the standard FlatMap operator, except that whenever
    //    a new item is emitted by the source Publisher, it will unsubscribe to and stop mirroring the Publisher
    //    that was generated from the previously-emitted item, and begin only mirroring the current one.
    public func flatMapLatest<T: Publisher>(_ transform: @escaping (Self.Output) -> T) -> Publishers.SwitchToLatest<T, Publishers.Map<Self, T>> where T.Failure == Self.Failure {
        map(transform).switchToLatest()
    }
    
    public static func empty() -> AnyPublisher<Output, Failure> {
        return Empty().eraseToAnyPublisher()
    }
    
    public static func just(_ output: Output) -> AnyPublisher<Output, Failure> {
        return Just(output)
            .catch { _ in AnyPublisher<Output, Failure>.empty() }
            .eraseToAnyPublisher()
    }
    
    public static func fail(_ error: Failure) -> AnyPublisher<Output, Failure> {
        return Fail(error: error).eraseToAnyPublisher()
    }
}

extension Publisher where Self.Output: Sequence {
    public func mapSequenceElement<T>(_ transform: @escaping (Self.Output.Element) -> T) -> Publishers.Map<Self, [T]> {
        map {
            $0.map(transform)
        }
    }
}
