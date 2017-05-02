//
//  GuideViewController.swift
//  TCMManager_Swift
//
//  Created by HeLijuan on 17/2/7.
//  Copyright © 2017年 HeLijuan. All rights reserved.
//

import UIKit
import Alamofire
class GuideViewController: UIViewController {
    let pageCount = 3

    @IBOutlet weak var scrollView: UIScrollView!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.initView()
        // Do any additional setup after loading the view.
    }
    func initView() -> Void {
        self.navigationController?.navigationBar.isHidden = true
        scrollView.contentSize = CGSize.init(width: ScreenWidth*CGFloat(pageCount), height: 0)
        for  index in 0...pageCount{
            let  imageView = UIImageView.init(frame: CGRect.init(x: CGFloat(index)*ScreenWidth, y: 0, width: ScreenWidth, height: ScreenHeight))
            imageView.image = UIImage.init(named: "guideImage".appendingFormat("%d", index+1))
            scrollView.addSubview(imageView)
            if index == 2 {
                let nextButton = UIButton.init(type: .custom)
                nextButton.frame = CGRect.init(x: 0, y: 0, width: 100, height: 40)
                nextButton.center = CGPoint.init(x: imageView.center.x, y: ScreenHeight - 80)
                nextButton.setTitle("立即进入", for: .normal)
                nextButton.setTitleColor(MainColor, for: .normal)
                nextButton.addTarget(self, action: #selector(GuideViewController.next(_ :)), for: .touchUpInside)
                nextButton.layer.masksToBounds = true
                nextButton.layer.cornerRadius = 5
                nextButton.layer.borderColor = MainColor.cgColor
                nextButton.layer.borderWidth = 1
                scrollView.addSubview(nextButton)
            }
        }
    }


  open  func next(_ button:UIButton) {
        if ((UserManager.sharedInstance.currentUser?.token) != nil){
            let mainStoryboard = UIStoryboard.init(name: "Main", bundle: nil)
            let mainTabVC = mainStoryboard.instantiateViewController(withIdentifier: "MainTabBarController")
            self.navigationController?.pushViewController(mainTabVC, animated: true)
        }else{
            let vc = LoginViewController.init()
            self.navigationController?.pushViewController(vc, animated: true)
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
