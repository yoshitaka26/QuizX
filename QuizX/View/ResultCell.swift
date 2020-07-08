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
    
  
    @IBOutlet weak var tryLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var quizName: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        resultView.layer.cornerRadius = resultView.frame.height / 10
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
