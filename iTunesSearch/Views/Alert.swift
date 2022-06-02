//
//  Alert.swift
//  iTunesSearch
//
//  Created by Kirill Khristenko on 02.06.2022.
//

import Foundation
import UIKit

class Alert {

    static func showAlert (_ title: String, _ message: String, for viewController: UIViewController) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: "Cancel", style: .cancel)
        alert.addAction(action)
        viewController.present(alert, animated: true)
    }
    
    
}
