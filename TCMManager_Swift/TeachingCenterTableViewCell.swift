//
//  TeachingCenterTableViewCell.swift
//  TCMManager_Swift
//
//  Created by HeLijuan on 17/4/24.
//  Copyright © 2017年 HeLijuan. All rights reserved.
//

import UIKit

class TeachingCenterTableViewCell: UITableViewCell {
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var commentButton: UIButton!
    @IBOutlet weak var messageLabel: UILabel!
    @IBOutlet weak var agreeButton: UIButton!
    @IBOutlet weak var shareButton: UIButton!
    @IBOutlet weak var readNumberLabel: UILabel!
    @IBOutlet weak var contentLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        agreeButton.layer.masksToBounds = true
        agreeButton.layer.cornerRadius = 12
        agreeButton.layer.borderColor = commentButton.titleLabel?.textColor.cgColor
        agreeButton.layer.borderWidth = 0.5

        shareButton.layer.masksToBounds = true
        shareButton.layer.cornerRadius = 12
        shareButton.layer.borderColor = commentButton.titleLabel?.textColor.cgColor
        shareButton.layer.borderWidth = 0.5

        commentButton.layer.masksToBounds = true
        commentButton.layer.borderColor = commentButton.titleLabel?.textColor.cgColor
        commentButton.layer.borderWidth = 0.5
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
