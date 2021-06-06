//
//  UserDetailView.swift
//  CarTrackPiraba
//
//  Created by Piraba Nagkeeran on 5/6/21.
//

import SwiftUI
import MapKit

struct UserDetailView: View {
    //MARK:- variables
    let user: User
    
    var userPin : [GeoLocation] {
        return [user.address.geo]
    }
    var coordinate: CLLocationCoordinate2D
    
    //MARK:- State variables
    @State private var centerCoordinate = CLLocationCoordinate2D()
    @State private var region = MKCoordinateRegion()
    
    var body: some View {
        ZStack {
            loadView
        }
        .onAppear{
            setRegion(coordinate)
        }          .edgesIgnoringSafeArea(.all)
        
    }
    
    private func setRegion(_ coordinate: CLLocationCoordinate2D){
        region = MKCoordinateRegion(
            center: coordinate,
            span: MKCoordinateSpan(latitudeDelta: 10, longitudeDelta: 10)
        )
    }
}

//MARK: Load View
private extension UserDetailView {
    
    var loadView: some View {
        VStack {
            mapView
            userInfo
                .padding(.top, 24)
                .padding(.horizontal , 24)
                .background(Color.gray)
        }
       
    }
    
    var mapView: some View {
        VStack {
            Map(coordinateRegion: $region, annotationItems: userPin) { city in
                MapPin(coordinate: city.coordinate, tint: .red)
            }.edgesIgnoringSafeArea(.all)
            .frame(height: 400) 
        }
    }
    
    var userInfo: some View {
        VStack {
            HStack {
                Text("Name:")
                    .font(.subheadline)
                    .foregroundColor(.black)
                    .fontWeight(.bold)
                Spacer()
                Text(user.name)
                    .font(.subheadline)
                    .foregroundColor(.black)
                    .fontWeight(.bold)
                    .multilineTextAlignment(.leading)
            }.padding(.vertical , 16)
            
            HStack {
                Text("Email:")
                    .font(.subheadline)
                    .foregroundColor(.black)
                    .fontWeight(.bold)
                    .multilineTextAlignment(.leading)

                Spacer()
                Text(user.email)
                    .font(.subheadline)
                    .foregroundColor(.black)
                    .fontWeight(.bold)
                    .multilineTextAlignment(.leading)

            }.padding(.vertical , 16)
            
            HStack {
                Text("City:")
                    .font(.subheadline)
                    .foregroundColor(.black)
                    .fontWeight(.bold)
                Spacer()
                Text(user.address.city)
                    .font(.subheadline)
                    .foregroundColor(.black)
                    .fontWeight(.bold)
                    .multilineTextAlignment(.leading)

            }.padding(.vertical , 16)
            Spacer()
        }
    }
}
