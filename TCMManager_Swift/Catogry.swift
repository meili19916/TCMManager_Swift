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

extension UIScrollView{
    func headRefresh() -> Void {
        
    }
}
