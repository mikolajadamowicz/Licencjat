//
//  ViewController.swift
//  Licencjat
//
//  Created by Mikolaj Adamowicz on 14.03.2018.
//  Copyright © 2018 Mikolaj Adamowicz. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var forButton: UIButton!
    @IBOutlet weak var againstButton: UIButton!
    @IBOutlet weak var liquidView: UIView!
    @IBOutlet weak var buttonsStackView: UIStackView!
    @IBOutlet weak var questionLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        liquidView.frame.size.height = self.view.frame.height/4 * 3.25
        liquidView.center.x = self.view.center.x
        liquidView.center.y = self.view.frame.height * 2
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func changeFirstViewOpacity(isHidden:Bool){
        if isHidden {
            buttonsStackView.isHidden = true
            questionLabel.isHidden = true
        } else {
            buttonsStackView.isHidden = false
            questionLabel.isHidden = false
        }
    }

    @IBAction func onClick(_ sender: Any) {
        
        UIView.animate(withDuration: 1.5, animations: {
            self.changeFirstViewOpacity(isHidden: true)
            self.liquidView.center.y = self.view.center.y + self.view.frame.height/4 * 0.75
        }, completion: { finished in
            print("View animated!")
        })
        
        
    }
    
}

