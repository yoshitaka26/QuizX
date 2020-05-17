//
//  ResultTableViewController.swift
//  QuizX
//
//  Created by Yoshitaka on 2020/05/14.
//  Copyright © 2020 Yoshitaka. All rights reserved.
//

import UIKit

class ResultTableViewController: UITableViewController {
    
    let quizDataBrain = QuizDataExcelBrain()
    let userDefault = UserDefaults.standard

    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.register(UINib(nibName: "ResultCell", bundle: nil), forCellReuseIdentifier: "resultCell")

    }

    // MARK: - Table view data source


    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return quizDataBrain.quizDataSetNameArray.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "resultCell", for: indexPath) as! ResultCell
        let quizSetName = quizDataBrain.quizDataSetNameArray[indexPath.row]
        
        cell.quizSetNameLabel.text = quizSetName
        
        if let score = userDefault.string(forKey: quizSetName) {
            cell.quizScoreResultLabel.text = "スコア " + score
        }
        let time = userDefault.integer(forKey: quizSetName + "t")
        cell.quizScoreResultLabel.text?.append(contentsOf: "                   タイム \(time)秒")
       
        return cell
    }

}
