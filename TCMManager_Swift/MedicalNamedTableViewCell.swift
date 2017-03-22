//
//  MedicalRecordNamedTableViewCell.swift
//  TCMManager_Swift
//
//  Created by HeLijuan on 17/3/22.
//  Copyright © 2017年 HeLijuan. All rights reserved.
//

import UIKit

class MedicalNamedTableViewCell: UITableViewCell {
    @IBOutlet weak var medicalImageView: UIImageView!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var diagnossLabel: UILabel!

    @IBOutlet weak var nameLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        medicalImageView.layer.masksToBounds = true
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
