//
//  Validation.swift
//  iTunesSearch
//
//  Created by Kirill Khristenko on 02.06.2022.
//

import Foundation
import UIKit


class Validator {
    
    static func isPassValid(_ pass: String) -> Bool {
        guard isEngPass(pass) else { return false }
        guard isUppercasePass(pass) else { return false }
        guard isNumberInPass(pass) else { return false }
        return true
    }
    
    static func isUppercasePass(_ value: String) -> Bool {
        guard value.count >= 6 else { return false }
        for char in value {
            if char.isUppercase == true {
                return true
            }
        }
        return false
    }
    
    static func isEngPass(_ value: String) -> Bool {
        let ruChar = "йцукенгшщзхъёфывапролджэячсмитьбю"
        let value = value.lowercased()
        for char in value {
            if ruChar.contains(char) {
                return false
            }
        }
        return true
    }
    
    static func isNumberInPass(_ value: String) -> Bool {
        let decimalChar = CharacterSet.decimalDigits
        let decimalRange = value.rangeOfCharacter(from: decimalChar)
        if decimalRange != nil {
            return true
        }
        return false
    }
    
    static func ageValid(_ datePicker: UIDatePicker) -> Bool {
        let calendar = NSCalendar.current
        let currentDate = Date()
        let dateOfBirth = datePicker.date
        
        let age = calendar.dateComponents([.year], from: dateOfBirth, to: currentDate)
        let ageCount = age.year
        guard let userAge = ageCount else { return false }
        if userAge < 18 {
            return false
        }
        return true
    }
}
