//
//  MainListTableViewCell.swift
//  TCMManager_Swift
//
//  Created by HeLijuan on 17/3/2.
//  Copyright © 2017年 HeLijuan. All rights reserved.
//

import UIKit

class MineListTableViewCell: UITableViewCell {

    @IBOutlet weak var headImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
