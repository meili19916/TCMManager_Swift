//
//  Models.swift
//  TCMManager_Swift
//
//  Created by HeLijuan on 17/2/16.
//  Copyright © 2017年 HeLijuan. All rights reserved.
//

import Foundation
import SwiftyJSON

enum VertifyStatusType:Int {
    case Veritifyed = 1
    case Veritifing
    case NoVertify
    case Refused
}

class LoginUserModel:Mappable {
    var qrcodeUrl: String = ""
    var status: Int?
    var doctorId: String?
    var name: String?
    var avatarUrl: String = ""
    var token: String?
    var title: String?
    var level: Int?
    var expires: Int64?
    //方便本地存储用户再次登陆显示数据字段
    var assistantId:String?
    var assistantAvatarUrl:String = "" //助手头像
    var assistantUserName:String? //助手名字
    var assistantRemark:String? //助手备注
    var phone:String?//用户手机号
    var password:String? //用户密码
    var isLogout:String? //是否已退出
    var myMoney:String? //用户资产
    var unApproveMoney:String? //助手头像
    var myMoneyOriginal:String? //助手名字
    var unApproveMoneyOriginal:String? //助手备注
    var isShowNotifyHead:String? //助手头像
    var doctorDetials:String? //助手名字
    var appConstValueArray:String? //助手备注
    var currentUploadConsiliaId:String? //助手名字
    var currentEditConsiliaId:String? //助手备注var assistantId:String?
    var isUpload:String? //助手头像
    var isStopUpload:String? //助手名字
    var maunalToUpload:String? //助手备注
//    @property (nonatomic, strong) NSString <Optional>*unApproveMoney;//为认证医生体现金额
//    @property (nonatomic,strong) NSString <Optional>*myMoneyOriginal;//所有余额
//    @property (nonatomic,strong) NSString <Optional>*unApproveMoneyOriginal;//未认证通过的余额
//    @property (nonatomic,strong) NSNumber <Optional>*isShowNotifyHead;//判断是否进行头像点击提示界面（no为显示，yes不显示）
//    @property (nonatomic,strong) DoctorDetailsData <Optional>*doctorDetials;//医生详情
//    @property (nonatomic,strong) NSArray <Optional,GetAppConstantListData>*appConstValueArray;//应用常量
//    @property (nonatomic,strong) NSString <Optional>*currentUploadConsiliaId;//当前正在上传的病案的consiliaId
//    @property (nonatomic,strong) NSString <Optional>*currentEditConsiliaId;//当前正在编辑的病案的consiliaId
//    @property (nonatomic,strong) NSNumber <Optional>*isUpload;//是否正在上传
//    @property (nonatomic ,strong) NSNumber <Optional> *isStopUpload;//是否停止上传
//    @property (nonatomic,strong) NSNumber <Optional> *maunalToUpload;//手动上传

//    @property (nonatomic,strong) NSString <Optional>*subscriptionPrice;//预约门诊默认价格
//    @property (nonatomic, copy) NSString <Optional>*prescriptionOfficeVisit;//处方预约默认门诊费
//    @property (nonatomic,strong) NSString <Optional>*subscriptionTimeSpace;//预约默认时间间隔
//    @property (nonatomic,strong) NSString <Optional>*patientNotifyTimeSpace;//处方病人提醒默认时间间隔
//    @property (nonatomic,strong) NSString <Optional>*electronicPatientNotifyTimeSpace;//电子处方病人提醒默认时间间隔
//    @property (nonatomic, strong) NSString <Optional>*electronicPrescriptionPrice;//处方预约默认门诊费
//    @property (nonatomic, strong)  NSNumber <Optional>*electronicPrescriptionNotifySelected;//电子处方是否选择提醒天数
//    @property (nonatomic, strong)  NSNumber <Optional>*prescriptionNotifySelected;//处方是否选择提醒天数
//    var data:JSON?
    required init?(map: Map) {

    }
    func mapping(map: Map) {
        qrcodeUrl    <- map["qrcodeUrl"]
        status         <- map["status"]
        doctorId      <- map["doctorId"]
        name       <- map["name"]
        avatarUrl  <- map["avatarUrl"]
        token  <- map["token"]
        title     <- map["title"]
        level    <- map["level"]
        expires    <- map["expires"]
        phone    <- map["phone"]
        password    <- map["password"]
        assistantId    <- map["assistantId"]
        assistantAvatarUrl         <- map["assistantAvatarUrl"]
        assistantUserName      <- map["assistantUserName"]
        assistantRemark       <- map["assistantRemark"]
        isLogout  <- map["isLogout"]
        myMoney  <- map["myMoney"]
        unApproveMoney     <- map["unApproveMoney"]
        myMoneyOriginal    <- map["level"]
        unApproveMoneyOriginal    <- map["unApproveMoneyOriginal"]
        isShowNotifyHead    <- map["isShowNotifyHead"]
        appConstValueArray  <- map["appConstValueArray"]
        currentUploadConsiliaId  <- map["currentUploadConsiliaId"]
        currentEditConsiliaId     <- map["currentEditConsiliaId"]
        isUpload    <- map["isUpload"]
        isStopUpload    <- map["isStopUpload"]
        maunalToUpload    <- map["maunalToUpload"]
    }
}

class MSMDataModel: Mappable {
    var captcha: String?
    var expires: String?
    required init?(map: Map) {
    }
    func mapping(map: Map) {
        captcha    <- map["captcha"]
        expires         <- map["expires"]
    }
}


class RegisterModel: Mappable {
    var doctorId: String?
    var expires: String?
    var token: String?

    required init?(map: Map) {
    }
    func mapping(map: Map) {
        doctorId    <- map["captcha"]
        expires         <- map["expires"]
        token         <- map["token"]
    }
}


//MARK:获取文章微课列表
class CourseMicroClassModel: Mappable {

    var sourceId: String?
    var sourceType: Int?
    var title: String?
    var createTime: Double?
    var coverImageUrl: String = ""
    var actionCount: Int?
    var hnsType: Int?
    var hnsContent: String?

    required init?(map: Map) {
    }
    func mapping(map: Map) {
        sourceId    <- map["sourceId"]
        sourceType         <- map["sourceType"]
        title         <- map["title"]
        createTime    <- map["createTime"]
        coverImageUrl         <- map["coverImageUrl"]
        actionCount         <- map["actionCount"]
        hnsType    <- map["hnsType"]
        hnsContent         <- map["hnsContent"]
    }
}
