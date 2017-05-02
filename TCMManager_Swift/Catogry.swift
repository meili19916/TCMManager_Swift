//
//  Catogry.swift
//  TCMManager_Swift
//
//  Created by HeLijuan on 17/2/15.
//  Copyright © 2017年 HeLijuan. All rights reserved.
//
import Foundation

extension String {
    var md5: String! {
        let str = self.cString(using: String.Encoding.utf8)
        let strLen = CC_LONG(self.lengthOfBytes(using: String.Encoding.utf8))
        let digestLen = Int(CC_MD5_DIGEST_LENGTH)
        let result = UnsafeMutablePointer<CUnsignedChar>.allocate(capacity: digestLen)
        CC_MD5(str!, strLen, result)
        return stringFromBytes(bytes: result, length: digestLen)
    }

    var sha1: String! {
        let str = self.cString(using: String.Encoding.utf8)
        let strLen = CC_LONG(self.lengthOfBytes(using: String.Encoding.utf8))
        let digestLen = Int(CC_SHA1_DIGEST_LENGTH)
        let result = UnsafeMutablePointer<CUnsignedChar>.allocate(capacity: digestLen)
        CC_SHA1(str!, strLen, result)
        return stringFromBytes(bytes: result, length: digestLen)
    }

    func stringFromBytes(bytes: UnsafeMutablePointer<CUnsignedChar>, length: Int) -> String{
        let hash = NSMutableString()
        for i in 0..<length {
            hash.appendFormat("%02x", bytes[i])
        }
        bytes.deallocate(capacity: length)
        return String(format: hash as String)
    }


    private   func stringFromResult(result: UnsafeMutablePointer<CUnsignedChar>, length: Int) -> String {
        let hash = NSMutableString()
        for i in 0..<length {
            hash.appendFormat("%02x", result[i])
        }
        return String(hash)
    }

    func isValued() -> Bool {
        if (self.characters.count == 0) {
            return false
        }
        return true
    }
}

extension Dictionary {

    var getMD5AndBase64EncryptWithDictionay:String! {
        let selfCopy:Dictionary = self
        let secret = "mingyi!@#$%"
        let sortedKeys = selfCopy.keys.sorted { (a, b) -> Bool in
            return (a as! String) < (b as! String) ? true : false
        }
        var kvStr = ""
        for key in sortedKeys {
            kvStr += key as! String
            kvStr += self[key] as! String
        }
        kvStr += secret

        let str = kvStr.cString(using: String.Encoding.utf8)
        let strLen = CC_LONG(kvStr.lengthOfBytes(using: String.Encoding.utf8))
        let digestLen = Int(CC_MD5_DIGEST_LENGTH)
        let result = UnsafeMutablePointer<CUnsignedChar>.allocate(capacity: digestLen)
        CC_MD5(str!, strLen, result)
        let data:Data = Data.init(bytes: result, count: Int(CC_MD5_DIGEST_LENGTH))
        return data.base64EncodedString(options: [])
    }
}

extension UITableView{

    func removeExtraFooterView() -> Void {
        self.tableFooterView = UIView()
    }
}

extension UIButton {

    @objc func set(image anImage: UIImage?, title: String,
                   titlePosition: UIViewContentMode, additionalSpacing: CGFloat, state: UIControlState){
        self.imageView?.contentMode = .center
        self.setImage(anImage, for: state)

        positionLabelRespectToImage(title: title, position: titlePosition, spacing: additionalSpacing)

        self.titleLabel?.contentMode = .center
        self.setTitle(title, for: state)
    }

