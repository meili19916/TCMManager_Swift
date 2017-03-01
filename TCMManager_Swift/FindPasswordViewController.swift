//
//  FindPasswordViewController.swift
//  TCMManager_Swift
//
//  Created by HeLijuan on 17/2/25.
//  Copyright © 2017年 HeLijuan. All rights reserved.
//

import UIKit

class FindPasswordViewController: UIViewController {

    @IBOutlet weak var phoneTextField: UITextField!
    @IBOutlet weak var verifyTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var sendVerifyNumberButton: UIButton!

    var countNumber = 0
    var timer:Timer?


    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "找回密码"
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func sendVerifyNumberHandle(_ sender: UIButton) {
        sender.isEnabled = false
        if !self .checkInputFinished(isCheckSendSMS: true) {
            sender.isEnabled = true
            return
        }
        RequestManager.sendSMS(phone: self.phoneTextField.text!, type: .FindPassword, complete: { (result) in
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

    @IBAction func passwordSeeHandle(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
        self.passwordTextField.isSecureTextEntry = !sender.isSelected
    }

    @IBAction func submitHandle(_ sender: Any) {
        if !self.checkInputFinished(isCheckSendSMS:false) {
            return
        }
        RequestManager.findPassword(phone: self.phoneTextField.text!, password: self.passwordTextField.text!, verifyNumber: self.verifyTextField.text!, complete: { (result) in
            MBProgressHUDManager.sharedInstance.show(type: .Text, text: "成功", detailText: nil, onView: self.view)
        }) { (result) in
            print(result)
        }
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
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
