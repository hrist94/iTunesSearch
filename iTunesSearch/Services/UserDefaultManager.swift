//
//  UserDefaultManager.swift
//  iTunesSearch
//
//  Created by Kirill Khristenko on 02.06.2022.
//

import Foundation


class UserData {
    
    static let shared = UserData()
    
    let defaults = UserDefaults.standard
    
    var users: [UserInfo] {
        get {
            if let data = defaults.value(forKey: UserKey.user.rawValue) as? Data {
                return try! PropertyListDecoder().decode([UserInfo].self, from: data)
            } else {
                return [UserInfo]()
            }
        }
        set {
            if let data = try? PropertyListEncoder().encode(newValue) {
                defaults.set(data, forKey: UserKey.user.rawValue)
            }
        }
    }
    
    var currentUser: UserInfo? {
        get {
            if let data = defaults.value(forKey: UserKey.currentUser.rawValue) as? Data {
                return try! PropertyListDecoder().decode(UserInfo.self, from: data)
            } else {
                return nil
            }
        }
        set {
            if let data = try? PropertyListEncoder().encode(newValue) {
                defaults.set(data, forKey: UserKey.currentUser.rawValue)
            }
        }
    }
    
    func saveUser(_ firstName: String, _ secondName: String, _ dateOfBirth: Date, _ phoneNumber: String, _ email: String, _ password: String ) {
        
        let user = UserInfo(firstName: firstName, secondName: secondName, dateOfBirth: dateOfBirth, phoneNumber: phoneNumber, email: email, password: password)
        users.insert(user, at: 0)
    }
    func fetchUser(_ email: String) -> UserInfo? {

        let userData = self.users
        
        for user in userData {
            if user.email == email {
                return user
            }
        }
        return nil
    }
    func saveCurrentUser(_ user: UserInfo) {
        currentUser = user
        
    }
}
