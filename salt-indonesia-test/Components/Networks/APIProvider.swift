//
//  APIProvider.swift
//  salt-indonesia-test
//
//  Created by Erwindo Sianipar on 19/09/22.
//

import UIKit

enum ErrorType: Error {
    case networkError(Error)
    case parsingError(Error)
    case dataNotFound
    
    var localizedDescription: String {
        switch self {
        case .networkError(let error), .parsingError(let error):
            return error.localizedDescription
        case .dataNotFound:
            return "Data Not Found"
        }
    }
}

enum Result<T> {
    case success(T)
    case failure(ErrorType)
}

internal final class APIProvider {
    
    static func dataRequest<T: Decodable>(endpoint: Endpoint, body: [String: String], response: T.Type, completion: @escaping (Result<T>) -> Void) {
        guard let url = URL(string: endpoint.base + endpoint.path) else {
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = endpoint.method
        if endpoint.method == "POST" {
            request.addValue("application/json", forHTTPHeaderField: "Content-Type")
            request.addValue("application/json", forHTTPHeaderField: "Accept")
            let jsonData = try? JSONSerialization.data(withJSONObject: body)
            request.httpBody = jsonData
        }
        
        let task = URLSession.shared.dataTask(with: request) { data, _, error in
            if let error = error {
                completion(Result.failure(ErrorType.networkError(error)))
                return
            }
            
            guard let data = data else {
                completion(Result.failure(ErrorType.dataNotFound))
                return
            }
            
            do {
                let decode = try JSONDecoder().decode(response.self, from: data)
                completion(Result.success(decode))
            } catch let error {
                completion(Result.failure(ErrorType.parsingError(error)))
            }
        }
        
        task.resume()
    }
}
