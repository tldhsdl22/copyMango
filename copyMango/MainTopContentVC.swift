//
//  MainTopContetnVC.swift
//  copyMango
//
//  Created by 송시온 on 2017. 3. 23..
//  Copyright © 2017년 송시온. All rights reserved.
//

import UIKit

class MainTopContentVC: UIViewController {
    @IBOutlet var labelCommend: UILabel!
    @IBOutlet var labelSummary: UILabel!
    @IBOutlet var imageView: UIImageView!
    var imageName:String!
    var summary:String!
    var pageIndex:Int!

    override func viewDidLoad() {
        super.viewDidLoad()
        labelCommend.layer.masksToBounds = true
        labelCommend.layer.cornerRadius = 15.0
        labelSummary.text = summary
        imageView.image = UIImage(named: imageName)
        

        // Do any additional setup after loading the view.
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
