//
//  ConstManager.swift
//  TCMManager_Swift
//
//  Created by HeLijuan on 17/2/7.
//  Copyright © 2017年 HeLijuan. All rights reserved.
//

import UIKit

let ScreenWidth = UIScreen.main.bounds.width
let ScreenHeight = UIScreen.main.bounds.height

////分页页数
let  PerPageTwentyCount  = 20
let  PerPageTenCount = 10
////int型转换为string
func IntToString(intValue:Int) -> NSString{
    return NSString.init(format: "%d", intValue)
}
////限制数字输入
let NumberVelues = "0123456789"

////默认间距
let  ViewSpace:CGFloat  = 10.0
let  HorizontalViewSpace = 15
let  ButtonNomalHeight  = 48
let  ButtonLitterHeight  = 35
////色值设置
func RGBA(red:CGFloat,green:CGFloat,blue:CGFloat,alpha:CGFloat) -> UIColor{
    return UIColor.init(red: red/255, green: green/255, blue: blue/255, alpha: alpha)
}
////通用颜色
let MainColor = RGBA(red: 39,green: 198,blue: 132,alpha: 1) //用于导航,特别提示,突出地方,按钮等
let TextColor  = RGBA(red: 34,green: 34,blue: 34,alpha: 1)//用于大板块标题,主要内容,图标名称等
let  GrayTextColor =  RGBA(red: 102, green: 102, blue: 102, alpha: 1)//用于普通段落,次级文字等
let NotifyTextColor = RGBA(red: 153, green: 153, blue: 153, alpha: 1)//用于辅助文字,提示文字等
let ReadTextColor  = RGBA(red: 189,green: 189,blue: 189,alpha: 1)//用于已经阅读了的标记字体
let UnalbleColor =  RGBA(red: 215, green: 215, blue: 215, alpha: 1)//主要按钮标签描边,不可用等
let LineColor = RGBA(red: 229, green: 229, blue: 229, alpha: 1)//用于分割线
let  LeaveColor = RGBA(red: 210,green: 210,blue: 210,alpha: 1) //代码里面 整理的时候很多都是用的这个颜色
let BackgroundColor = RGBA(red: 241,green: 241,blue: 241,alpha: 1)//用于整体底色
let LightBackGroundColor = RGBA(red: 250,green: 250,blue: 250,alpha: 1) //用于标签栏底色,模块底色
let NavigationBackGroundColor = MainColor //用于标签栏底色,模块底色
let  GroupTableViewBackgroundColor  = UIColor.groupTableViewBackground; //sectionheader的背景色
let RedColor = RGBA(red: 239, green: 63, blue: 61, alpha: 1)//用于警示,强烈提示按钮等
let YellowColor = RGBA(red: 253,green: 194,blue: 32,alpha: 1) //用于跟金钱有关的文字等
let AuthenticationColor = RGBA(red: 247,green: 121,blue: 120,alpha: 1) //用于跟金钱有关的文字等
//
////系统字体
let TitleFont = UIFont.systemFont(ofSize: 17)
let NOBackgroundNavigationRightFont = UIFont.systemFont(ofSize: 16)
let MainFont = UIFont.systemFont(ofSize: 15)//用于大板块标题,主要内容,图标名称等
let GrayFont = UIFont.systemFont(ofSize: 14)//用于普通段落,次级文字等
let NotifyFont = UIFont.systemFont(ofSize: 12) //Nofity字体颜色
let NavigationRightFont = GrayFont //导航栏右侧的字体

let  PRE_URL = "http://1tohome.com/device"//测试

class ConstManager: NSObject {

}
