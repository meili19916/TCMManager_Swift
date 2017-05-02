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
    var phone:String?
    var password:String?
    var isLogout:String?
    var myMoney:String?
    var unApproveMoney:String?
    var myMoneyOriginal:String?
    var unApproveMoneyOriginal:String?
    var isShowNotifyHead:String?
    var doctorDetials:DoctorDetailModel?
    var appConstValueArray:String?
    var currentUploadConsiliaId:String?
    var currentEditConsiliaId:String?
    var isUpload:Bool?
    var isStopUpload:Bool?
    var maunalToUpload:Int?
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
        doctorDetials    <- map["doctorDetials"]
    }
}

class DoctorDetailModel: Mappable {

    var imageOne: String?
    var imageTwo: String?

    var doctorId: String?
    var doctorIdentity: String?
    var name: String?
    var title: String?
    var phone: String?
    var province: String?
    var city: String?
    var county: String?
    var street: String?
    var provinceId: String?
    var cityId: String?
    var countyId: String?
    var sex: Int?
    var level: Int?
    var birthday: String?
    var remark: String?
    var education: String?
    var achievement: String?
    var status: Int?
    var avatarUrl: String?
    var qrcodeUrl: String?
    var diseaseChoosedCount: Int?
    var diseaseAllCount: Int?
    var diseaseNameList: Array<String>?
    var approveContent: String?
    var number: Int?
    var patientAddAgree: Int?
    var userAddMessage: String?

    required init?(map: Map) {
    }

    func mapping(map: Map) {
        doctorId    <- map["doctorId"]
        doctorIdentity         <- map["doctorIdentity"]
        name         <- map["name"]
        phone    <- map["phone"]
        title         <- map["title"]
        province         <- map["province"]
        city    <- map["city"]
        county         <- map["county"]
        street         <- map["street"]
        provinceId    <- map["provinceId"]
        cityId         <- map["cityId"]
        countyId         <- map["countyId"]
        sex    <- map["sex"]
        level         <- map["level"]
        birthday         <- map["birthday"]
        doctorId    <- map["captcha"]
        remark         <- map["remark"]
        education         <- map["education"]
        achievement    <- map["achievement"]
        status         <- map["status"]
        avatarUrl         <- map["avatarUrl"]
        qrcodeUrl         <- map["qrcodeUrl"]
        diseaseChoosedCount         <- map["diseaseChoosedCount"]
        diseaseAllCount    <- map["diseaseAllCount"]
        diseaseNameList         <- map["diseaseNameList"]
        approveContent         <- map["approveContent"]
        number    <- map["number"]
        patientAddAgree         <- map["patientAddAgree"]
        userAddMessage         <- map["userAddMessage"]
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
//MARK:活动列表
class ActivityListModel: Mappable {

    var activityId: String?
    var imageUrl: String = ""
    var shareUrl: String?
    var shareType: Int?
    var shareInd: Int?
    var shareTitle: String?
    var addDoctorId: Int?
    var shareContent: String?
    var shareAddDoctorId: Int?
    var addIsMingyiApp: Int?
    var startTime: Double?
    var endTime: Double?
    var activityName: String?
    required init?(map: Map) {}
    func mapping(map: Map) {
        activityId    <- map["activityId"]
        imageUrl         <- map["imageUrl"]
        shareUrl         <- map["shareUrl"]
        shareType    <- map["shareType"]
        shareInd         <- map["shareInd"]
        shareTitle         <- map["shareTitle"]
        addDoctorId    <- map["addDoctorId"]
        shareContent         <- map["shareContent"]
        shareAddDoctorId    <- map["shareAddDoctorId"]
        addIsMingyiApp         <- map["addIsMingyiApp"]
        startTime         <- map["startTime"]
        endTime    <- map["endTime"]
        activityName         <- map["activityName"]
    }
}
//MARK:获取病人聊天列表
class PatientMessageListModel: Mappable {

    var usrName: String?
    var msgCategory: Int = 0
    var mteContent: String?
    var lastTime: Double?
    var usrAvatar: String = ""


    required init?(map: Map) {
    }
    func mapping(map: Map) {
        usrName    <- map["usrName"]
        msgCategory         <- map["msgCategory"]
        mteContent         <- map["mteContent"]
        lastTime    <- map["lastTime"]
        usrAvatar    <- map["usrAvatar"]
    }
}

//MARK:获取医案列表
class MedicalRecordListModel: Mappable {

    var userId: String?
    var medicalRecordId: String?
    var medicalRecordGroupId: String?
    var coverImageUrl: String = ""
    var userName: String = ""
    var diagnosis: String = ""
    var createDate: Double?
    var diagnosisDate: Double?

    required init?(map: Map) {
    }
    func mapping(map: Map) {
        userId    <- map["userId"]
        medicalRecordId         <- map["medicalRecordId"]
        medicalRecordGroupId         <- map["medicalRecordGroupId"]
        coverImageUrl    <- map["coverImageUrl"]
        userName    <- map["userName"]
        diagnosis         <- map["diagnosis"]
        createDate    <- map["createDate"]
        diagnosisDate    <- map["diagnosisDate"]
    }
}

//MARK:获取患教中心model
class TeachingCenterListModel: Mappable {

    var dynamicsId: String?
    var title: String?
    var images: Array<String>?
    var content: String?
    var agreeCount: Int?
    var viewCount: Int?
    var createDate: Double?
    var type: Int?
    var remark: String?
    var commentList: Array<TeachingCenterCommentModel>?

    required init?(map: Map) {
    }
    func mapping(map: Map) {
        dynamicsId    <- map["dynamicsId"]
        title         <- map["title"]
        images         <- map["images"]
        content    <- map["content"]
        agreeCount    <- map["agreeCount"]
        viewCount         <- map["viewCount"]
        createDate    <- map["createDate"]
        type    <- map["type"]
        remark    <- map["remark"]
        commentList    <- map["commentList"]
    }
}

class TeachingCenterCommentModel: Mappable {
    var commentId: String?
    var content: String?
    var name: String?
    var avatarUrl: String?
    var type: Int?
    var createDate: Double?

    required init?(map: Map) {
    }
    func mapping(map: Map) {
        commentId    <- map["commentId"]
        content         <- map["content"]
        name         <- map["name"]
        avatarUrl    <- map["avatarUrl"]
        type    <- map["type"]
        createDate    <- map["createDate"]
    }
}

