//
//  TeachingCenterViewController.swift
//  TCMManager_Swift
//
//  Created by HeLijuan on 17/4/24.
//  Copyright © 2017年 HeLijuan. All rights reserved.
//

import UIKit

class TeachingCenterViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    var dataArray:Array<TeachingCenterListModel> = []
    var pageIndex:Int = 1

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "患教中心"
        self.automaticallyAdjustsScrollViewInsets = false
        self.tableView.register(UINib.init(nibName: "TeachingCenterTableViewCell", bundle: nil), forCellReuseIdentifier: "TeachingCenterTableViewCell")
        self.tableView.rowHeight = UITableViewAutomaticDimension
        self.tableView.estimatedRowHeight = 150
        self.tableView.removeExtraFooterView()
        self.tableView.mj_header = MJRefreshNormalHeader(refreshingTarget: self, refreshingAction: #selector(TeachingCenterViewController.headRefresh))
        self.tableView.mj_footer = MJRefreshBackStateFooter(refreshingTarget: self, refreshingAction: #selector(TeachingCenterViewController.footerRefresh))
        self.headRefresh()
        // Do any additional setup after loading the view.
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

    func getData() -> Void {
        RequestManager.getTeachingCenterList(page: pageIndex, complete: { (result) in
            if result != nil{
            if self.pageIndex == 1 {
                self.dataArray = (result as! Array<TeachingCenterListModel>?)!
            }else{
                let resultArray:Array<TeachingCenterListModel> = (result as! Array<TeachingCenterListModel>?)!
                if resultArray.count > 0{
                    self.dataArray = self.dataArray + resultArray
                }else{
                    self.pageIndex = self.pageIndex - 1
                }
            }
            }
            self.endRefresh()
            self.tableView.reloadData()
        }) { (result) in
            MBProgressHUDManager.sharedInstance.show(type: .Text, text: result.1 as? String, detailText: nil, onView: self.view)
            self.pageIndex = self.pageIndex - 1
            self.endRefresh()
            self.checkToken(requestCode: result.0)
        }
    }


    func numberOfSections(in tableView: UITableView) -> Int {
        return self.dataArray.count
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 10
    }

    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:TeachingCenterTableViewCell = tableView.dequeueReusableCell(withIdentifier:"TeachingCenterTableViewCell", for: indexPath) as! TeachingCenterTableViewCell
        cell.selectionStyle = .none
        cell.contentLabel.text = self.dataArray[indexPath.section].content
        cell.readNumberLabel.text = "浏览".appending(IntToString(intValue: self.dataArray[indexPath.section].viewCount!) as String)
        cell.agreeButton .setTitle(IntToString(intValue: self.dataArray[indexPath.section].agreeCount!) as String, for: .normal)
        var commentString:String = ""
        let arraylist = self.dataArray[indexPath.section].commentList
        if arraylist != nil {
            for data in arraylist! {
                commentString = commentString.appending((data.name?.appending(":").appending(data.content!))!.appending("\n"))
            }
            let index = commentString.index(commentString.startIndex, offsetBy: commentString.characters.count - 2)
            cell.messageLabel.text = commentString.substring(to: index)
        }else{
            cell.messageLabel.text = nil
        }
        cell.updateCollectionView(imagesArray:self.dataArray[indexPath.section].images)
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }

    @IBAction func teachingLibrary(_ sender: Any) {
    }
    @IBAction func pasteLink(_ sender: Any) {
    }
    @IBAction func sendShortArticle(_ sender: Any) {
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
