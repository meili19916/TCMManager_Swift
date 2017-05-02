//
//  SettingViewController.swift
//  TCMManager_Swift
//
//  Created by HeLijuan on 17/4/24.
//  Copyright © 2017年 HeLijuan. All rights reserved.
//

import UIKit

class SettingViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    @IBOutlet weak var tableView: UITableView!
    let titileArray = [["我的欢迎语"],["病人添加我时需要我同意","仅连接WiFi时同步医案"],["修改密码","更换手机号","新消息提醒"],["使用帮助","关于明医"],["退出登录"]]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "设置"
        tableView.register(UINib(nibName: "SettingWithSwitchTableViewCell", bundle: nil), forCellReuseIdentifier: "SettingWithSwitchTableViewCell")
        tableView.register(UINib(nibName: "SettingWelcomeTableViewCell", bundle: nil), forCellReuseIdentifier: "SettingWelcomeTableViewCell")
        tableView.register(UITableViewCell.classForCoder(), forCellReuseIdentifier: "cell")
        tableView.removeExtraFooterView()
        
        // Do any additional setup after loading the view.
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return titileArray.count
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return titileArray[section].count
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 44
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 10
    }

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UIView.init(frame: CGRect.init(x: 0, y: 0, width: ScreenWidth, height: 10))
        view.backgroundColor = BackgroundColor
        return view
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            let cell:SettingWelcomeTableViewCell = tableView.dequeueReusableCell(withIdentifier:"SettingWelcomeTableViewCell", for: indexPath) as! SettingWelcomeTableViewCell
            return cell
        case 1:
            let cell:SettingWithSwitchTableViewCell = tableView.dequeueReusableCell(withIdentifier:"SettingWithSwitchTableViewCell", for: indexPath) as! SettingWithSwitchTableViewCell
            cell.titleLabel?.text = titileArray[indexPath.section][indexPath.row]
            cell.selectionStyle = .none
            if indexPath.row == 0 {
        cell.switch.setOn(UserManager.sharedInstance.currentUser?.doctorDetials?.patientAddAgree == 1 ? true :false, animated: true)
            }else{
                cell.switch.setOn(UserManager.sharedInstance.currentUser?.maunalToUpload == 1 ? true :false, animated: true)
            }
            return cell
        case titileArray.count - 1:
            let cell = tableView.dequeueReusableCell(withIdentifier:"cell", for: indexPath)
            cell.textLabel?.text = titileArray[indexPath.section][indexPath.row]
            cell.textLabel?.textAlignment = .center
            cell.textLabel?.textColor = RedColor
            return cell

        default:
            let cell = tableView.dequeueReusableCell(withIdentifier:"cell", for: indexPath)
            cell.textLabel?.text = titileArray[indexPath.section][indexPath.row]
            cell.textLabel?.font = UIFont.systemFont(ofSize: 15)
            cell.accessoryType = .disclosureIndicator
            return cell
        }
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        if indexPath.section == titileArray.count - 1 {
            self.logout()
        }
    }

    func logout() -> Void {
        let actionSheet = UIAlertController.init(title: nil, message: "退出后不会删除任何历史数据，下次登录依然可以使用本账号。",preferredStyle: .actionSheet)
        actionSheet.addAction(UIAlertAction.init(title: "取消", style: .cancel, handler: { (alterAction) in

        }))
        actionSheet.addAction(UIAlertAction.init(title: "退出登录", style: .destructive, handler: { (alterAction) in
            self.tableView.isUserInteractionEnabled = false;
            MBProgressHUDManager.sharedInstance.show(type:.Loading,text:nil, detailText:nil,onView: self.view)
            RequestManager.logout(complete: { (result) in
                UserManager.sharedInstance.currentUser?.password = nil
                UserManager.sharedInstance.currentUser?.token = nil
                UserDefaults.standard.set( UserManager.sharedInstance.currentUser?.toJSONString(), forKey: "userModel")
                UserDefaults.standard.synchronize()
                self.navigationController?.pushViewController(LoginViewController(), animated: true)
                MBProgressHUDManager.sharedInstance.dissmiss()
            }, failed: { (result) in
                MBProgressHUDManager.sharedInstance.show(type:.Text,text:result.1 as! String?, detailText:nil,onView: self.view)

            })
        }))
        self.present(actionSheet, animated: true) {

        }

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
