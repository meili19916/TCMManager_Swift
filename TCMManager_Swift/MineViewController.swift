//
//  MineViewController.swift
//  TCMManager_Swift
//
//  Created by HeLijuan on 17/2/27.
//  Copyright © 2017年 HeLijuan. All rights reserved.
//

import UIKit
import Kingfisher

class MineViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    var dataArray:Array<Array<(identifier:String?,couple:(icon:String?,title:String?)?)>>?

    override func viewDidLoad() {
        super.viewDidLoad()
        self.automaticallyAdjustsScrollViewInsets = false
        UserManager.sharedInstance.currentUser?.status = 3
        if UserManager.sharedInstance.currentUser?.status == VertifyStatusType.Veritifyed.rawValue {
            self.dataArray = [[(identifier:"InfoCell",couple:nil)],
                              [(identifier:"ListCell",couple:(icon:"currenteditdata",title:"编辑资料")),(identifier:"ListCell",couple:(icon:"currentMicroClassCollection",title:"收藏"))],
                              [(identifier:"ListCell",couple:(icon:"currentassetsicon",title:"资产")),(identifier:"ListCell",couple:(icon:"currentwelfare",title:"我的福利")),(identifier:"ListCell",couple:(icon:"invite_friend_icon",title:"邀请好友"))],
                              [(identifier:"ListCell",couple:(icon:"facebackImage",title:"意见反馈")),(identifier:"ListCell",couple:(icon:"setting",title:"设置"))]]
        }else if(UserManager.sharedInstance.currentUser?.status == VertifyStatusType.NoVertify.rawValue){

            self.dataArray = [[(identifier:"InfoCell",couple:nil)],
                              [(identifier:"VerifyCell",couple:(icon:"currentcertificationicon",title:"立即认证"))],
                              [(identifier:"ListCell",couple:(icon:"currenteditdata",title:"编辑资料")),(identifier:"ListCell",couple:(icon:"currentMicroClassCollection",title:"收藏"))],
                              [(identifier:"ListCell",couple:(icon:"currentassetsicon",title:"资产")),(identifier:"ListCell",couple:(icon:"currentwelfare",title:"我的福利")),(identifier:"ListCell",couple:(icon:"invite_friend_icon",title:"邀请好友"))],
                              [(identifier:"ListCell",couple:(icon:"facebackImage",title:"意见反馈")),(identifier:"ListCell",couple:(icon:"setting",title:"设置"))]]
        }else if(UserManager.sharedInstance.currentUser?.status == VertifyStatusType.Veritifing.rawValue){
            self.dataArray = [[(identifier:"InfoCell",couple:nil)],
                              [(identifier:"VerifyCell",couple:(icon:"currentcertificationicon",title:"认证中"))],
                              [(identifier:"ListCell",couple:(icon:"currenteditdata",title:"编辑资料")),(identifier:"ListCell",couple:(icon:"currentMicroClassCollection",title:"收藏"))],
                              [(identifier:"ListCell",couple:(icon:"currentassetsicon",title:"资产")),(identifier:"ListCell",couple:(icon:"currentwelfare",title:"我的福利")),(identifier:"ListCell",couple:(icon:"invite_friend_icon",title:"邀请好友"))],
                              [(identifier:"ListCell",couple:(icon:"facebackImage",title:"意见反馈")),(identifier:"ListCell",couple:(icon:"setting",title:"设置"))]]
        }else if(UserManager.sharedInstance.currentUser?.status == VertifyStatusType.Refused.rawValue){
            self.dataArray = [[(identifier:"InfoCell",couple:nil)],
                              [(identifier:"VerifyCell",couple:(icon:"currentcertificationicon",title:"已拒绝,请重新认证"))],
                              [(identifier:"ListCell",couple:(icon:"currenteditdata",title:"编辑资料")),(identifier:"ListCell",couple:(icon:"currentMicroClassCollection",title:"收藏"))],
                              [(identifier:"ListCell",couple:(icon:"currentassetsicon",title:"资产")),(identifier:"ListCell",couple:(icon:"currentwelfare",title:"我的福利")),(identifier:"ListCell",couple:(icon:"invite_friend_icon",title:"邀请好友"))],
                              [(identifier:"ListCell",couple:(icon:"facebackImage",title:"意见反馈")),(identifier:"ListCell",couple:(icon:"setting",title:"设置"))]]
        }

        self.tableView.removeExtraFooterView()
        self.tableView.separatorInset = UIEdgeInsets.init(top: 0, left: 50, bottom: 0, right: 0)
        self.getData()
        // Do any additional setup after loading the view.
    }
    func getData() -> Void {

    }

    override func viewWillAppear(_ animated: Bool) {
            super.viewWillAppear(animated)
            self.tabBarController?.navigationItem.title = "我"
            self.tabBarController?.navigationItem.rightBarButtonItem = nil
            self.tabBarController?.navigationItem.leftBarButtonItem = nil
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return (dataArray?.count)!
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataArray![section].count
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return indexPath.section == 0 ? 70 : 48
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return section == 0 ? 0.1 : ViewSpace
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        if indexPath.section == 0 {
            let cell:MineInfoTableViewCell = tableView.dequeueReusableCell(withIdentifier:dataArray![indexPath.section][indexPath.row].0!, for: indexPath) as! MineInfoTableViewCell
            cell.nameLabel.text = UserManager.sharedInstance.currentUser?.name
            let url = URL(string: (UserManager.sharedInstance.currentUser?.avatarUrl)!)
            cell.headImageView.kf.setImage(with: url)
            cell.accessoryType = .disclosureIndicator
            return cell
        }
        if UserManager.sharedInstance.currentUser?.status != VertifyStatusType.Veritifyed.rawValue && indexPath.section == 1 {
            let cell:MineVerityfyTableViewCell = tableView.dequeueReusableCell(withIdentifier: dataArray![indexPath.section][indexPath.row].0!, for: indexPath) as! MineVerityfyTableViewCell
            cell.titleLabel.text = dataArray![indexPath.section][indexPath.row].1!.1!
            cell.accessoryType = .disclosureIndicator
            return cell

        }
        let cell:MineListTableViewCell = tableView.dequeueReusableCell(withIdentifier: dataArray![indexPath.section][indexPath.row].0!, for: indexPath) as! MineListTableViewCell
        cell.titleLabel.text = dataArray![indexPath.section][indexPath.row].1!.1!
        cell.headImageView.image = UIImage.init(named: dataArray![indexPath.section][indexPath.row].1!.0!)
        cell.accessoryType = .disclosureIndicator
        return cell
    }

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView.init(frame: CGRect.init(x: 0, y: 0, width: ScreenWidth, height: ViewSpace))
        headerView.backgroundColor = BackgroundColor
        return headerView
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
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
