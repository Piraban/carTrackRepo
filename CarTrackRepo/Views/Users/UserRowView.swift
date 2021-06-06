//
//  UserRow.swift
//  CarTrackPiraba
//
//  Created by Piraba Nagkeeran on 5/6/21.
//

import SwiftUI

struct UserRowView: View {
    //MARK:- variables
    let user: User
    
    var body: some View {
        VStack {
                Text(self.user.name)
                    .foregroundColor(.black)
                    .padding(.leading, 6.0)
                                
        }.frame(height: 45)
    }
}

struct UserRowView_Previews: PreviewProvider {
    static var previews: some View {
        UserRowView(user: User(id: 1, name: "", username: "", email: "", address: UserAddress(street: "", suite: "", city: "", zipcode: "", geo: GeoLocation(lat: "", lng: "")), phone: "", website: "", company: Company(name: "", catchPhrase: "", bs: "")))
    }
}
