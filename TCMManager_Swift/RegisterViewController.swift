//
//  RegisterViewController.swift
//  TCMManager_Swift
//
//  Created by HeLijuan on 17/2/27.
//  Copyright © 2017年 HeLijuan. All rights reserved.
//

import UIKit

class RegisterViewController: UIViewController {

    @IBOutlet weak var sendVerifyNumberButton: UIButton!
    @IBOutlet weak var phoneTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var verifyTextField: UITextField!
    @IBOutlet weak var inviteNumberTextField: UITextField!

    var countNumber = 0
    var timer:Timer?

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "注册"

        // Do any additional setup after loading the view.
    }

    @IBAction func passwordSeeHandle(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
        self.passwordTextField.isSecureTextEntry = !sender.isSelected
    }
    @IBAction func sendVerifyNumberHandle(_ sender: UIButton) {
        sender.isEnabled = false
        if !self .checkInputFinished(isCheckSendSMS: true) {
            sender.isEnabled = true
            return
        }
        RequestManager.sendSMS(phone: self.phoneTextField.text!, type: .Registe, complete: { (result) in
            self.countNumber = 60
            self.timer = Timer.scheduledTimer(timeInterval: 1,
                                              target:self,selector:#selector(FindPasswordViewController.countNumberHandle),
                                              userInfo:nil,repeats:true)
        }) { (result) in
            sender.isEnabled = true
            MBProgressHUDManager.sharedInstance.show(type: .Text, text: result as? String, detailText: nil, onView: self.view)
        }

    }
     /**
     *计时器每秒触发事件
     **/
    func countNumberHandle()
    {
        countNumber -= 1
        if countNumber == 0 {
            sendVerifyNumberButton.setTitle("发送验证码", for: UIControlState.normal)
            sendVerifyNumberButton.isEnabled = true
            timer?.invalidate()
            return
        }
        sendVerifyNumberButton.setTitle(String(countNumber)+"s后重发", for: UIControlState.normal)
    }

    @IBAction func registerHandle(_ sender: UIButton) {
        sender.isEnabled = false
        if !self.checkInputFinished(isCheckSendSMS:false) {
            sender.isEnabled = true
            return
        }
        RequestManager.register(phone: self.phoneTextField.text!, password: self.passwordTextField.text!, verifyNumber: self.verifyTextField.text!, voiceNumber: (self.inviteNumberTextField.text?.characters.count)! > 0 ? self.inviteNumberTextField.text : nil, complete: { (result) in
            let mainStoryboard = UIStoryboard.init(name: "Main", bundle: nil)
            let mainTabVC = mainStoryboard.instantiateViewController(withIdentifier: "MainTabBarController")
            self.navigationController?.pushViewController(mainTabVC, animated: true)
        }) { (result) in
            sender.isEnabled = true
            MBProgressHUDManager.sharedInstance.show(type: .Text, text: result as? String, detailText: nil, onView: self.view)
        }
    }
    @IBAction func sendVoiceNumberHandle(_ sender: Any) {

    }


    func checkInputFinished(isCheckSendSMS:Bool) -> Bool {
        if phoneTextField.text?.characters.count == 0  {
            MBProgressHUDManager.sharedInstance.show(type: .Text, text: "请输入手机号", detailText: nil, onView: self.view)
            return false
        }
        if isCheckSendSMS {
            return true
        }
        if verifyTextField.text?.characters.count == 0  {
            MBProgressHUDManager.sharedInstance.show(type: .Text, text: "请输入验证码", detailText: nil, onView: self.view)
            return false
        }
        if passwordTextField.text?.characters.count == 0  {
            MBProgressHUDManager.sharedInstance.show(type: .Text, text: "请输入密码", detailText: nil, onView: self.view)
            return false
        }
        return true
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
