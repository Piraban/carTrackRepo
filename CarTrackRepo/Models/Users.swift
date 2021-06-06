//
//  Users.swift
//  CarTrackPiraba
//
//  Created by Piraba Nagkeeran on 5/6/21.
//

import Foundation
import MapKit


struct ListUserResponse: Codable {
    let listUsers: [User]
//    let listUsers: [User]
//
//    enum CodingKeys: String, CodingKey {
//        case listUsers
//    }
}


struct User: Codable,Identifiable {
    let id          : Int
    let name        : String
    let username    : String
    let email       : String
    let address     : UserAddress
    let phone       : String
    let website     : String
    let company     : Company


    enum CodingKeys: String, CodingKey {
        case id,name,username,email,address,phone, website ,company
    }
}

struct UserAddress: Codable {
    let street  : String
    let suite   : String
    let city    : String
    let zipcode : String
    let geo     : GeoLocation
    
    enum CodingKeys: String, CodingKey {
        case street,suite,city,zipcode,geo
    }
}

struct GeoLocation: Codable,Identifiable {
    var id = UUID()
    let lat : String
    let lng : String
    
    enum CodingKeys: String, CodingKey {
        case lat,lng
    }
    
    var coordinate: CLLocationCoordinate2D {
        CLLocationCoordinate2D(latitude: Double(lat) ?? 0.000, longitude: Double(lng) ?? 0.000)
       }
}



struct Company: Codable {
    let name        : String
    let catchPhrase : String?
    let bs          : String?
    
    enum CodingKeys: String, CodingKey {
        case name,catchPhrase,bs
    }
    
}

