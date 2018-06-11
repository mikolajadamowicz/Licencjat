//
//  AddQuestionViewController.swift
//  Licencjat
//
//  Created by Mikolaj Adamowicz on 06.06.2018.
//  Copyright © 2018 Mikolaj Adamowicz. All rights reserved.
//

import UIKit

class AddQuestionViewController: UIViewController {
    //MARK: Properties
    let networking = Networking()
    @IBOutlet weak var titleInput: UITextField!
    @IBOutlet weak var textInput: UITextView!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func cancelButtonClicked(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func saveButtonClicked(_ sender: Any) {
        //safely unwrap it
        let question = Question(text: textInput.text!, title: titleInput.text!)
        //ponaprawiac bo z grubsza powinno dzialac 
        networking.addQuestion(question: question){ (result) in
            switch result {
            case .success( _):
                self.dismiss(animated: true, completion: nil)
            case .failure(let error):
                fatalError("error: \(error.localizedDescription)")
            }
        }
    }
    


    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
