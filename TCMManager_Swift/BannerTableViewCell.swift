//
//  BannerTableViewCell.swift
//  TCMManager_Swift
//
//  Created by HeLijuan on 17/3/9.
//  Copyright © 2017年 HeLijuan. All rights reserved.
//

import UIKit

class BannerTableViewCell: UITableViewCell,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {

    @IBOutlet weak var flowLayout: UICollectionViewFlowLayout!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var pageControl: UIPageControl!
    var timer:Timer?
    var activityArray:Array<ActivityListModel> = []


    override func awakeFromNib() {
        super.awakeFromNib()
        collectionView.delegate = self
        collectionView.dataSource = self
        flowLayout.itemSize = CGSize.init(width: ScreenWidth, height: 100)
        collectionView.showsHorizontalScrollIndicator = false
        // Initialization code
    }

    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return activityArray.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "BannerCell", for: indexPath as IndexPath) as! BannerCollectionViewCell
        cell.bannerImageView.setImageUrl(url: activityArray[indexPath.row].imageUrl)
        return cell
    }

  public  func beginScroll() -> Void {
        self.pageControl.numberOfPages = self.activityArray.count
        self.collectionView.reloadData()
        self.addTimer()
    }

    func changePage() -> Void {
        pageControl.currentPage = pageControl.currentPage + 1
        if pageControl.currentPage == activityArray.count - 1 {
            pageControl.currentPage = 0
        }
        collectionView.scrollToItem(at: IndexPath.init(row: pageControl.currentPage, section: 0), at: .left, animated: false)
    }

    func removeTimer(){
        self.timer?.invalidate()
    }

    func addTimer(){
        self.timer = Timer.scheduledTimer(timeInterval: 2,
                                          target:self,selector:#selector(BannerTableViewCell.changePage),
                                          userInfo:nil,repeats:true)
    }

    //  重新添加定时器
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        self.addTimer()
    }
    // 手动滑动的时候销毁定时器
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        self.removeTimer()
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
