//
//  m_firstViewController.swift
//  copyMango
//
//  Created by 송시온 on 2017. 3. 23..
//  Copyright © 2017년 송시온. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {
    @IBOutlet var viewFrame: UIView!
    var pageImages : NSArray!
    var collectionVC : CollectionViewController!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 1. tableview를 셋팅한다.
        // 2-1. TopImgCell을 만든다.
        // 2-2. Cell안에 CollectionView를 만든다.(Controller도 포함)
        // 3. BetweenCell을 만든다.
        // 4. ContentsCell을 만든다.
        print("mainview")
        self.pageImages = NSArray(objects: "exp1","exp2","exp3")
        
        initCollection()
    }
    
    func initCollection(){
        
        collectionVC = self.storyboard!.instantiateViewController(withIdentifier: "CollectionViewController") as! CollectionViewController
        
        self.collectionVC.view.frame = viewFrame.frame
        self.collectionVC.view.translatesAutoresizingMaskIntoConstraints = false
        
        self.addChildViewController(collectionVC)
        self.view.addSubview(collectionVC.view)
        self.collectionVC.didMove(toParentViewController: self)
        
        NSLayoutConstraint.activate([
            self.collectionVC.view.topAnchor.constraint(equalTo: viewFrame.topAnchor),
            self.collectionVC.view.leadingAnchor.constraint(equalTo: viewFrame.leadingAnchor),
            self.collectionVC.view.trailingAnchor.constraint(equalTo: viewFrame.trailingAnchor),
            self.collectionVC.view.bottomAnchor.constraint(equalTo: viewFrame.bottomAnchor)])

        
        let con = UIPageControl.appearance()
        con.currentPageIndicatorTintColor = UIColor.orange
        con.pageIndicatorTintColor = UIColor.white

    }
}
