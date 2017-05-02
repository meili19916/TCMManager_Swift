//
//  TeachingCenterTableViewCell.swift
//  TCMManager_Swift
//
//  Created by HeLijuan on 17/4/24.
//  Copyright © 2017年 HeLijuan. All rights reserved.
//

import UIKit

class TeachingCenterTableViewCell: UITableViewCell,UICollectionViewDelegate,UICollectionViewDataSource {
    @IBOutlet weak var layout: TeachingFlowLayout!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var commentButton: UIButton!
    @IBOutlet weak var collectionHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var messageLabel: UILabel!
    @IBOutlet weak var agreeButton: UIButton!
    @IBOutlet weak var shareButton: UIButton!
    @IBOutlet weak var readNumberLabel: UILabel!
    @IBOutlet weak var contentLabel: UILabel!
    var imageArray:Array<String> = []


    @IBAction func comment(_ sender: Any) {

    }
    override func awakeFromNib() {
        super.awakeFromNib()
        agreeButton.layer.masksToBounds = true
        agreeButton.layer.cornerRadius = 12
        agreeButton.layer.borderColor = commentButton.titleLabel?.textColor.cgColor
        agreeButton.layer.borderWidth = 0.5

        shareButton.layer.masksToBounds = true
        shareButton.layer.cornerRadius = 12
        shareButton.layer.borderColor = commentButton.titleLabel?.textColor.cgColor
        shareButton.layer.borderWidth = 0.5

        commentButton.layer.masksToBounds = true
        commentButton.layer.borderColor = commentButton.titleLabel?.textColor.cgColor
        commentButton.layer.borderWidth = 0.5
        collectionView.register(UINib(nibName:"TeachingImageCollectionViewCell",bundle:nil), forCellWithReuseIdentifier: "collectionCell")
        collectionView.contentInset = UIEdgeInsets.init(top: 10, left: 0, bottom: 0, right: 0)
        collectionView.delegate = self
        collectionView.dataSource = self
        layout.itemSize = CGSize.init(width: 60, height: 60)
        layout.minimumInteritemSpacing = 10
        layout.minimumLineSpacing = 10
        // Initialization code
    }

    func updateCollectionView(imagesArray:Array<String>?) -> Void {
        if imagesArray == nil {
            collectionHeightConstraint.constant = 0
            return
        }else{
            collectionHeightConstraint.constant = 80
        }
        imageArray = imagesArray!
        collectionView.reloadData()
    }

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return imageArray.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell:TeachingImageCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier:"collectionCell", for: indexPath) as! TeachingImageCollectionViewCell
        cell.imageView.setImageUrl(url: imageArray[indexPath.row])
        return cell
    }


    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
