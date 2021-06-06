//
//  CountryRow.swift
//  CarTrackPiraba
//
//  Created by Piraba Nagkeeran on 5/6/21.
//

import SwiftUI

struct CountryRow: View {
    var country: Country
    
    var body: some View {
        VStack {
            HStack {
                Text(getFlag(from: self.country.code))
                    .foregroundColor(.black)
                    .padding(.leading, 6.0)
                    .frame(width: 38.0, height: 24.0)
                
                Text(self.country.name)
                    .foregroundColor(.black)
                    .padding(.leading, 6.0)
                                
              
            }
        }
    }
    
    internal func getFlag(from countryCode: String) -> String {

        return countryCode
            .unicodeScalars
            .map({ 127397 + $0.value })
            .compactMap(UnicodeScalar.init)
            .map(String.init)
            .joined()
    }
    
    private func flag(country: String) -> String {
        let base: UInt32 = 127397
        return String(String.UnicodeScalarView(
            country.unicodeScalars.compactMap({ UnicodeScalar(base + $0.value) })
        ))
    }
}

struct CountryRow_Previews: PreviewProvider {
    static var previews: some View {
        CountryRow(country: Country(code: "SG", name: "Singapore"))
    }
}
