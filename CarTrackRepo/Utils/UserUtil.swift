//
//  UserUtil.swift
//  CarTrackPiraba
//
//  Created by Piraba Nagkeeran on 5/6/21.
//

import Foundation

class UserUtils {
    
    static func setupDB() -> Bool{
        DBManagerImpl().createAuthUser()
        return UserDefaults.standard.object(forKey: "CarUserDB") as? Bool ?? false

    }

}
