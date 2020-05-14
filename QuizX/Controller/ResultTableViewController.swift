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
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.rowHeight = 100

    }

    // MARK: - Table view data source

//    override func numberOfSections(in tableView: UITableView) -> Int {
//        // #warning Incomplete implementation, return the number of sections
//        return 0
//
//    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return quizDataBrain.quizDataSetNameArray.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        // Configure the cell...

        return cell
    }

}
