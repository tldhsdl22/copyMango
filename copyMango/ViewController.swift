//
//  ViewController.swift
//  copyMango
//
//  Created by 송시온 on 2017. 3. 23..
//  Copyright © 2017년 송시온. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIPageViewControllerDataSource {
    @IBOutlet var blindView: UIImageView!
    @IBOutlet var blindLabel: UILabel!
    @IBOutlet var blindViewHeight: NSLayoutConstraint!
    var pageViewController : PageViewController!
    var pageImages : NSArray!
    
    @IBOutlet var btnFacebook: UIButton!
    @IBOutlet var btnKaKao: UIButton!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.pageImages = NSArray(objects: "exp1","exp2","exp3")
        
        initPageImage()
        initBlindImage()
        controlsDesign()
    }
    
    func controlsDesign() {
        btnFacebook.layer.cornerRadius = 27.0
        btnKaKao.layer.cornerRadius = 27.0
    }
    
    func initPageImage() {
        pageViewController = self.storyboard!.instantiateViewController(withIdentifier: "PageViewController") as! PageViewController
        self.pageViewController.dataSource = self
        
        let pageContentViewController = self.viewControllerAtIndex(index: 0)
        self.pageViewController.setViewControllers([pageContentViewController], direction: .forward, animated: true, completion: nil)
        
        self.pageViewController.view.frame = CGRect(x: 0, y: 0, width: self.view.frame.size.width , height: self.view.frame.size.height/3 * 2 - 40)
        
        self.addChildViewController(pageViewController)
        self.view.addSubview(pageViewController.view)
        self.pageViewController.didMove(toParentViewController: self)
        
        let con = UIPageControl.appearance()
        con.currentPageIndicatorTintColor = UIColor.orange
        con.pageIndicatorTintColor = UIColor.white
    }
    
    func initBlindImage() {
        blindViewHeight.constant = self.view.frame.size.height/3 * 2 - 40
        self.view.bringSubview(toFront: self.blindView)
        self.view.bringSubview(toFront: self.blindLabel)
        self.blindView.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.1)
        self.blindLabel.text = "응답하라\n경기북부"
        
    }
        
        
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    /**
     * viewPageController 구성 함수
     */
    func viewControllerAtIndex (index : Int) -> ContentViewController {
        
        let vc : ContentViewController = self.storyboard?.instantiateViewController(withIdentifier: "ContentViewController") as! ContentViewController
        
        vc.pageIndex = index
        vc.imageName = self.pageImages[index] as! String
        
        return vc
    }
    
    
    
    /**
     * 이전 ViewPageController 구성
     */
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        
        let vc = viewController as! ContentViewController
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
        
        let vc = viewController as! ContentViewController
        
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
    @IBAction func loginFacebook(_ sender: Any) {
        let storyboards:UIStoryboard = UIStoryboard(name: "MainPage", bundle: nil)
        
        guard let destVC = storyboards.instantiateViewController(withIdentifier: "MainViewController") as? MainViewController else {
            return
        }
        
        self.show(destVC, sender: self)
    }


}

