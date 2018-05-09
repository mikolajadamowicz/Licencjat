//
//  LoginView.swift
//  Licencjat
//
//  Created by Mikolaj Adamowicz on 01.05.2018.
//  Copyright © 2018 Mikolaj Adamowicz. All rights reserved.
//

import Foundation
import UIKit
import SwiftKeychainWrapper

class LoginViewController: UIViewController {
    
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var loginTextField: UITextField!
    
    @IBAction func loginButtonPressed(_ sender: Any) {
        let albumString = loginTextField.text!
        if loginTextField.hasText && loginTextField.text?.count == 5 {
            self.saveCredentials(albumID: albumString)
        } else {
            let alert = UIAlertController(title: "jest ZLE", message: "ma byc 5 cyferek dlugosci", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Yes", style: .default, handler: nil))
            self.present(alert, animated: true)
        }
    }
    
    func registerNewUser(){

    }
    
    func saveCredentials(albumID: String){
        let saveSuccessful: Bool = KeychainWrapper.standard.set(albumID, forKey: "albumID")
        if saveSuccessful {
            self.performSegue(withIdentifier: "toViewController", sender: nil)
        } else {
            //tutaj daj catch
        }
    }
    
}
