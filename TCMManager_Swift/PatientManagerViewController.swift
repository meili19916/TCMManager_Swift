//
//  PatientManagerViewController.swift
//  TCMManager_Swift
//
//  Created by HeLijuan on 17/2/27.
//  Copyright © 2017年 HeLijuan. All rights reserved.
//

import UIKit

class PatientManagerViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    var dataArray:Array<PatientMessageListModel> = []
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
       self.tableView.mj_header = MJRefreshNormalHeader(refreshingTarget: self, refreshingAction: #selector(PatientManagerViewController.getData))
        self.getData()
        // Do any additional setup after loading the view.
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return section == 0 ? 2 : self.dataArray.count
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return indexPath.section == 0 ? 48 : 70
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return section == 0 ? 0 : 35
    }
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "消息列表"
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let cell:PatientManangerHeadTableViewCell = tableView.dequeueReusableCell(withIdentifier:"HeadCell", for: indexPath) as! PatientManangerHeadTableViewCell
            if indexPath.row == 1 {
                cell.headImageView.image = UIImage.init(named: "addnewpatient")
                cell.titleLabel.text = "新病人"
            }
            return cell
        }
        let cell:PatientManagerListTableViewCell = tableView.dequeueReusableCell(withIdentifier:"ListCell", for: indexPath) as! PatientManagerListTableViewCell
        cell.headImageView.setImageUrl(url: (dataArray[indexPath.row].usrAvatar))
        cell.nameLabel.text = (dataArray[indexPath.row].usrName)!
        let category:Int = (dataArray[indexPath.row].msgCategory)
        cell.messageLabel.textColor = MainColor
        switch category {
        case 3:
            cell.messageLabel.text = "[图片]"
        case 4:
            cell.messageLabel.text = "[语音]"
        case 5:
            cell.messageLabel.text = "[处方]"
        case 8:
            cell.messageLabel.text = "[问诊单]"
        case 9:
            cell.messageLabel.text = "[电子处方]"
        case 10:
            cell.messageLabel.text = "[坐诊信息]"
        default:
            cell.messageLabel.text = dataArray[indexPath.row].mteContent
            cell.messageLabel.textColor = GrayTextColor
        }
        let date  = Date.init(timeIntervalSince1970: dataArray[indexPath.row].lastTime!)
        cell.timeLabel.text = date.formateDate()
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }

    func getData() -> Void {
        RequestManager.getPatientMessageList(complete: { (data) in
            self.dataArray = (data as! Array<PatientMessageListModel>?)!
            self.tableView.reloadData()
            self.tableView.mj_header.endRefreshing()
        }) { (result) in
            MBProgressHUDManager.sharedInstance.show(type: .Text, text: result.1 as? String, detailText: nil, onView: self.view)

        }
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tabBarController?.navigationItem.title = "病人管理"
        self.tabBarController?.navigationItem.rightBarButtonItem = nil
        self.tabBarController?.navigationItem.leftBarButtonItem = nil
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