     func positionLabelRespectToImage(title: String, position: UIViewContentMode,
                                             spacing: CGFloat) {
        let imageSize = self.imageRect(forContentRect: self.frame)
        let titleFont = self.titleLabel?.font!
        let titleSize = title.size(attributes: [NSFontAttributeName: titleFont!])

        var titleInsets: UIEdgeInsets
        var imageInsets: UIEdgeInsets

        switch (position){
        case .top:
            titleInsets = UIEdgeInsets(top: -(imageSize.height + titleSize.height + spacing),
                                       left: -(imageSize.width), bottom: 0, right: 0)
            imageInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: -titleSize.width)
        case .bottom:
            titleInsets = UIEdgeInsets(top: (imageSize.height + titleSize.height + spacing - 12),
                                       left: -(imageSize.width), bottom: 0, right: 0)
            imageInsets = UIEdgeInsets(top: -12, left: 0, bottom: 0, right: -titleSize.width)
        case .left:
            titleInsets = UIEdgeInsets(top: 0, left: -(imageSize.width * 2), bottom: 0, right: 0)
            imageInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0,
                                       right: -(titleSize.width * 2 + spacing))
        case .right:
            titleInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: -spacing)
            imageInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        default:
            titleInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
            imageInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        }
        
        self.titleEdgeInsets = titleInsets
        self.imageEdgeInsets = imageInsets
    }
}

extension UIViewController{
    func checkToken(requestCode:RequestStatusCode) -> Void {
        if requestCode.rawValue == RequestStatusCode.TokenNoEffect.rawValue || requestCode.rawValue == RequestStatusCode.TokenOutDate.rawValue  {
            self.navigationController?.pushViewController(LoginViewController(), animated: true)
        }
    }
}

extension UIImageView{
    func setImageUrl(url:String) -> Void {
            self.kf.setImage(with: URL.init(string: url), placeholder: UIImage.init(named: "defaultImage"),progressBlock: { (receivedSize, totalSize) in

            }) { (image, error, cacheType, imageURL) in

        }
    }
    func setImageUrlWithDefualt(url:String,defualtImage:String?) -> Void {
        if !(defualtImage?.isValued())! {
            self.setImageUrl(url: url)
            return
        }
        self.kf.setImage(with: URL.init(string: url), placeholder: UIImage.init(named: defualtImage!),progressBlock: { (receivedSize, totalSize) in
            
        }) { (image, error, cacheType, imageURL) in

        }
    }
}

extension Date{
    func formateDate() -> String {
        let now = Date.init()
        let beTime = self.timeIntervalSince1970
        let distanceTime = now.timeIntervalSince1970 - beTime;
        var distanceStr:String

        let df = DateFormatter.init()
        df.dateFormat = "HH:mm"
        let timeStr = df.string(from: self)
        df.dateFormat = "dd"
        let nowDay = df.string(from: now)
        let lastDay = df.string(from: self)

        if (distanceTime < 60) {//小于一分钟
            distanceStr = "刚刚";
        }else if (distanceTime < 3600) {//时间小于一个小时
            distanceStr =  String(distanceTime/60) + "分钟前"
        }else if(distanceTime < 24*60*60 && Int(nowDay) == Int(lastDay)){//时间小于一天
            distanceStr = "今天" + timeStr
        }else if(distanceTime<24*60*60*2 && Int(nowDay) != Int(lastDay)){

            if ((Int(nowDay)! - Int(lastDay)! == 1 ) || (Int(nowDay)! - Int(lastDay)! > 10 && Int(nowDay)! == 1)) {
                distanceStr = "昨天" + timeStr
            }
            else{
                df.dateFormat = "MM-dd HH:mm"
                distanceStr = df.string(from: self)
            }
        }
        else if(distanceTime < 24*60*60*365){
            df.dateFormat = "MM-dd HH:mm"
            distanceStr = df.string(from: self)
        }
        else{
            df.dateFormat = "yyyy-MM-dd HH:mm"
            distanceStr = df.string(from: self)
        }
        return distanceStr;
    }
    static func formateDate(timeVal:Double,format:String) -> String{
        let date = Date.init(timeIntervalSince1970: timeVal)
        let formatter = DateFormatter.init()
        formatter.dateFormat = format
       return  formatter.string(from: date)
    }
}

extension UILabel{
    func setMutableAttributedLineSpace(lineSpace:CGFloat) -> Void {
        if self.attributedText != nil {
//            let style = NSMutableParagraphStyle.init()
//            style.lineSpacing = lineSpace
//            self.attributedText.at
//
//            NSMutableParagraphStyle *style = [[NSMutableParagraphStyle alloc] init];
//            [style setLineSpacing:lineSpacing];
//            [attStr addAttribute:NSParagraphStyleAttributeName value:style range:NSMakeRange(0,attStr.length)];
        }
    }
}

