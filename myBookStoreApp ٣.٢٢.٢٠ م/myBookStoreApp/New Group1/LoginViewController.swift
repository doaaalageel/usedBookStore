//
//  LoginViewController.swift
//  myBookStoreApp
//
//  Created by Dua'a ageel on 22/05/1443 AH.
//

import UIKit
import Firebase

class LoginViewController: UIViewController {

    @IBOutlet weak var emailTextField: UITextField!
    
    
    @IBOutlet weak var passwordTextField: UITextField!
    {
            didSet{
                passwordTextField.isSecureTextEntry = true
            }
        }
    
    
    
    @IBOutlet weak var loginnLabel: UILabel!{
    didSet {
        loginnLabel.text = "loginword".localized
    }
    }
    @IBOutlet weak var massageLoginLabel: UILabel! {
        didSet {
            massageLoginLabel.text = "hi".localized
        }
    }
    
    
    @IBOutlet weak var emailLabel: UILabel!{
        didSet {
            emailLabel.text = "email".localized
        }
    }
    
    @IBOutlet weak var passwordLabel: UILabel!{
        didSet {
            passwordLabel.text = "password".localized
        }
    }
    
    @IBOutlet weak var loginButton: UIButton!
    {
        didSet {
            loginButton.setTitle(NSLocalizedString("login", tableName: "Localizable", comment: ""), for: .normal)
        }
        
    }
        
    
    
    @IBOutlet weak var newUserLabel: UILabel!{
        didSet {
            newUserLabel.text = "newuser".localized
        }
    }
    
    
    @IBOutlet weak var registerButton: UIButton!
    
    {
        didSet {
            registerButton.setTitle(NSLocalizedString("register", tableName: "Localizable", comment: ""), for: .normal)
        }
        
    }
    
    
    var activityIndicator = UIActivityIndicatorView()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func handleLogin(_ sender: Any) {
        if let email = emailTextField.text,
           let password = passwordTextField.text {
//            Activity.showIndicator(parentView: self.view, childView: activityIndicator)
            Auth.auth().signIn(withEmail: email, password: password) { authResult, error in
                if let _ = authResult {
                    if let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "tabbar") as? UIViewController {
                        vc.modalPresentationStyle = .fullScreen
//                        Activity.removeIndicator(parentView: self.view, childView: self.activityIndicator)
                        self.present(vc, animated: true, completion: nil)
                    }
                }
                if let error = error {
                    Alert.showAlert(strTitle: "Error", strMessage: error.localizedDescription, viewController: self)
                    Activity.removeIndicator(parentView: self.view, childView: self.activityIndicator)
                }
            }
        }
    }
    
    
    
}
    
    



