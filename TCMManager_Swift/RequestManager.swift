//
//  RequestManager.swift
//  TCMManager_Swift
//
//  Created by HeLijuan on 17/2/16.
//  Copyright © 2017年 HeLijuan. All rights reserved.
//

import UIKit
import SwiftyJSON
enum VertifyType:Int{
  case  Registe = 1
   case FindPassword
   case ChangePassword
   case Others
   case ChangePhone = 6
}
class RequestManager: NSObject {
  static  func getTimeSpace() -> Void {
        NetWorkingManager.sharedInstance.get(url: PRE_URL.appending("/auth/get-server-time"), params: nil) { (data) in
            if data.0.rawValue == RequestStatusCode.Success.rawValue {
                let serverTime:Int64 = JSON(data:data.1 as! Data).int64Value
                let date:Date = Date.init()
                let time:Int64 = Int64(date.timeIntervalSince1970)
                let distance:Int64 = serverTime + serverTime - time
                UserDefaults.standard.set(String(distance), forKey: "timeSpace")
                UserDefaults.standard.synchronize()
            }else{
                if  UserDefaults.standard.object(forKey: "timeSpace") == nil{
                    UserDefaults.standard.set("0", forKey: "timeSpace")
                    UserDefaults.standard.synchronize()
                }
            }
        }
    }
    static func login(phone:String,password:String,complete:@escaping RequestSuccessClosure,failed:@escaping RequestFailedClosure) -> Void{
        let params:Dictionary<String,String> = ["phone":phone,"password":password.md5]
        NetWorkingManager.sharedInstance.post(url: PRE_URL.appending("/auth/login"), params: params) { (data) in
            if data.0.rawValue == RequestStatusCode.Success.rawValue {
                let loginModel = Mapper<LoginUserModel>().map(JSONString: data.1 as! String)
                loginModel?.phone = phone
                loginModel?.password = password
                UserDefaults.standard.set(loginModel?.toJSONString(), forKey: "userModel")
                UserDefaults.standard.synchronize()
                complete(loginModel)
            }else{
                failed(data)
            }
        }
    }
    static func findPassword(phone:String,password:String,verifyNumber:String,complete:@escaping RequestSuccessClosure,failed:@escaping RequestFailedClosure) -> Void{
        let params:Dictionary<String,String> = ["phone":phone,"newPassword":password.md5,"captcha":verifyNumber]
        NetWorkingManager.sharedInstance.post(url: PRE_URL.appending("/auth/find-password"), params: params) { (data) in
            if data.0.rawValue == RequestStatusCode.Success.rawValue {
                let loginModel = Mapper<LoginUserModel>().map(JSONString: data.1 as! String)
                loginModel?.phone = phone
                loginModel?.password = password
                UserDefaults.standard.set(loginModel?.toJSONString(), forKey: "userModel")
                UserDefaults.standard.synchronize()
                complete(loginModel)
            }else{
                failed(data)
            }
        }
    }

    static func register(phone:String,password:String,verifyNumber:String,voiceNumber:String?,complete:@escaping RequestSuccessClosure,failed:@escaping RequestFailedClosure) -> Void{
        var params:Dictionary<String,String>
        if voiceNumber != nil {
            params = ["phone":phone,"password":password.md5,"captcha":verifyNumber,"doctorNumber":voiceNumber!]
        }else{
            params = ["phone":phone,"password":password.md5,"captcha":verifyNumber]
        }
        NetWorkingManager.sharedInstance.post(url: PRE_URL.appending("/auth/register"), params: params) { (data) in
            if data.0.rawValue == RequestStatusCode.Success.rawValue {
                let loginModel = Mapper<LoginUserModel>().map(JSONString: data.1 as! String)
                loginModel?.phone = phone
                loginModel?.password = password
                UserDefaults.standard.set(loginModel?.toJSONString(), forKey: "userModel")
                UserDefaults.standard.synchronize()
                complete(loginModel)
            }else{
                failed(data)
            }
        }
    }

    static func sendSMS(phone:String,type:VertifyType,complete:@escaping RequestSuccessClosure,failed:@escaping RequestFailedClosure) -> Void{
        let params:Dictionary<String,String> = ["phone":phone,"type":String(type.rawValue)]
        NetWorkingManager.sharedInstance.post(url: PRE_URL.appending("/auth/send-sms"), params: params) { (data) in
            if data.0.rawValue == RequestStatusCode.Success.rawValue {
                complete(data.1)
            }else{
                failed(data)
            }
        }
    }


    //MARK:工作室
    static func getCourseAndMicroclassList(pageIndex:Int,pageSize:Int,complete:@escaping RequestSuccessClosure,failed:@escaping RequestFailedClosure) -> Void{
        let params:Dictionary<String,Any> = ["pageIndex":String(pageIndex),"pageSize":String(pageSize),"token":UserManager.sharedInstance.currentUser?.token ?? ""]

        NetWorkingManager.sharedInstance.get(url: PRE_URL.appending("/common/course/get-mix-list"), params: params) { (data) in
            if data.0.rawValue == RequestStatusCode.Success.rawValue {
                let jsonData = Mapper<CourseMicroClassModel>().mapArray(JSONString: data.1 as! String)
                complete(jsonData)
            }else{
                failed(data)
            }
        }
    }

    static func getActivityList(showType:Int,complete:@escaping RequestSuccessClosure,failed:@escaping RequestFailedClosure) -> Void{
        let params:Dictionary<String,Any> = ["showType":String(showType),"token":UserManager.sharedInstance.currentUser?.token ?? ""]
        NetWorkingManager.sharedInstance.get(url: PRE_URL.appending("/common/get-activity-list"), params: params) { (data) in
            if data.0.rawValue == RequestStatusCode.Success.rawValue {
                let jsonData = Mapper<ActivityListModel>().mapArray(JSONString: data.1 as! String)
                complete(jsonData)
            }else{
                failed(data)
            }
        }
    }

    static func getPatientMessageList(complete:@escaping RequestSuccessClosure,failed:@escaping RequestFailedClosure) -> Void{
        let params:Dictionary<String,Any> = ["page":"1","pageSize":"200","token":UserManager.sharedInstance.currentUser?.token ?? ""]
        NetWorkingManager.sharedInstance.get(url: PRE_URL.appending("/common/get-theme-list-one"), params: params) { (data) in
            if data.0.rawValue == RequestStatusCode.Success.rawValue {
                let jsonData = Mapper<PatientMessageListModel>().mapArray(JSONString: data.1 as! String)
                complete(jsonData)
            }else{
                failed(data)
            }
        }
    }
}
