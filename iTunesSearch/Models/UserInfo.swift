//
//  UserInfo.swift
//  iTunesSearch
//
//  Created by Kirill Khristenko on 02.06.2022.
//

import Foundation


struct UserInfo: Codable {
    
    let firstName: String
    let secondName: String
    let dateOfBirth: Date
    let phoneNumber: String
    let email: String
    let password: String
}

enum UserKey: String {
    case user
    case currentUser
}
