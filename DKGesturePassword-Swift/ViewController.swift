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
        view.backgroundColor = UIColor.darkGray
        
        initAllControls()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    private func initAllControls() {
        
        let frame: CGRect = CGRect(x: 0.0, y: 0.0, width: view.frame.width, height: view.frame.height)
        let gesturePassword = DKGesturePassword(frame: frame, buttonNumber: 9)
        view.addSubview(gesturePassword)
        gesturePassword.gestureDrawComplete { (password) in
            print(password)
        }
    }
}

