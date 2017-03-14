//
//  PatientManagerListTableViewCell.swift
//  TCMManager_Swift
//
//  Created by HeLijuan on 17/3/14.
//  Copyright © 2017年 HeLijuan. All rights reserved.
//

import UIKit

class PatientManagerListTableViewCell: UITableViewCell {

    @IBOutlet weak var headImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var messageLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
