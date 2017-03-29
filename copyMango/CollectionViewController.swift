//
//  CollectionViewController.swift
//  copyMango
//
//  Created by 송시온 on 2017. 3. 26..
//  Copyright © 2017년 송시온. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import SDWebImage

class CollectionViewController: UICollectionViewController,UICollectionViewDelegateFlowLayout, UIPageViewControllerDataSource {
    
    var pageSummary : NSArray!
    var pageImgName : NSArray!
    var mainPageViewController : UIPageViewController!
    
    var mainTitle = [String]()
    var mainImgName  = [String]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        initData()
        self.collectionView?.dataSource = self
        print("next Schedule")
    }
    
    /**
     * 데이터 초기화 함수
     */
    func initData() {
        
        self.mainTitle = []
        self.mainImgName = []
        self.pageImgName = NSArray(objects: "exp2", "exp3")
        self.pageSummary = NSArray(objects: "에디터추천\n3월의 신상 카페", "이런 떡볶이 먹어봤어?\n오늘은 떡튀순으로 가자!")
        
        let param = ["type":10,"location":200,"sort":101,"kind":300,"pageNum":1]
        var count = 1;
        
        Alamofire.request("http://iloveggbb.com/app/main/mainList.php", method: .post, parameters: param).responseJSON { response in
            if let results = response.result.value {
                for result in results as! NSArray{
                    let json = JSON(result)
                    let data = json["open"]
                    let name = json["name"]
                    let thumbnail = json["thumbnail"]
                    
                    self.mainTitle.append(name.stringValue)
                    self.mainImgName.append(thumbnail.stringValue)
                    
                    print("nofilter_\(data)")
                    print("stringValue_\(data.stringValue)")
                    print("string_\(data.string)")
                    print("\(count)번째 \(result)")
                    print("count\(self.mainTitle.count)")
                    //self.items.append(result)
                    count = count+1
                }
            }
            self.collectionView!.reloadData()
        }
    }
    
    /**
     * pageView를 초기화 해주는 함수
     */
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
        print("count_ \(mainImgName.count)")
        return mainImgName.count + 1
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
            let index = indexPath.row - 1
            cell.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.1)
            cell.labelTitle.text = self.mainTitle[index]
            cell.imageView.image = UIImage(named: self.mainImgName[index])
            cell.imageView.sd_setImage(with: URL(string:    self.mainImgName[index]), placeholderImage: UIImage(named:"exp1"))
            
            cell.imageView.frame = CGRect(x: 0, y: 0, width: Int(cell.frame.width), height: Int(cell.frame.height/3 * 2))
            
            cell.labelTitle.frame = CGRect(x:0, y: Int(cell.imageView.frame.height), width:Int(cell.frame.width), height: 30)

            return cell
        }
    }
    
    /**
     *  각 cell의 사이즈를 변경해주는 함수
     */
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let row = indexPath.row
        
        if row == 0 {
            let sizes = CGSize(width: self.view.frame.width - 16, height: self.view.frame.width / 2)
            return sizes
        }
        else {
            let sizes = CGSize(width: view.frame.width / 2 - 12, height: (view.frame.width / 2 - 12) * 4/3)
            return sizes
        }
    }
}
