//
//  CollectionViewController.swift
//  copyMango
//
//  Created by 송시온 on 2017. 3. 26..
//  Copyright © 2017년 송시온. All rights reserved.
//

import UIKit

class CollectionViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout, UIPageViewControllerDataSource {
    
    var pageSummary : NSArray!
    var pageImgName : NSArray!
    var mainPageViewController : UIPageViewController!

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.red
        
        self.pageImgName = NSArray(objects: "exp2", "exp3")
        self.pageSummary = NSArray(objects: "에디터추천\n3월의 신상 카페", "이런 떡볶이 먹어봤어?\n3월의 신상 카페")
    }
    
    func initPageView(cell:UICollectionViewCell){
        self.mainPageViewController = self.storyboard?.instantiateViewController(withIdentifier: "MainPageVC") as? PageViewController
        
        self.mainPageViewController.dataSource = self
        
        let startVC = self.viewControllerAtIndex(index: 0) as MainTopContentVC
        let viewControllers = NSArray(object: startVC)
        
        self.mainPageViewController.setViewControllers(viewControllers as? [UIViewController] , direction: .forward, animated: true, completion: nil)
        self.mainPageViewController.view.frame = CGRect(x:0,y:0,width:cell.frame.width, height:cell.frame.height)
        
        self.addChildViewController(self.mainPageViewController)
        cell.addSubview(self.mainPageViewController.view)
        
        
        let pageController = UIPageControl.appearance()
        pageController.pageIndicatorTintColor = UIColor.white
        pageController.currentPageIndicatorTintColor = UIColor.orange
    }
    
    
    /**
     * viewPageController 구성 함수
     */
    func viewControllerAtIndex (index : Int) -> MainTopContentVC {
        
        let vc : MainTopContentVC = self.storyboard?.instantiateViewController(withIdentifier: "MainTopContentVC") as! MainTopContentVC
        
        vc.pageIndex = index
        vc.imageName = self.pageImgName[index] as! String
        vc.summary = self.pageSummary[index] as! String
        
        return vc
    }
    
    
    /**
     * 이전 ViewPageController 구성
     */
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        
        let vc = viewController as! MainTopContentVC
        var index = vc.pageIndex as Int
        
        if( index == 0 || index == NSNotFound) {
            return nil
        }
        
        index -= 1
        
        return self.viewControllerAtIndex(index: index)
    }
    
    
    /**
     * 이후 ViewPageController 구성
     */
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        
        let vc = viewController as! MainTopContentVC
        
        var index = vc.pageIndex as Int
        
        if( index == NSNotFound) {
            return nil
        }
        
        index += 1
        
        if (index == self.pageImgName.count) {
            return nil
        }
        
        return self.viewControllerAtIndex(index: index)
    }
    
    
    
    /**
     * 인디케이터의 총 갯수
     */
    func presentationCount(for pageViewController: UIPageViewController) -> Int {
        return self.pageImgName.count
    }
    
    
    /**
     * 인디케이터의 시작 포지션
     */
    func presentationIndex(for pageViewController: UIPageViewController) -> Int {
        return 0
    }

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return 30
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        print(indexPath.row)
        if(indexPath.row == 0){
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "TopImgCell", for: indexPath) as! TopImgCell
            cell.backgroundColor = UIColor.red
            initPageView(cell:cell)
            return cell
        }
        else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MainCell", for: indexPath) as! MainCell
            cell.labelTitle.text = "Title"
            
            cell.backgroundColor = UIColor.green
            
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let row = indexPath.row
        
        if row == 0 {
            let sizes = CGSize(width: self.view.frame.width - 16, height: self.view.frame.width / 2 - 16)
            return sizes
        }
        else {
            let sizes = CGSize(width: view.frame.width / 2 - 12, height: view.frame.width / 2 - 16)
            return sizes
        }
    }
}
