//
//  ArticleViewController.swift
//  TCMManager_Swift
//
//  Created by HeLijuan on 17/3/14.
//  Copyright © 2017年 HeLijuan. All rights reserved.
//

import UIKit

class ArticleViewController: UIViewController,UIWebViewDelegate {

    @IBOutlet weak var webView: UIWebView!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.automaticallyAdjustsScrollViewInsets = false
        self.title = "文章"
        webView.loadRequest(NSURLRequest(url: NSURL(string: "https://mp.weixin.qq.com/s/qXLwXDnfesKe7nNiYJRIJw")! as URL) as URLRequest)
        // Do any additional setup after loading the view.
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
