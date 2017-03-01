//
//  LoginViewController.swift
//  TCMManager_Swift
//
//  Created by HeLijuan on 17/2/7.
//  Copyright © 2017年 HeLijuan. All rights reserved.
//

import UIKit
import SwiftyJSON
class LoginViewController: UIViewController {
    @IBOutlet weak var phoneTextField: UITextField!

    @IBOutlet weak var passwordPhoneTextField: UITextField!

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isHidden = true
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.phoneTextField.text = UserManager.sharedInstance.currentUser?.phone
        self.passwordPhoneTextField.text = UserManager.sharedInstance.currentUser?.password

        // Do any additional setup after loading the view.
    }
    @IBAction func login(_ sender: Any) {

        if !self.checkInputFinished() {
            return
        }
        MBProgressHUDManager.sharedInstance.show(type:.Loading,text:nil, detailText:nil,onView: self.view)
        RequestManager.login(phone:phoneTextField.text!,password:passwordPhoneTextField.text!,complete:{result in
            MBProgressHUDManager.sharedInstance.dissmiss()
            let mainStoryboard = UIStoryboard.init(name: "Main", bundle: nil)
            let mainTabVC = mainStoryboard.instantiateViewController(withIdentifier: "MainTabBarController")
            self.navigationController?.pushViewController(mainTabVC, animated: true)
        },failed: {result in
            MBProgressHUDManager.sharedInstance.show(type: .Text, text: result as? String, detailText: nil, onView: self.view)

        })
    }

    func checkInputFinished() -> Bool {
        if phoneTextField.text?.characters.count == 0  {
            MBProgressHUDManager.sharedInstance.show(type: .Text, text: "请输入手机号", detailText: nil, onView: self.view)
            return false
        }
        if passwordPhoneTextField.text?.characters.count == 0  {
            MBProgressHUDManager.sharedInstance.show(type: .Text, text: "请输入密码", detailText: nil, onView: self.view)
            return false

        }
        return true
    }

    @IBAction func findPassword(_ sender: Any) {
        self.navigationController?.pushViewController(FindPasswordViewController(), animated: true)
    }
    @IBAction func regist(_ sender: Any) {
        self.navigationController?.pushViewController(RegisterViewController(), animated: true)
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.navigationBar.isHidden = false
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
