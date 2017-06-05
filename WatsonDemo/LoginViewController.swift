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

    @IBOutlet weak var backgroundImageView: UIImageView!

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupSimulator()

        #if WATSONBANKASST
            backgroundImageView.backgroundColor =  UIColor.colorWithRGBHex(hex24: 0xCC0000)
//            backgroundImageView.image = 
        #elseif WATSONINSASST
            backgroundImageView.backgroundColor =  UIColor.colorWithRGBHex(hex24: 0xCC0000)
//            backgroundImageView.image =
        #elseif WATSONWEALTHASST
            backgroundImageView.backgroundColor =  UIColor.colorWithRGBHex(hex24: 0x0000FF)
//            backgroundImageView.image =
        #elseif WATSONWEALTHTASST  || DEBUG
            backgroundImageView.backgroundColor =  UIColor.colorWithRGBHex(hex24: 0x0000FF)
//            backgroundImageView.image =
        #elseif WATSONMETASST
            backgroundImageView.backgroundColor =  UIColor.colorWithRGBHex(hex24: 0xCC0000)
//            backgroundImageView.image =
        #elseif WATSONWHIRLASST
            backgroundImageView.backgroundColor =  UIColor.colorWithRGBHex(hex24: 0xCC0000)
//            backgroundImageView.image =
        #elseif WATSONFIDASST
            backgroundImageView.backgroundColor =  UIColor.colorWithRGBHex(hex24: 0xCC0000)
//            backgroundImageView.image =
        #elseif WATSONALFASST || DEBUG
            backgroundImageView.backgroundColor =  UIColor.colorWithRGBHex(hex24: 0x0000FF)
//            backgroundImageView.image =
        #elseif WATSONREGASST
            backgroundImageView.backgroundColor =  UIColor.colorWithRGBHex(hex24: 0xCC0000)
//            backgroundImageView.image =
        #else
            backgroundImageView.backgroundColor =  UIColor.colorWithRGBHex(hex24: 0xCC0000)
//            backgroundImageView.image =
        #endif
//      backgroundImageView.backgroundColor =  UIColor.yellow
    }


    // MARK: - Action
    @IBAction func signInButtonTapped(sender: AnyObject) {
        GlobalConstants.username = usernameTextField.text!
        GlobalConstants.password = passwordTextField.text!
        performSegue(withIdentifier: Constants.loginSegueIdentifier, sender: nil)
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
