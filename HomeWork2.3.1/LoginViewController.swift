//
//  LoginViewController.swift
//  HomeWork2.3.1
//
//  Created by Artur Anissimov on 26.10.2021.
//

import UIKit

class LoginViewController: UIViewController {
    
    @IBOutlet var usernameTF: UITextField!
    @IBOutlet var passwordTF: UITextField!
    @IBOutlet var logInButton: UIButton!
    
    let username = "User"
    let password = "Password"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(notification:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let welcomeVC = segue.destination as? WelcomeViewController else { return }
        
        guard let usernameTF = usernameTF.text, usernameTF == username else {
            showAlertWithHandler(title: "Invalid login or password",
                                 message: "Please, enter correct login and password",
                                 textfield: usernameTF)
            return
        }
        
        guard let passwordTF = passwordTF.text, passwordTF == password else {
            showAlertWithHandler(title: "Invalid login or password",
                                 message: "Please, enter correct login and password",
                                 textfield: passwordTF)
            return
        }
        
        welcomeVC.welcome = usernameTF
    }
    
    // Метод для скрытия клавиатуры тапом по экрану
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    @IBAction func unwind(for segue: UIStoryboardSegue) {
        guard segue.source is WelcomeViewController else { return }
        usernameTF.text = ""
        passwordTF.text = ""
    }
    
    @IBAction func forgotUserNameButtonPressed() {
        showAlert(title: "Oops!", message: "Your name is User 😉")
    }
    
    @IBAction func forgotPasswordButtonPressed() {
        showAlert(title: "Oops!", message: "Your password is Password 😉")
    }
        
    
    @objc private func keyboardWillShow(notification: NSNotification) {
        
        guard let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue else {
            return
        }
        
        self.view.frame.origin.y = 0 - keyboardSize.height / 2
    }
    
    @objc private func keyboardWillHide() {
        self.view.frame.origin.y = 0
    }
    
}

extension LoginViewController {
    
    private func showAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default)
        
        alert.addAction(okAction)
        present(alert, animated: true)
    }
    
    private func showAlertWithHandler(title: String, message: String, textfield: UITextField) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        let okAction = UIAlertAction(title: "OK", style: .default) { _ in
            textfield.text = ""
            textfield.becomeFirstResponder()
        }
        
        alert.addAction(okAction)
        present(alert, animated: true)
        
    }

}

extension LoginViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == usernameTF {
            textField.resignFirstResponder()
            passwordTF.becomeFirstResponder()
        } else if textField == passwordTF {
            textField.resignFirstResponder()
            self.performSegue(withIdentifier: "LogInSegue", sender: self)
        }
        
        return true
    }
    
}
    
