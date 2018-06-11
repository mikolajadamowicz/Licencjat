//
//  QuestionsTableViewController.swift
//  Licencjat
//
//  Created by Mikolaj Adamowicz on 04.06.2018.
//  Copyright © 2018 Mikolaj Adamowicz. All rights reserved.
//

import UIKit

class QuestionsTableViewController: UITableViewController {
    //MARK: Properties
    
    @IBOutlet weak var addButton: UIBarButtonItem!
    var questions = [Question]()
    let networking = Networking()
    //MARK: Private Methods
    private func loadSampleQuestions(){
        questions = [Question.init(text:"to jest pierwszy text",title:"BAzowy tytul 1"),
                     Question.init(text:"to jest drugi text",title:"BAzowy tytul 2"),
                     Question.init(text:"to jest trzeci text",title:"BAzowy tytul 3")
        ]
    }
    
    private func loadQuestions(){
        networking.getQuestions() { (result) in
            switch result {
            case .success(let questions):
                self.questions = questions
                self.tableView.reloadData()
            case .failure(let error):
                fatalError("error: \(error.localizedDescription)")
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadSampleQuestions()
        loadQuestions()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
//         self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    
    override func viewDidAppear(_ animated: Bool) {
        loadQuestions()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return questions.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellIdentifier = "QuestionTableViewCell"
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? QuestionTableViewCell  else {
            fatalError("The dequeued cell is not an instance of QuestionTableViewCell.")
        }
        let question = questions[indexPath.row]

        cell.titleLabel.text = question.title.description
        cell.forLabel.text = question.forCount.description
        cell.againstLabel.text = question.againstCount.description

        return cell
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if (segue.identifier == "toViewCotroller") {
            // pass data to next view
            if let indexPath = tableView.indexPathForSelectedRow{
                let selectedRow = indexPath.row
                let destinationVC = segue.destination as! ViewController
                destinationVC.question = self.questions[selectedRow]
            }
        }
    }
 

}
