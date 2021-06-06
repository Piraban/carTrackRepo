//
//  CountriesService.swift
//  CarTrackPiraba
//
//  Created by Piraba Nagkeeran on 6/6/21.
//

import Combine
import Foundation
import SwiftUI

protocol CountriesService {
    func load() -> [Country]
}

struct RealCountriesService: CountriesService {
    private static var countries: [Country]?

    func load() -> [Country] {
        if RealCountriesService.countries == nil {
            RealCountriesService.countries = self.load("country.json")
        }
        return RealCountriesService.countries ?? []
    }

    private func load<T: Decodable>(_ filename: String) -> T {
        let data: Data

        
        guard let file = Bundle.main.url(forResource: filename, withExtension: nil)
            else {
                fatalError("Couldn't find \(filename) in main bundle.")
        }

        do {
            data = try Data(contentsOf: file)
        } catch {
            fatalError("Couldn't load \(filename) from main bundle:\n\(error)")
        }

        do {
            let decoder = JSONDecoder()
            return try decoder.decode(T.self, from: data)
        } catch {
            fatalError("Couldn't parse \(filename) as \(T.self):\n\(error)")
        }
    }
}

struct StubCountriesService: CountriesService {
    func load() -> [Country] {
        []
    }
}
