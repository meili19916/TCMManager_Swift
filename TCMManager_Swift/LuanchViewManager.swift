//
//  LuanchViewManager.swift
//  TCMManager_Swift
//
//  Created by HeLijuan on 17/2/7.
//  Copyright © 2017年 HeLijuan. All rights reserved.
//

import UIKit

class LuanchViewManager: NSObject {

    func resetNavigationBar( navigationVC:inout UINavigationController?) -> Void {
        navigationVC = UINavigationController.init()
        navigationVC?.navigationBar.barStyle = UIBarStyle.blackTranslucent
        let lineView = UIView.init(frame: CGRect.init(x: 0, y: 43, width: ScreenWidth, height: 1))
        lineView.backgroundColor = LineColor
        navigationVC?.navigationBar.addSubview(lineView)
        navigationVC?.view.backgroundColor = UIColor.white
        navigationVC?.navigationBar.barTintColor = UIColor.white

        var backImage = UIImage.init(named: "backarrowhead")
        backImage = backImage?.resizableImage(withCapInsets: UIEdgeInsetsMake(0, 36, 0, 0))
        UIBarButtonItem.appearance().setBackButtonBackgroundImage(backImage, for: UIControlState.normal, barMetrics: UIBarMetrics.default)
        navigationVC?.navigationBar.tintColor = TextColor
        navigationVC?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName : TextColor]
        UIBarButtonItem.appearance().backButtonTitlePositionAdjustment(for:UIBarMetrics.default)
    }

    func showView(window:UIWindow?, navigationVC:UINavigationController?) -> Void {
        if self.isFirstLaunchOrUpdateApp() {
            self.showGuideView(window: window, navigationVC: navigationVC)
        }else{
            if (UserManager.sharedInstance.currentUser != nil){
                self.showTabView(window: window, navigationVC: navigationVC)
            }else{
                self.showLoginView(window: window, navigationVC: navigationVC)
            }
        }
    }

    func showGuideView(window:UIWindow?, navigationVC:UINavigationController?) -> Void {
        let vc = GuideViewController.init()
        self.setNavigationBackArray(vc: vc)
        navigationVC?.pushViewController(vc, animated: true)
        window?.rootViewController = navigationVC
    }

    func showLoginView(window:UIWindow?, navigationVC:UINavigationController?) -> Void {
        let vc = LoginViewController.init()
        self.setNavigationBackArray(vc: vc)
        navigationVC?.pushViewController(vc, animated: true)
        window?.rootViewController = navigationVC
    }
    func showTabView(window:UIWindow?, navigationVC:UINavigationController?) -> Void {
        let mainStoryboard = UIStoryboard.init(name: "Main", bundle: nil)
        let mainTabVC = mainStoryboard.instantiateViewController(withIdentifier: "MainTabBarController")
        self.setNavigationBackArray(vc: mainTabVC)
        navigationVC?.pushViewController(mainTabVC, animated: true)
        window?.rootViewController = navigationVC
    }

    func setNavigationBackArray(vc:UIViewController) -> Void {
        let backItem = UIBarButtonItem.init(title: "", style: UIBarButtonItemStyle.plain, target: nil, action: nil)
        vc.navigationItem.backBarButtonItem = backItem
    }

    func isFirstLaunchOrUpdateApp() -> Bool {

        let cacheAPPVersion = UserDefaults.standard.object(forKey: "cacheVersion") as? String
        let currentAPPVersion = Bundle.main.object(forInfoDictionaryKey: "CFBundleShortVersionString") as? String
        if  (currentAPPVersion == nil) || (cacheAPPVersion == nil) || (cacheAPPVersion  != currentAPPVersion) {
            UserDefaults.standard.set(currentAPPVersion, forKey: "cacheVersion")
            UserDefaults.standard.set(true, forKey: "newVersion")
            UserDefaults.standard.removeObject(forKey: "maxDataVersionModel")
            UserDefaults.standard.synchronize()
            return true
        }
        return false
    }
}
