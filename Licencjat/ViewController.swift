 //
//  ViewController.swift
//  Licencjat
//
//  Created by Mikolaj Adamowicz on 14.03.2018.
//  Copyright © 2018 Mikolaj Adamowicz. All rights reserved.
//

import UIKit

enum viewMode {
    case answered
    case answering
    case noQuestions
}

class ViewController: UIViewController {

    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var forButton: UIButton!
    @IBOutlet weak var againstButton: UIButton!
    @IBOutlet weak var liquidView: UIView!
    @IBOutlet weak var buttonsStackView: UIStackView!
    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet var tapGesture: UITapGestureRecognizer!
    
    var question = Question()
    let networking = Networking()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        liquidView.frame.size.height = self.view.frame.height/4 * 3.25
        liquidView.center.x = self.view.center.x
        liquidView.center.y = self.view.frame.height * 2
        changeFirstViewOpacity(mode: viewMode.noQuestions)
        self.fetchAPI()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func changeFirstViewOpacity(mode: viewMode){
        switch mode {
        case viewMode.answered:
            buttonsStackView.isHidden = true
            questionLabel.isHidden = true
        case viewMode.answering:
            buttonsStackView.isHidden = false
            questionLabel.isHidden = false
        default:
            buttonsStackView.isHidden = true
            questionLabel.isHidden = false
        }
    }
    

    func showLiquidView(){
        UIView.animate(withDuration: 1.5, animations: {
            self.changeFirstViewOpacity(mode: viewMode.answered)
            self.liquidView.center.y = self.view.center.y + self.view.frame.height/4 * 0.75
        }, completion: { finished in
            print("View animated!")
        })
    }

    @IBAction func onClick(_ sender: UIButton) {
        
//        if sender == forButton {
//            question.forCount += 1
//        } else {
//            question.againstCount += 1
//        }
//        networking.putAnswer(answer: question, completion: { (error) in
//            if let error = error {
//                fatalError(error.localizedDescription)
//            }
//        })
        showLiquidView()
    }
    
    @IBAction func onTap(_ sender: UITapGestureRecognizer) {
        print("tapuje")
        UIView.animate(withDuration: 1.5, animations: {
            self.changeFirstViewOpacity(mode: viewMode.answering)
            self.liquidView.center.x = self.view.center.x
            self.liquidView.center.y = self.view.frame.height * 2
            self.titleLabel.text = "Oczekiwanie na nową ankietę"
        }, completion: { finished in
            print("View animated!")
        })
    }
    
    func fetchAPI() {
        networking.getQuestions() { (result) in
            switch result {
            case .success(let question):
                self.question = question[0]
                self.titleLabel.text = self.question.title
                self.questionLabel.text = self.question.text
                self.changeFirstViewOpacity(mode: viewMode.answering)
            case .failure(let error):
                fatalError("error: \(error.localizedDescription)")
            }
        }
    }
    
}

