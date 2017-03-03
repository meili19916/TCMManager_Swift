//
//  WorkStudioItemTableViewCell.swift
//  TCMManager_Swift
//
//  Created by HeLijuan on 17/3/3.
//  Copyright © 2017年 HeLijuan. All rights reserved.
//

import UIKit
class WorkStudioItemTableViewCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        for  button  in self.contentView.subviews {
            let buttom:UIButton = button as! UIButton
            buttom.positionLabelRespectToImage(title: (buttom.titleLabel?.text)!, position: .bottom, spacing: 0)
        }
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
