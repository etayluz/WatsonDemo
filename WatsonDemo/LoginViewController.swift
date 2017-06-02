//
//  LoginViewController.swift
//
//  Created by Etay Luz
//


import UIKit

final class LoginViewController: UIViewController {

    // MARK: - Constants
    private struct Constants {
        static let loginSegueIdentifier = "LoginSegue"
        static let password = "Your Password"
        static let username = "Your Email"
    }

    // MARK: - Properties
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var signInButton: UIButton!
    @IBOutlet weak var logoImageView: UIImageView!


    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupSimulator()
    }


    // MARK: - Action
    @IBAction func signInButtonTapped(sender: AnyObject) {
        performSegue(withIdentifier: Constants.loginSegueIdentifier, sender: nil)
    }

    // MARK: - Segues
    func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == Constants.loginSegueIdentifier {
            GlobalConstants.username = usernameTextField.text!
            GlobalConstants.password = passwordTextField.text!
        }
    }



    // This is a convenience method to setup email/password field dummy text during development
    // This will only execute on the simulator and NOT on a real device
    private func setupSimulator() {
        //        #if (arch(i386) || arch(x86_64)) && os(iOS)
        usernameTextField.text = Constants.username
        passwordTextField.text = Constants.password
        //        #endif
    }
}



// MARK: - UITextFieldDelegate
extension LoginViewController: UITextFieldDelegate {

    func textFieldDidEndEditing(_ textField: UITextField) {
    }

    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        return true
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {

        if textField == usernameTextField {
            passwordTextField?.becomeFirstResponder()
        } else {
            textField.resignFirstResponder()
        }
        
        return false
    }
    
}
