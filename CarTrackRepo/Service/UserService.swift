//
//  UserService.swift
//  CarTrackPiraba
//
//  Created by Piraba Nagkeeran on 6/6/21.
//

import Foundation
import Combine

enum UserService {
    static let apiSession = NetworkManager()
    static let baseUrl = URL(string: BASEURL)!
}

extension UserService {

    
    static func getUsers(_ path: APIPath) -> AnyPublisher<[User], APIError> {
        let URIPath = path.rawValue
        guard let components = URLComponents(url: baseUrl.appendingPathComponent(URIPath), resolvingAgainstBaseURL: true)
        else { fatalError("Couldn't create URLComponents") }
        var request = URLRequest(url: components.url!)
        request.httpMethod = "GET"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        
        return apiSession.execute(request)
            .map(\.value)
            .eraseToAnyPublisher()
    }
}
