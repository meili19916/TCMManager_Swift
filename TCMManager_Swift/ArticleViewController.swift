//
//  ArticleViewController.swift
//  TCMManager_Swift
//
//  Created by HeLijuan on 17/3/14.
//  Copyright © 2017年 HeLijuan. All rights reserved.
//

import UIKit

class ArticleViewController: UIViewController,UIWebViewDelegate {
    var url:String?

    @IBOutlet weak var webView: UIWebView!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.automaticallyAdjustsScrollViewInsets = false
        if url == nil {
            self.title = "文章"
            url = "https://mp.weixin.qq.com/s/qXLwXDnfesKe7nNiYJRIJw"
        }
        webView.loadRequest(URLRequest.init(url: URL.init(string: url!)!))

        // Do any additional setup after loading the view.
    }
    func webViewDidStartLoad(_ webView: UIWebView) {
        MBProgressHUDManager.sharedInstance.show(type:.Loading,text:nil, detailText:nil,onView: self.view)
    }
    func webViewDidFinishLoad(_ webView: UIWebView) {
        MBProgressHUDManager.sharedInstance.dissmiss()
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
