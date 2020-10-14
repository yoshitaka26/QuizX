//
//  NewQuizTableViewController.swift
//  QuizX
//
//  Created by Yoshitaka on 2020/05/29.
//  Copyright © 2020 Yoshitaka. All rights reserved.
//

import UIKit

class NewQuizTableViewController: UITableViewController {
    
    var newQuizArray: [QuizDataSet] = []
    
    let myQuizDataModel = MyQuizDataModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let myQuiz = myQuizDataModel.loadItems() {
                  newQuizArray = myQuiz
              }
        
        self.navigationItem.hidesBackButton = true
        
        let backBarButtonItem = UIBarButtonItem()
                    backBarButtonItem.title = ""
                    self.navigationItem.backBarButtonItem = backBarButtonItem
        
    }
    
    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return newQuizArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "NewQuiz", for: indexPath)
        
        cell.textLabel?.text = newQuizArray[indexPath.row].question
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "ToChangeNewQuiz", sender: self)
    }
    
    @IBAction func backButtonPressed(_ sender: UIBarButtonItem) {
        performSegue(withIdentifier: "ToCreateQuizMain", sender: self)
        
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ToChangeNewQuiz" {
            let destinationVC = segue.destination as! changeNewQuizViewController
            
            destinationVC.newQuizArray = newQuizArray
            
            if let indexPath = tableView.indexPathForSelectedRow {
                destinationVC.quizNumber = indexPath.row
            }
            
        } else if segue.identifier == "ToCreateQuizMain" {
            let destinationVC = segue.destination as! CreateQuizMainViewController
            
            destinationVC.navigationItem.hidesBackButton = true
        }
    }
    
}
