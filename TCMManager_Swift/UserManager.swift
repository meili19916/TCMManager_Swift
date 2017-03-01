//
//  UserManager.swift
//  TCMManager_Swift
//
//  Created by HeLijuan on 17/2/25.
//  Copyright © 2017年 HeLijuan. All rights reserved.
//

import UIKit

class UserManager: NSObject {
    static let sharedInstance = UserManager()
    var currentUser:LoginUserModel?
    override init(){
        let jsonString =  UserDefaults.standard.object(forKey: "userModel") as? String
        if (jsonString != nil) {
            currentUser = Mapper<LoginUserModel>().map(JSONString: jsonString!)
        }
    }
}
