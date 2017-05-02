//
//  WorkStudioViewController.swift
//  TCMManager_Swift
//
//  Created by HeLijuan on 17/2/27.
//  Copyright © 2017年 HeLijuan. All rights reserved.
//

import UIKit

class WorkStudioViewController: UIViewController,UITableViewDelegate,UITableViewDataSource,BannerCellDelegate {
    var dataArray:Array<CourseMicroClassModel> = []
    var activityArray:Array<ActivityListModel> = []

    var pageIndex:Int = 1

    @IBOutlet weak var tableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.dataArray = Array.init()
        self.tableView.removeExtraFooterView()
        self.tableView.separatorInset = UIEdgeInsets.init(top: 0, left: 0, bottom: 0, right: 0)
        self.tableView.mj_header = MJRefreshNormalHeader(refreshingTarget: self, refreshingAction: #selector(WorkStudioViewController.headRefresh))
        self.tableView.mj_footer = MJRefreshAutoNormalFooter(refreshingTarget: self, refreshingAction: #selector(WorkStudioViewController.footerRefresh))
        self.headRefresh()
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 100
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tabBarController?.navigationItem.title = "工作室"
        self.tabBarController?.navigationItem.rightBarButtonItem = nil
        self.tabBarController?.navigationItem.leftBarButtonItem = nil
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return section == 0 ? activityArray.count > 0 ? 3 : 2 :(self.dataArray.count)
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            if activityArray.count > 0 {
                if indexPath.row == 0  {
                    let cell:BannerTableViewCell = tableView.dequeueReusableCell(withIdentifier:"CollectionCell", for: indexPath) as! BannerTableViewCell
                    cell.setImageArray(array: activityArray)
                    cell.delegate = self
                    return cell
                }else if indexPath.row == 1  {
                    let cell:WorkStudioItemTableViewCell = tableView.dequeueReusableCell(withIdentifier:"ItemCell", for: indexPath) as! WorkStudioItemTableViewCell
                    return cell
                }else{
                    let cell:WorkStudioSectionItemTableViewCell = tableView.dequeueReusableCell(withIdentifier:"SectionItemCell", for: indexPath) as! WorkStudioSectionItemTableViewCell
                    return cell
                }
            }else{
                if indexPath.row == 0  {
                    let cell:WorkStudioItemTableViewCell = tableView.dequeueReusableCell(withIdentifier:"ItemCell", for: indexPath) as! WorkStudioItemTableViewCell
                    return cell
                }else{
                    let cell:WorkStudioSectionItemTableViewCell = tableView.dequeueReusableCell(withIdentifier:"SectionItemCell", for: indexPath) as! WorkStudioSectionItemTableViewCell
                    return cell
                }
            }
        }
        let cell:WorkStudioListTableViewCell = tableView.dequeueReusableCell(withIdentifier:"ListCell", for: indexPath) as! WorkStudioListTableViewCell
        cell.titleLabel.text = dataArray[indexPath.row].title
        cell.detailImageView.setImageUrl(url: dataArray[indexPath.row].coverImageUrl)
        cell.isMicroClassImageView.isHidden = dataArray[indexPath.row].hnsType == 1;
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        if indexPath.section == 1 {
            self.navigationController?.pushViewController(ArticleViewController(), animated: true)
        }
    }

    func getData() -> Void {
            RequestManager.getCourseAndMicroclassList(pageIndex: pageIndex, pageSize: 20, complete: { (result) in
                if self.pageIndex == 1 {
                    self.dataArray = (result as! Array<CourseMicroClassModel>?)!
                }else{
                    let resultArray:Array<CourseMicroClassModel> = (result as! Array<CourseMicroClassModel>?)!
                     self.dataArray = self.dataArray + resultArray
                }
                self.endRefresh()
                self.tableView.reloadData()
            }) { (result) in
                MBProgressHUDManager.sharedInstance.show(type: .Text, text: result.1 as? String, detailText: nil, onView: self.view)
                self.pageIndex = self.pageIndex - 1
                self.endRefresh()
                self.checkToken(requestCode: result.0)
        }
        self.getActivityListData()
    }

    func getActivityListData() -> Void {
              RequestManager.getActivityList(showType: 2, complete: { (result) in
                self.activityArray = (result as! Array<ActivityListModel>?)!
                self.tableView.reloadData()
              }) { (result) in

        }
    }

    func headRefresh() -> Void {
        pageIndex = 1
        self.getData()
    }

    func footerRefresh() -> Void {
        pageIndex = pageIndex + 1
        self.getData()
    }

    func endRefresh() -> Void {
        self.tableView.mj_header.endRefreshing()
        self.tableView.mj_footer.endRefreshing()
    }

    func clickedBannerView(selectedIndex index: Int){
        let model = activityArray[index]
        let vc = ArticleViewController()
        vc.title = model.shareTitle
         vc.url = PRE_URL.appending("/web/get-activity-detail?activityId=").appending(model.activityId!)
        if (model.addIsMingyiApp == 1) {
            vc.url = vc.url?.appending("&isMingyiApp=1")
        }
        if (model.addDoctorId == 1) {
            vc.url = vc.url?.appending("&doctorId=").appending((UserManager.sharedInstance.currentUser?.doctorId)!)
        }
        self.navigationController?.pushViewController(vc, animated: true)
    }

    @IBAction func tapMicroClass(_ sender: Any) {
        print("micr")

    }
    @IBAction func tapAirHouse(_ sender: Any) {
        print("house")

    }

    @IBAction func clickTeachingButton(_ sender: Any) {

        self.navigationController?.pushViewController(TeachingCenterViewController(), animated: true)
    }

    @IBAction func clickSitButton(_ sender: Any) {

    }
    @IBAction func clickNotifyButton(_ sender: Any) {

    }
    @IBAction func clickBannerButton(_ sender: Any) {

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
