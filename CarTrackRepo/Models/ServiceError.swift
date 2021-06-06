//
//  ServiceError.swift
//  CarTrackPiraba
//
//  Created by Piraba Nagkeeran on 5/6/21.
//

import Foundation

struct ServiceError: Codable {
    let error: String

    enum CodingKeys: String, CodingKey {
        case error = "error"
    }
}
