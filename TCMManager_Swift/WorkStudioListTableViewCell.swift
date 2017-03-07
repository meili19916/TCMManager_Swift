//
//  WorkStudioListTableViewCell.swift
//  TCMManager_Swift
//
//  Created by HeLijuan on 17/3/6.
//  Copyright © 2017年 HeLijuan. All rights reserved.
//

import UIKit

class WorkStudioListTableViewCell: UITableViewCell {

    @IBOutlet weak var isMicroClassImageView: UIImageView!
    @IBOutlet weak var detailImageView: UIImageView!
    @IBOutlet weak var readNumberLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var typeLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.typeLabel.layer.masksToBounds = true
        self.typeLabel.layer.borderColor = LineColor.cgColor
        self.typeLabel.layer.cornerRadius = 3
        self.typeLabel.layer.borderWidth = 1
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
