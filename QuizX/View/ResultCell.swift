//
//  ResultCell.swift
//  QuizX
//
//  Created by Yoshitaka on 2020/05/15.
//  Copyright © 2020 Yoshitaka. All rights reserved.
//

import UIKit

class ResultCell: UITableViewCell {

    @IBOutlet weak var resultView: UIView!
    @IBOutlet weak var resultImage: UIImageView!
    
    @IBOutlet weak var quizScoreResultLabel: UILabel!
    @IBOutlet weak var quizSetNameLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        
        resultView.layer.cornerRadius = resultView.frame.height / 5
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
