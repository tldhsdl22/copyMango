//
//  IntroPageViewController.swift
//  copyMango
//
//  Created by 송시온 on 2017. 3. 23..
//  Copyright © 2017년 송시온. All rights reserved.
//

import UIKit

class PageViewController: UIPageViewController {
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        
        let subViews: NSArray = view.subviews as NSArray
        var scrollView: UIScrollView? = nil
        var pageControl: UIPageControl? = nil
        
        for view in subViews {
            if (view as AnyObject).isKind(of: UIScrollView.self) {
                scrollView = view as? UIScrollView
            }
            else if (view as AnyObject).isKind(of: UIPageControl.self) {
                pageControl = view as? UIPageControl
            }
        }
        
        if (scrollView != nil && pageControl != nil) {
            scrollView?.frame = view.bounds
            view.bringSubview(toFront: pageControl!)
        }
    }
}
