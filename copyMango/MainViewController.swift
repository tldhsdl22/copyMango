//
//  m_firstViewController.swift
//  copyMango
//
//  Created by 송시온 on 2017. 3. 23..
//  Copyright © 2017년 송시온. All rights reserved.
//

import UIKit

class MainViewController: UIViewController, UIPageViewControllerDataSource, UICollectionViewDataSource {
    var pageImages : NSArray!
    var pageSummary : NSArray!
    var mainPageViewController : PageViewController!
    @IBOutlet var topImageView: UIView!
    @IBOutlet var mainView: UIView!
    
    var contentImages : NSArray!
    var contentTitles : NSArray!
    var contentPosition : NSArray!
    var contentCount : NSArray!


    override func viewDidLoad() {
        super.viewDidLoad()
        self.contentImages = NSArray(objects: "exp2", "exp3", "exp2", "exp3","exp2", "exp3","exp2", "exp3","exp2", "exp3")
        self.contentTitles = NSArray(objects: "exp2", "exp3", "exp2", "exp3","exp2", "exp3","exp2", "exp3","exp2", "exp3")
        self.contentPosition = NSArray(objects: "exp2", "exp3", "exp2", "exp3","exp2", "exp3","exp2", "exp3","exp2", "exp3")
        self.contentCount = NSArray(objects: "222", "333", "444", "5555","exp2", "exp3","exp2", "exp3","exp2", "exp3")

        
        self.pageImages = NSArray(objects: "exp2", "exp3")
        self.pageSummary = NSArray(objects: "에디터추천\n3월의 신상 카페", "이런 떡볶이 먹어봤어?\n3월의 신상 카페")

        mainPageViewController = self.storyboard!.instantiateViewController(withIdentifier: "MainPageVC") as! PageViewController
        self.mainPageViewController.dataSource = self
        
        let viewControllers = self.viewControllerAtIndex(index: 0)
        self.mainPageViewController.setViewControllers([viewControllers], direction: .forward, animated: true, completion: nil)
        //self.mainPageViewController.view.frame = topImageView.frame //시작위치 먹고
        
        self.mainPageViewController.view.translatesAutoresizingMaskIntoConstraints = false

        self.addChildViewController(mainPageViewController)
        self.mainView.addSubview(mainPageViewController.view)
        self.mainPageViewController.didMove(toParentViewController: self)
        
        
        NSLayoutConstraint.activate([
            self.mainPageViewController.view.topAnchor.constraint(equalTo: topImageView.topAnchor),
            self.mainPageViewController.view.leadingAnchor.constraint(equalTo: topImageView.leadingAnchor),
            self.mainPageViewController.view.trailingAnchor.constraint(equalTo: topImageView.trailingAnchor),
            self.mainPageViewController.view.bottomAnchor.constraint(equalTo: topImageView.bottomAnchor)])

        
        let con = UIPageControl.appearance()
        con.currentPageIndicatorTintColor = UIColor.orange
        con.pageIndicatorTintColor = UIColor.white
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    /**
     * viewPageController 구성 함수
     */
    func viewControllerAtIndex (index : Int) -> MainTopContetnVC {
        
        let vc : MainTopContetnVC = self.storyboard?.instantiateViewController(withIdentifier: "MainTopContetnVC") as! MainTopContetnVC
        
        vc.pageIndex = index
        vc.imageName = self.pageImages[index] as! String
        vc.summary = self.pageSummary[index] as! String
        
        return vc
    }
    
    
    /**
     * 이전 ViewPageController 구성
     */
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        
        let vc = viewController as! MainTopContetnVC
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
        
        let vc = viewController as! MainTopContetnVC
        
        var index = vc.pageIndex as Int
        
        if( index == NSNotFound) {
            return nil
        }
        
        index += 1
        
        if (index == self.pageImages.count) {
            return nil
        }
        
        return self.viewControllerAtIndex(index: index)
    }
    
    
    
    /**
     * 인디케이터의 총 갯수
     */
    func presentationCount(for pageViewController: UIPageViewController) -> Int {
        return self.pageImages.count
    }
    
    
    /**
     * 인디케이터의 시작 포지션
     */
    func presentationIndex(for pageViewController: UIPageViewController) -> Int {
        return 0
    }
    
    //collectionView 함수
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return contentImages.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MainCollectionViewCell", for: indexPath) as! MainCollectionViewCell
        
        let row = indexPath.row
        cell.labelTitle.text = self.contentTitles[row] as! String
        cell.imageView.image = UIImage(named: self.contentImages[row] as! String)
        cell.labelPosition.text = self.contentPosition[row] as! String
        cell.labelCount.text = self.contentCount[row] as! String
        
        return cell
    }
    

}
