//
//  NetworkManager.swift
//  CarTrackPiraba
//
//  Created by Piraba Nagkeeran on 6/6/21.
//

import Foundation
import Combine

enum APIError: Error, LocalizedError {
    case unknown,
         apiError(reason: String),
         payCardError(reason: String),
         parserError(reason: String),
         networkError(reason: URLError),
         unauthorizedError(reason: String),
         servicerError(reason: String)

    var errorDescription: String? {
        switch self {
            case .unknown:
                return "Unknown error"
            case .apiError(let reason), .parserError(let reason):
                return reason
            case .payCardError(let reason):
                return reason
            case .unauthorizedError(let reason):
                return reason
            case .servicerError(let reason):
                return reason
            case .networkError(let from):
                return from.localizedDescription
        }
    }
}

struct NetworkManager {
    
    struct Response<T> {
        let value: T
        let response: URLResponse
    }

    
    func execute<T: Decodable>(_ request: URLRequest) -> AnyPublisher<Response<T>, APIError> {
        print("\(request.httpMethod ?? "") \(String(describing: request.url))")
        
        #if DEBUG
        if(request.httpMethod == "POST"){
            let str = String(decoding: request.httpBody!, as: UTF8.self)
            print("BODY \n \(str)")
        }
        print("HEADERS \n \(String(describing: request.allHTTPHeaderFields))")
        #endif
        return URLSession.shared
            .dataTaskPublisher(for: request)
            .print()
            .tryMap {  data , response in
                guard let httpResponse = response as? HTTPURLResponse else {
                    throw APIError.unknown
                }
                
                
                let strii = String(decoding: data, as: UTF8.self)
                print("BODY2222 \n \(strii)")
                print(httpResponse)

                switch httpResponse.statusCode {
                
                    case 200..<300:
                        let value = try JSONDecoder().decode(T.self, from: data)
                        return Response(value: value, response: response)
                    case 401: throw APIError.unauthorizedError(reason: "Unauthorized")
                    case 403: throw APIError.unauthorizedError(reason: "Unauthorized")
                    case 404: throw APIError.apiError(reason: "Resource not found")
                    case 405..<500: throw APIError.apiError(reason: "client error");
                    case 500..<600:
                        throw APIError.servicerError(reason: "server error")
                    default:
                        throw APIError.apiError(reason: "Unknown")

                }
            }
            .mapError { error in
                print(error)
                if let error = error as? APIError {
                    return error
                }
                if let urlerror = error as? URLError {
                    return APIError.networkError(reason: urlerror)
                }
                return APIError.unknown
            }
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
}
