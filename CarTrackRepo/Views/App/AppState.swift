//
//  AppState.swift
//  CarTrackPiraba
//
//  Created by Piraba Nagkeeran on 5/6/21.
//

import Combine
import SwiftUI

class AppState: ObservableObject {

    @Published var isLoggedUser: Bool = false {
        didSet {
            UserDefaults.standard.set(isLoggedUser, forKey: "isLoggedUser")
        }
    }

    @Published var isSessionExpired: Bool = false {
        didSet {
            if(isSessionExpired) {
                //TODO: change the status when user logout
            }
        }
    }
    
  
    @Published var hasSetDB: Bool = false {
        didSet {
            UserDefaults.standard.set(hasSetDB, forKey: "CarUserDB")
        }
    }

    init() {
        self.hasSetDB = UserDefaults.standard.object(forKey: "CarUserDB") as? Bool ?? false
        self.isLoggedUser =  UserDefaults.standard.object(forKey: "isLoggedUser") as? Bool ?? false
        self.isSessionExpired = false

    }
}
