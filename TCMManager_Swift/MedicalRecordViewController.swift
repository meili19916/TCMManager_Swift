//
//  MedicalRecordViewController.swift
//  TCMManager_Swift
//
//  Created by HeLijuan on 17/2/27.
//  Copyright © 2017年 HeLijuan. All rights reserved.
//

import UIKit

class MedicalRecordViewController: UIViewController,UITableViewDataSource,UITableViewDelegate {
    @IBOutlet weak var tableView: UITableView!
    var dicArray:Array<Array<MedicalRecordListModel>> = []

    override func viewDidLoad() {
        super.viewDidLoad()
       self.tableView.mj_header = MJRefreshNormalHeader(refreshingTarget: self, refreshingAction: #selector(PatientManagerViewController.getData))
        self.getData()
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tabBarController?.navigationItem.title = "医案"
        self.tabBarController?.navigationItem.rightBarButtonItem = nil
        self.tabBarController?.navigationItem.leftBarButtonItem = nil
    }

    func getData() -> Void {
        RequestManager.getMedicalRecordList(arrange: "1", searchStr: nil, userId: nil, complete: { (data) in
            if (data != nil) {
                self.updateDicArray(dataArray: data as! Array<MedicalRecordListModel>)
            }
            self.tableView.reloadData()
            self.tableView.mj_header.endRefreshing()
        }) { (result) in
            MBProgressHUDManager.sharedInstance.show(type: .Text, text: result.1 as? String, detailText: nil, onView: self.view)
        }
    }

    func updateDicArray(dataArray:Array<MedicalRecordListModel>) -> Void {
        var beforeTime = ""
        var count = -1
        for model  in dataArray {
            let time = Date.formateDate(timeVal: model.createDate!, format: "yyyy-MM")
            if beforeTime != time {
                count = count + 1
                dicArray.append(Array<MedicalRecordListModel>())
                beforeTime = time
            }
            dicArray[count].append(model)
        }
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1 + self.dicArray.count
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return section == 0 ? 0 : 25
    }

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UIView.init(frame:CGRect.init(x: 0, y: 0, width: ScreenWidth, height: 25))
        view.backgroundColor = BackgroundColor
        let timeLabel = UILabel.init(frame: CGRect.init(x: 15, y: 0, width: 200, height: 25))
        timeLabel.text = Date.formateDate(timeVal: (self.dicArray[section - 1].first?.createDate!)!, format: "yyyy-MM")
        timeLabel.font = UIFont.systemFont(ofSize: 14)
        timeLabel.textColor = UIColor.lightGray
        view.addSubview(timeLabel)
        return view
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return section == 0 ? 1 : self.dicArray[section - 1].count
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return indexPath.section == 0 ? 50 : 80
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let cell:MedicalNoNamedTableViewCell = tableView.dequeueReusableCell(withIdentifier:"NoNamedCell", for: indexPath) as! MedicalNoNamedTableViewCell
            cell.accessoryType = .disclosureIndicator
            return cell
        }else{
            let cell:MedicalNamedTableViewCell = tableView.dequeueReusableCell(withIdentifier:"NamedCell", for: indexPath) as! MedicalNamedTableViewCell
            cell.nameLabel?.text = self.dicArray[indexPath.section - 1][indexPath.row].userName
            cell.diagnossLabel.text = self.dicArray[indexPath.section - 1][indexPath.row].diagnosis
            cell.medicalImageView.setImageUrlWithDefualt(url: self.dicArray[indexPath.section - 1][indexPath.row].coverImageUrl, defualtImage: "medical_defualt_icon")
            cell.timeLabel.text = Date.formateDate(timeVal: self.dicArray[indexPath.section - 1][indexPath.row].createDate!, format: "dd")
            return cell
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
