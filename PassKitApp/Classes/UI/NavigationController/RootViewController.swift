//
//  RootViewController.swift
//  PassKitApp
//
//  Created by Michael Bielodied on 10/10/14.
//  Copyright (c) 2014 Michael Bielodied. All rights reserved.
//

import UIKit

class RootViewController: UIViewController {

    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        let image = UIImage(named: BACK_BUTTON_IMAGE)
        
        let leftView = UIView(frame:  CGRect(x: 0, y: 0, width: (image?.size.width)! * 1.2, height: 35))
        leftView.backgroundColor = UIColor.clear
        
        
        let btn0 = UIButton(frame: CGRect(x: 0,y: 0,width: (image?.size.width)!, height: (image?.size.height)!))
        btn0.setImage(image, for: .normal)
        btn0.addTarget(self, action: #selector(RootViewController.backAction), for: UIControlEvents.touchUpInside)
        leftView.addSubview(btn0)
        

        self.navigationItem.leftBarButtonItem = UIBarButtonItem(customView: leftView)
        
        
        let image1 = UIImage(named: "options_button")
        let image2 = UIImage(named: "ios7-help-icon")

        let rightView = UIView(frame:  CGRect(x: 0, y: 0, width: (image1?.size.width)! * 1.2 + (image2?.size.width)! * 1.2, height: 30))
        rightView.backgroundColor = UIColor.clear
        
        let btn1 = UIButton(frame: CGRect(x: 0,y: 0,width: (image1?.size.width)!, height: (image1?.size.height)!))
        btn1.setImage(image1, for: .normal)
        btn1.addTarget(self, action: #selector(RootViewController.optionsAction), for: UIControlEvents.touchUpInside)
        rightView.addSubview(btn1)
        
        let btn2 = UIButton(frame: CGRect(x: (image1?.size.width)! * 1.2 + 10, y: 0,width: (image2?.size.width)!, height: (image2?.size.height)!))
        btn2.setImage(image2, for: .normal)
        btn2.addTarget(self, action: #selector(RootViewController.helpAction), for: UIControlEvents.touchUpInside)
        rightView.addSubview(btn2)
        
        
        let rightBtn = UIBarButtonItem(customView: rightView)
        self.navigationItem.rightBarButtonItem = rightBtn;
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func backAction() {
        self.navigationController?.popViewController(animated: true)
    }
    
    
    func optionsAction()
    {
        var optionsController:OptionsViewController
        var mainStoryboard:UIStoryboard
        mainStoryboard = UIStoryboard(name: "Main", bundle: nil)
        optionsController  =  mainStoryboard.instantiateViewController(withIdentifier: "Options") as! OptionsViewController
        self.navigationController?.pushViewController(optionsController, animated: true)
    }
    
    func helpAction()
    {
        let alert = UIAlertView()
        alert.title = "Comming soon..."
        alert.message = ""
        alert.addButton(withTitle: BUTTON_TEXT_OK)
        alert.show()
//        let mainView:UIView = UIApplication.sharedApplication().windows.last as UIView
//        var view:UIView = UIView(frame: CGRectMake(0, 0, mainView.frame.size.width, mainView.frame.size.height))
//        view.backgroundColor = UIColor.blackColor()
//        view.alpha = 0.5
//        mainView.addSubview(view)
    }
    
    func hideLeftButton() {
        self.navigationController?.setNavigationBarHidden(false, animated: false)
        self.navigationItem.setHidesBackButton(true, animated: false)
        self.navigationItem.leftBarButtonItem = nil;
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue!, sender: AnyObject!) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
