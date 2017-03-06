//
//  WorkStudioViewController.swift
//  TCMManager_Swift
//
//  Created by HeLijuan on 17/2/27.
//  Copyright © 2017年 HeLijuan. All rights reserved.
//

import UIKit

class WorkStudioViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    var dataArray:Array<CourseMicroClassModel>?


    @IBOutlet weak var tableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.removeExtraFooterView()
        self.tableView.separatorInset = UIEdgeInsets.init(top: 0, left: 0, bottom: 0, right: 0)
//        self.tableView.mj_header = MJRefreshNormalHeader(refreshingTarget: self, refreshingAction: #selector(WorkStudioViewController.headRefresh))
//        self.tableView.mj_footer = MJRefreshAutoNormalFooter(refreshingTarget: self, refreshingAction: #selector(WorkStudioViewController.footerRefresh))
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tabBarController?.navigationItem.title = "咨询"
        self.tabBarController?.navigationItem.rightBarButtonItem = nil
        self.tabBarController?.navigationItem.leftBarButtonItem = nil
        self.getData()

    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            if indexPath.row == 0  {
                let cell:WorkStudioItemTableViewCell = tableView.dequeueReusableCell(withIdentifier:"ItemCell", for: indexPath) as! WorkStudioItemTableViewCell
                return cell
            }else{
                let cell:WorkStudioSectionItemTableViewCell = tableView.dequeueReusableCell(withIdentifier:"SectionItemCell", for: indexPath) as! WorkStudioSectionItemTableViewCell
                return cell
            }
        }
        let cell:WorkStudioListTableViewCell = tableView.dequeueReusableCell(withIdentifier:"ListCell", for: indexPath) as! WorkStudioListTableViewCell
        return cell
    }

    func getData() -> Void {
        MBProgressHUDManager.sharedInstance.show(type:.Loading,text:nil, detailText:nil,onView: self.view)
            RequestManager.getCourseAndMicroclassList(pageIndex: 1, pageSize: 20, complete: { (result) in
//                let array = Mapper<CourseMicroClassModel>().map(JSONString: result as! String)
//                self.dataArray = array as! Array<CourseMicroClassModel>?
            }) { (result) in
                MBProgressHUDManager.sharedInstance.show(type: .Text, text: result as? String, detailText: nil, onView: self.view)

        }
    }


    func headRefresh() -> Void {
        print("headRefresh")
    }

    func footerRefresh() -> Void {
        print("footerRefresh")
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
