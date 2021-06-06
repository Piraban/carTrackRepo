//
//  DBManager.swift
//  CarTrackPiraba
//
//  Created by Piraba Nagkeeran on 5/6/21.
//

import Foundation
import SQLite


class DBManagerImpl {
    //MARK:- sqlite instances
    private var db: Connection!
     
    //MARK:- Table instances
    private var authUsers: Table!
 
    //MARK:- columns instances of table
    private var id: Expression<Int64>!
    private var username: Expression<String>!
    private var password: Expression<String>!
    private var country: Expression<String>!
    
    init () {
        do {
            let path: String = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first ?? ""
            db = try Connection("\(path)/my_users.sqlite3")
            authUsers = Table("AuthUser")
             
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func createAuthUser() {
        do{
            id = Expression<Int64>("id")
            username = Expression<String>("username")
            password = Expression<String>("password")
            country = Expression<String>("country")
             
            if (!UserDefaults.standard.bool(forKey: "CarUserDB")) {
 
                try db.run(authUsers.create { (t) in
                    t.column(id, primaryKey: true)
                    t.column(username, unique: true)
                    t.column(password)
                    t.column(country)
                })
                 
                try db.run(authUsers.insert(self.username <- "abcd", self.password <- "1234567", self.country <- "Singapore"))
      
                UserDefaults.standard.set(true, forKey: "CarUserDB")
            }
        }catch let Result.error(message, code, statement) where code == SQLITE_CONSTRAINT {
            print("constraint failed: \(message), in \(String(describing: statement))")
        } catch let error {
            print("insertion failed: \(error)")
        }
    }

    
    func isAuthUserExist(userName: String, userPassword: String, countryName: String) -> Bool {
        var status = false
        do {
            authUsers = Table("AuthUser")
            id = Expression<Int64>("id")
            username = Expression<String>("username")
            password = Expression<String>("password")
            country = Expression<String>("country")
            
            let user: AnySequence<Row> = try db.prepare(authUsers.filter(username != nil && username == userName && password == userPassword))

            try user.forEach({ (rowValue) in
                let usernameVal = try rowValue.get(username)
                if(usernameVal == userName) {
                    status =  true;
                }
            })

        }catch let error {
            print("retrieve failed: \(error)")
        }
        return status
    }
}
