//
//  OptionsViewController.swift
//  PassKitApp
//
//  Created by Michael Bielodied on 10/10/14.
//  Copyright (c) 2014 Michael Bielodied. All rights reserved.
//

import UIKit

class OptionsViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        let image = UIImage(named: BACK_BUTTON_IMAGE)
        let leftView = UIView(frame:  CGRect(x: 0, y: 0, width: (image?.size.width)! * 1.2, height: 35))

        leftView.backgroundColor = UIColor.clear
        
        let btn0 = UIButton(frame: CGRect(x: 0,y: 0,width: (image?.size.width)!, height: (image?.size.height)!))
        btn0.setImage(image, for: .normal)
        btn0.addTarget(self, action: #selector(OptionsViewController.backAction), for: UIControlEvents.touchUpInside)
        leftView.addSubview(btn0)
        
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(customView: leftView)
        
        
        let image2 = UIImage(named: "ios7-help-icon")
        
        let rightView = UIView(frame:  CGRect(x: 0, y: 0, width: (image2?.size.width)! * 1.2, height: 30))
        rightView.backgroundColor = UIColor.clear
        
        
        let btn2 = UIButton(frame: CGRect(x: 0, y: 0,width: (image2?.size.width)!, height: (image2?.size.height)!))
        btn2.setImage(image2, for: .normal)
        btn2.addTarget(self, action: #selector(OptionsViewController.helpAction), for: UIControlEvents.touchUpInside)
        rightView.addSubview(btn2)
        
        
        let rightBtn = UIBarButtonItem(customView: rightView)
        self.navigationItem.rightBarButtonItem = rightBtn;

    }

    func helpAction()
    {
        let alert = UIAlertView()
        alert.title = "Comming soon..."
        alert.message = ""
        alert.addButton(withTitle: BUTTON_TEXT_OK)
        alert.show()
    }

    
    func backAction() {
        self.navigationController?.popViewController(animated: true)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
