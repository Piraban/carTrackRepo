//
//  Country.swift
//  CarTrackPiraba
//
//  Created by Piraba Nagkeeran on 5/6/21.
//

import Foundation

struct Country: Hashable, Codable, Identifiable {
    static var `default` = Country(code: "SG", name: "Singapore")

    var id: String {
        code
    }
    let code: String
    let name: String

}
