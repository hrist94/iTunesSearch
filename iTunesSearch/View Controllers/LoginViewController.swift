//
//  LoginViewController.swift
//  iTunesSearch
//
//  Created by Kirill Khristenko on 01.06.2022.
//

import UIKit

class LoginViewController: UIViewController {

    
    @IBOutlet var incorrectMess: UILabel!
    @IBOutlet var emailTextField: UITextField!
    @IBOutlet var passwordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        incorrectMess.isHidden = true
    }
    
    @IBAction func logInButtonPressed(_ sender: UIButton) {
        let email = emailTextField.text ?? ""
        let password = passwordTextField.text ?? ""
        
        let user = UserData.shared.fetchUser(email)
        
        if user == nil {
            incorrectMess.isHidden = false
        } else if user?.password == password {
            let storyboard = UIStoryboard(name: "AlbumsView", bundle: nil)
            let viewController = storyboard.instantiateViewController(withIdentifier: "navVC")
            viewController.modalPresentationStyle = .fullScreen
            present(viewController, animated: true)
            guard let currentUser = user else { return }
            UserData.shared.saveCurrentUser(currentUser)
            UserDefaults.standard.setValue(true, forKey: "isLogin")
        } else {
            incorrectMess.isHidden = false
        }
        
    }
    
   

}
