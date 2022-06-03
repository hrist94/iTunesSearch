//
//  UserInfoViewController.swift
//  iTunesSearch
//
//  Created by Kirill Khristenko on 03.06.2022.
//

import UIKit

class UserInfoViewController: UIViewController {

    
    @IBOutlet var firstNameLabel: UILabel!
    @IBOutlet var secondNameLabel: UILabel!
    @IBOutlet var birthDateLabel: UILabel!
    @IBOutlet var phoneNumberLabel: UILabel!
    @IBOutlet var emailLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        editUserInfo()
    }
    
    
    @IBAction func hideButtonPressed(_ sender: UIButton) {
        dismiss(animated: true)
    }
    
   
    
    private func editUserInfo() {
        guard let user = UserData.shared.currentUser else { return }
        firstNameLabel.text = user.firstName
        secondNameLabel.text = user.secondName
        birthDateLabel.text = DateFormatter.localizedString(from: user.dateOfBirth, dateStyle: .medium, timeStyle: .none)
        phoneNumberLabel.text = user.phoneNumber
        emailLabel.text = user.email
    }

}
