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

enum usersType {
    case student
    case teacher
    case notAllowed
}

class LoginViewController: UIViewController {
    //MARK: Properties
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var loginTextField: UITextField!
    let networking = Networking()
    var users = Users()
    var userType = usersType.notAllowed
    var albumString = String()
    
    override func viewDidLoad() {
        loadUsers()
    }
    
    @IBAction func loginButtonPressed(_ sender: Any) {
        albumString = loginTextField.text!
        if loginTextField.hasText && loginTextField.text?.count == 6 {
            self.saveCredentials(albumID: albumString)
        } else {
            let alert = UIAlertController(title: "Zly numer albumu", message: "numery maja długość 6 cyfr", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Yes", style: .default, handler: nil))
            self.present(alert, animated: true)
        }
    }
    
    private func authenticateUser(){
        if users.students.contains(albumString) {
            userType = .student
        } else if users.teachers.contains(albumString) {
            userType = .teacher
        }
    }
    
    private func loadUsers(){
        networking.getUsers() { (result) in
            switch result {
            case .success(let users):
                self.users = users
                self.authenticateUser()
            case .failure(let error):
                fatalError("error: \(error.localizedDescription)")
            }
        }
    }
    
    func saveCredentials(albumID: String){
        let saveSuccessful: Bool = KeychainWrapper.standard.set(albumID, forKey: "albumID")
        if saveSuccessful {
            self.performSegue(withIdentifier: "toQuestionsTableViewController", sender: nil)
        } else {
            //tutaj daj catch
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "toQuestionsTableViewController") {
            // pass data to next view
            let destinationVC = segue.destination as! QuestionsTableViewController
            if userType == .student {
                destinationVC.addButton.isEnabled = false
            }
        }
    }
    
}
