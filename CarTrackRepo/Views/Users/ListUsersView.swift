//
//  ListUsersView.swift
//  CarTrackPiraba
//
//  Created by Piraba Nagkeeran on 5/6/21.
//

import SwiftUI

struct ListUsersView: View {
    @StateObject var usersVM = UsersViewModel()
    @EnvironmentObject var appState: AppState

    var body: some View {
        ZStack {
            NavigationView{
                List {
                    ForEach(usersVM.listUsers) { item in
                        NavigationLink(
                            destination: UserDetailView(user: item, coordinate: item.address.geo.coordinate)){
                            UserRowView(user: item)
                                .padding(.vertical , 4)
                        }
                      
                    }
                }.navigationTitle("user.title")
                .background(Color("CarBlue"))

            }
            
        } .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity)
        .background(Color("CarBlue"))
        .edgesIgnoringSafeArea(.all)
        .onAppear() {
            usersVM.getListUsers()
        }
    }
}

struct ListUsersView_Previews: PreviewProvider {
    static var previews: some View {
        ListUsersView()
    }
}
