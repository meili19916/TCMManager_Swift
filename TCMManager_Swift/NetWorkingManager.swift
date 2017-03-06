//
//  NetWorkingManager.swift
//  TCMManager_Swift
//
//  Created by HeLijuan on 17/2/8.
//  Copyright © 2017年 HeLijuan. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
typealias RequestCompletedClosure = ((statusCode:Bool,result:Any?))->Void
typealias RequestSuccessClosure = (_ result:Any?)->Void
typealias RequestFailedClosure = (_ result:Any?)->Void

class NetWorkingManager: NSObject {
    var netWorkStatusManager:NetworkReachabilityManager?
    var netWorkingStatus:NetworkReachabilityManager.NetworkReachabilityStatus = .reachable(.wwan)
    var manager:Alamofire.SessionManager?

    static let sharedInstance = NetWorkingManager()
    override init(){
        manager = Alamofire.SessionManager.default
    }

    func get(url:String!, params:Dictionary<String, Any>?, completeHandler:@escaping RequestCompletedClosure) -> Void {
        var params = params
        if (netWorkingStatus == NetworkReachabilityManager.NetworkReachabilityStatus.notReachable || netWorkingStatus == NetworkReachabilityManager.NetworkReachabilityStatus.unknown) {
            completeHandler((false,"网络连接失败"))
            return
        }
        var requestHeader:HTTPHeaders?
        params?["appTime"] = self.getTimeSpace()
        if (params != nil) {
            requestHeader  = [
                "digest": (params?.getMD5AndBase64EncryptWithDictionay)!,
                "User-Agent" : "1,3.2.4,iPhone,10.2,",
                "Accept-Language" : "en;q=1"
            ]
        }
            manager?.request(url,parameters: params,headers:requestHeader).responseJSON(completionHandler: {
                (response) in
                self.requestSuccessHandle(response: response, completeHandler: completeHandler)
            })
    }
    func post(url:String!, params:Dictionary<String, Any>?, completeHandler:@escaping RequestCompletedClosure) -> Void {
        var params = params
        if (netWorkingStatus == NetworkReachabilityManager.NetworkReachabilityStatus.notReachable || netWorkingStatus == NetworkReachabilityManager.NetworkReachabilityStatus.unknown) {
            completeHandler((false,"网络连接失败"))
            return
        }
        var requestHeader:HTTPHeaders?
        params?["appTime"] = self.getTimeSpace()
        if (params != nil) {
          requestHeader  = [
                "digest": (params?.getMD5AndBase64EncryptWithDictionay)!,
            ]
        }
        manager?.request(url, method: .post,parameters: params,headers:requestHeader).responseJSON(completionHandler: {
            (response) in
            self.requestSuccessHandle(response: response, completeHandler: completeHandler)
        })
    }
    func postJsonData(url:String!,params:Dictionary<String, Any>?, completeHandler:@escaping RequestCompletedClosure) -> Void {
        var params = params

        if (netWorkingStatus == NetworkReachabilityManager.NetworkReachabilityStatus.notReachable || netWorkingStatus == NetworkReachabilityManager.NetworkReachabilityStatus.unknown) {
            completeHandler((false,"网络连接失败"))
            return
        }
        var requestHeader:HTTPHeaders?
        params?["appTime"] = self.getTimeSpace()
        if (params != nil) {
            requestHeader  = [
                "digest": (params?.getMD5AndBase64EncryptWithDictionay)!
            ]
        }
        manager?.request(url, method: .post,encoding: JSONEncoding.default,headers:requestHeader).responseJSON(completionHandler: {
            (response) in
            self.requestSuccessHandle(response: response, completeHandler: completeHandler)
        })

    }

    func upload(dataArray:Array<Any>,completeHandler:@escaping RequestCompletedClosure) -> Void {
        if (netWorkingStatus == NetworkReachabilityManager.NetworkReachabilityStatus.notReachable || netWorkingStatus == NetworkReachabilityManager.NetworkReachabilityStatus.unknown) {
            completeHandler((false,"网络连接失败"))
            return
        }
        manager?.upload(
            multipartFormData: { multipartFormData in
                for data in dataArray{
                    multipartFormData.append(data as! Data, withName: "data")
                }
        }, to: PRE_URL,encodingCompletion: { encodingResult in
            switch encodingResult {
            case .success(let upload, _, _):
                upload.responseJSON(completionHandler: {
                    (response) in
                    self.requestSuccessHandle(response: response, completeHandler: completeHandler)
                })
            case .failure(let encodingError):
                completeHandler((false,encodingError))
            }
        }
        )
    }

    func requestSuccessHandle(response:DataResponse<Any>,completeHandler:RequestCompletedClosure) -> Void {
        switch response.result {
        case .success( _):
            let baseModel = JSON(data: response.data!)
            let userName = baseModel["errorCode"].intValue
            if userName == 1000 {
                let data = baseModel["data"]
                if data.type == .number || data.type == .string || data.type == .bool {
                    let modelData:Data = baseModel["data"].stringValue.data(using: String.Encoding.utf8)!
                    completeHandler((true,modelData))
                }else{
                    completeHandler((true,data.rawString()))
                }
            }else{
                completeHandler((false,baseModel["errorMessage"].stringValue))
            }
        case .failure(let error):
            completeHandler((false,error))
        }
    }


    func setNetWorkingStatus() -> Void {
        netWorkStatusManager = NetworkReachabilityManager(host: "www.apple.com")
        netWorkStatusManager?.listener = { status in
            self.netWorkingStatus = status
            RequestManager.getTimeSpace()
        }
        netWorkStatusManager?.startListening()
    }

    func getTimeSpace() -> NSString? {
        if UserDefaults.standard.object(forKey: "timeSpace") == nil {
            return "0"
        }else{
            return UserDefaults.standard.object(forKey: "timeSpace") as! NSString?
        }
    }


}


