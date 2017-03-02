//
//  MineViewController.swift
//  TCMManager_Swift
//
//  Created by HeLijuan on 17/2/27.
//  Copyright © 2017年 HeLijuan. All rights reserved.
//

import UIKit

class MineViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    var dataArray:Array<Array<(String?,(String?,String?)?)>>?
    override func viewDidLoad() {
        super.viewDidLoad()
        self.automaticallyAdjustsScrollViewInsets = false
        dataArray = [[(identifier:"InfoCell",couple:nil)],
                     [(identifier:"ListCell",couple:(icon:"currenteditdata",title:"编辑资料")),(identifier:"ListCell",couple:(icon:"currentMicroClassCollection",title:"收藏"))],
                     [(identifier:"ListCell",couple:(icon:"currentassetsicon",title:"资产")),(identifier:"ListCell",couple:(icon:"currentwelfare",title:"我的福利")),(identifier:"ListCell",couple:(icon:"invite_friend_icon",title:"邀请好友"))],
                    [(identifier:"ListCell",couple:(icon:"facebackImage",title:"意见反馈")),(identifier:"ListCell",couple:(icon:"setting",title:"设置"))]]
        // Do any additional setup after loading the view.
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
            cell.accessoryType = .disclosureIndicator
            return cell
        }
        let cell:MineListTableViewCell = tableView.dequeueReusableCell(withIdentifier: dataArray![indexPath.section][indexPath.row].0!, for: indexPath) as! MineListTableViewCell
        cell.titleLabel.text = dataArray![indexPath.section][indexPath.row].1!.1!
        cell.headImageView.image = UIImage.init(named: dataArray![indexPath.section][indexPath.row].1!.0!)
        cell.accessoryType = .disclosureIndicator
        return cell
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
