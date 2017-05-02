//
//  BannerTableViewCell.swift
//  TCMManager_Swift
//
//  Created by HeLijuan on 17/3/9.
//  Copyright © 2017年 HeLijuan. All rights reserved.
//

import UIKit
protocol BannerCellDelegate : class {
    func clickedBannerView(selectedIndex index: Int)
}
class BannerTableViewCell: UITableViewCell,YLCycleViewDelegate {
    var bannerView:YLCycleView?
    weak var delegate : BannerCellDelegate?

    override func awakeFromNib() {
        super.awakeFromNib()
        bannerView?.backgroundColor = UIColor.white
        // Initialization code
    }

    func setImageArray(array:Array<ActivityListModel>) -> Void {
        var images: Array<String> = Array.init()
        for model in array {
            images.append(model.imageUrl)
        }
        let titles = ["Raindew","无限轮播", "QQ群：511860085", "欢迎加入", "帅的人已经Star"]
       bannerView  = YLCycleView(frame: CGRect(x: 0, y: 0, width: self.bounds.width, height: 100), images: images, titles: titles)
        bannerView?.delegate = self
        self.addSubview(bannerView!)
    }
    func clickedCycleView(_ cycleView: YLCycleView, selectedIndex index: Int) {
        if (delegate != nil) {
            delegate?.clickedBannerView(selectedIndex: index)
        }
    }

       override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
