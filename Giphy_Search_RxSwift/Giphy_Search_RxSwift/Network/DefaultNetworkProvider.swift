//
//  DefaultNetworkProvider.swift
//  Giphy_Search_RxSwift
//
//  Created by Lee Seung-Jae on 2022/10/21.
//

import Foundation

final class DefaultNetworkProvider: NetworkProvider {
    let session: URLSession = .shared

    func request<T: APIEndpoint>(
        _ request: T,
        completion: @escaping (Result<T.APIResponse,NetworkError>) -> Void
    ) -> Cancellable? {
        guard let urlRequest = request.urlReqeust else {
            completion(.failure(NetworkError.invalidRequest))
            return nil
        }
        
        let task = self.session.dataTask(with: urlRequest) { data, response, error in
            if let error = error {
                completion(.failure(.serverError(description: error.localizedDescription)))
                return
            }

            guard let data = data else {
                completion(.failure(.invalidData))
                return
            }

            guard let response = response as? HTTPURLResponse else {
                completion(.failure(NetworkError.invalidResponse))
                return
            }

            guard (200...299).contains(response.statusCode) else {
                completion(.failure(NetworkError.invalidStatusCode(response.statusCode, data: data)))
                return
            }

            do {
                let decoded = try JSONDecoder().decode(T.APIResponse.self, from: data)
                completion(.success(decoded))
                return
            } catch let error {
                completion(.failure(.parsingError(description: error.localizedDescription, data: data)))
                return
            }
        }

        return task
    }
}
