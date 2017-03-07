//
//  MBProgressHUDManager.swift
//  TCMManager_Swift
//
//  Created by HeLijuan on 17/2/24.
//  Copyright © 2017年 HeLijuan. All rights reserved.
//

import UIKit
enum ShowHUDType {
    case Loading
    case Text
}
class MBProgressHUDManager: NSObject {
     var hud:MBProgressHUD?
    static let sharedInstance = MBProgressHUDManager()
    override init(){
    }
    func show(type:ShowHUDType,text:String?, detailText:String?,onView:UIView) -> Void {
        switch type {
        case .Loading:
                hud = MBProgressHUD.showAdded(to: onView, animated: true)
                hud?.label.text = text
                //背景渐变效果
                hud?.backgroundView.style = .solidColor
        case .Text:
            if hud?.superview == onView {
                self.dissmiss()
            }
            hud = MBProgressHUD.showAdded(to: onView, animated: true)
            hud?.mode = MBProgressHUDMode.text
            hud?.label.text = text
            hud?.detailsLabel.text = detailText
            hud?.hide(animated: true, afterDelay: 0.8)
        }
    }
    func dissmiss() -> Void {
        hud?.hide(animated: true, afterDelay: 0)
    }
}
