//
//  SettingWithSwitchTableViewCell.swift
//  TCMManager_Swift
//
//  Created by HeLijuan on 17/4/24.
//  Copyright © 2017年 HeLijuan. All rights reserved.
//

import UIKit

class SettingWithSwitchTableViewCell: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var `switch`: UISwitch!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    @IBAction func switchChanged(_ sender: Any) {
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
