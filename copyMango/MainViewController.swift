//
//  m_firstViewController.swift
//  copyMango
//
//  Created by 송시온 on 2017. 3. 23..
//  Copyright © 2017년 송시온. All rights reserved.
//

import UIKit
import GuillotineMenu

class MainViewController: UIViewController {
    fileprivate lazy var presentationAnimator = GuillotineTransitionAnimation()
    
    @IBOutlet var viewFrame: UIView!
    @IBOutlet fileprivate var barButton: UIButton!


    var collectionVC : CollectionViewController!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Title"
        let navBar = self.navigationController!.navigationBar
        navBar.barTintColor = UIColor.orange
        navBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.white]
        
        initCollection()
    }
    
    @IBAction func showMenuAction(_ sender: UIButton) {
        let menuViewController = self.storyboard!.instantiateViewController(withIdentifier: "MenuViewController") as! MenuViewController
        menuViewController.modalPresentationStyle = .custom
        menuViewController.transitioningDelegate = self
        
        presentationAnimator.animationDelegate = menuViewController as? GuillotineAnimationDelegate
        presentationAnimator.supportView = navigationController!.navigationBar
        presentationAnimator.presentButton = sender
        self.present(menuViewController, animated: true, completion: nil)
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
    }
}

extension MainViewController: UIViewControllerTransitioningDelegate {
    
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        presentationAnimator.mode = .presentation
        return presentationAnimator
    }
    
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        presentationAnimator.mode = .dismissal
        return presentationAnimator
    }
}
