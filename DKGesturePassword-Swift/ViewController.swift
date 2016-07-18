//
//  ViewController.swift
//  DKGesturePassword-Swift
//
//  Created by NSLog on 16/7/18.
//  Copyright © 2016年 DK-Coder. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        view.backgroundColor = UIColor.whiteColor()
        
        initAllControls()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    private func initAllControls() {
        
        let frame: CGRect = CGRectMake(0.0, 0.0, CGRectGetWidth(view.frame), CGRectGetHeight(view.frame))
        let gesturePassword = DKGesturePassword.init(frame: frame, buttonNumber: 9)
        view.addSubview(gesturePassword)
    }
}

