//
//  RegViewController.swift
//  iTunesSearch
//
//  Created by Kirill Khristenko on 01.06.2022.
//

import UIKit

class RegViewController: UIViewController {
    
    var datePicker: UIDatePicker {
        let picker = UIDatePicker()
        picker.datePickerMode = .date
        picker.preferredDatePickerStyle = .wheels
        return picker
        
    }
//-MARK: Outlets
    @IBOutlet var scrollView: UIScrollView!
    @IBOutlet var firstNameTextField: UITextField!
    @IBOutlet var secondNameTextField: UITextField!
    @IBOutlet var dateOfBirthTextField: UITextField!
    @IBOutlet var phoneNumberTextField: UITextField!
    @IBOutlet var emailTextField: UITextField!
    @IBOutlet var passwordTextField: UITextField!
    @IBOutlet var labelPass: UILabel!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        labelPass.isHidden = true
        createDatePicker()
        registerForKeyboardNotifications()
        let tapScreen = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        tapScreen.cancelsTouchesInView = false
        view.addGestureRecognizer(tapScreen)
        phoneNumberTextField.delegate = self
        firstNameTextField.delegate = self
    }
   
    
    @IBAction func formatPhoneNumber(_ sender: UITextField) {
        phoneNumberTextField.text = "+7"
    }
    
    @IBAction func nameFields(_ sender: UITextField) {
        guard let lastChar = sender.text?.last?.lowercased() else { return }
        let engChar = "qwertyuiopasdfghjklzxcvbnm"
        guard engChar.contains(lastChar) else {
            sender.text?.removeLast()
            Alert.showAlert("Error!", "You can only use the English alphabet", for: self)
            return
        }
        
    }
    
    
    private func formatPhoneNumber(number: String) -> String {
        let cleanPhoneNumber = number.components(separatedBy: CharacterSet.decimalDigits.inverted).joined()
        let mask = "+X (XXX) XXX-XXXX"
        var result = ""
        var index = cleanPhoneNumber.startIndex
        for char in mask where index < cleanPhoneNumber.endIndex {
            if char == "X" {
                result.append(cleanPhoneNumber[index])
                index = cleanPhoneNumber.index(after: index)
            } else {
                result.append(char)
            }
        }
        return result
    }
    deinit {
        removeKeyboardNotific()
    }
}

// -MARK: ScrollView Keyboard

extension RegViewController {
    func registerForKeyboardNotifications() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    @objc private func keyboardWillShow(notification: Notification){
        let userInfo = notification.userInfo
        let keyboardHeigh = (userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as! NSValue).cgRectValue
        scrollView.contentOffset = CGPoint(x: 0, y: keyboardHeigh.height / 2)
        
    }
    @objc private func keyboardWillHide(notification: Notification){
        scrollView.contentOffset = CGPoint.zero
    }
    
    private func removeKeyboardNotific() {
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }
}

//-MARK: add Date Picker

extension RegViewController {
    
    private func createDatePicker() {
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: nil, action: #selector(doneButtonPressed))
        toolbar.setItems([doneButton], animated: true)
        dateOfBirthTextField.inputAccessoryView = toolbar
        dateOfBirthTextField.inputView = datePicker
    }
    @objc func doneButtonPressed() {
        let formmater = DateFormatter()
        formmater.dateStyle = .medium
        formmater.timeStyle = .none
        
        dateOfBirthTextField.text = formmater.string(from: datePicker.date)
        self.view.endEditing(true)
    }
}

//-MARK: Dismiss keyboard func

extension RegViewController {
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}

//-MARK: Phone Number formatting
extension RegViewController: UITextFieldDelegate {
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if textField == phoneNumberTextField {
            let newString = (textField.text! as NSString).replacingCharacters(in: range, with: string)
            textField.text = formatPhoneNumber(number: newString)
            return false
        } else {
            return true
        }
    }
}
