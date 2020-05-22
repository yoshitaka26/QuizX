//
//  ResultTableViewController.swift
//  QuizX
//
//  Created by Yoshitaka on 2020/05/14.
//  Copyright © 2020 Yoshitaka. All rights reserved.
//

import UIKit

class ResultTableViewController: UITableViewController {
    
    var quizNamesArray: [String] = []
    
    let quizDataBrain = QuizDataExcelBrain()
    let userDefault = UserDefaults.standard
    let quizNames = QuizName()

    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.register(UINib(nibName: "ResultCell", bundle: nil), forCellReuseIdentifier: "resultCell")

    }

    // MARK: - Table view data source


    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return quizNamesArray.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "resultCell", for: indexPath) as! ResultCell
        let quizSetName = quizNamesArray[indexPath.row]
        
        cell.quizSetNameLabel.text = quizSetName
        
        let name = quizNames.quizName[indexPath.row]
        
        if let data = userDefault.array(forKey: name) as? [Int] {
            cell.quizScoreResultLabel.text = "スコア \(data[0]) / \(data[1])\nタイム \(data[2])秒\nトライ \(data[3])回"
        }
        
        return cell
    }

}
