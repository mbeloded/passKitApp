//
//  AlertManager.swift
//  PassKitApp
//
//  Created by Michael Bielodied on 10/8/14.
//  Copyright (c) 2014 Michael Bielodied. All rights reserved.
//

import Foundation

class AlertManager: NSObject{
    
    static let sharedInstance = AlertManager()
    
    // PRIVATE
    fileprivate override init() {
        super.init()
    }
    
    func showAlert(_ title: String, msg:String, delegate:UIAlertViewDelegate?, btn:String)
    {
        
//        if let gotModernAlert: AnyClass = NSClassFromString("UIAlertController") {
//            
//            var alert : UIAlertController = UIAlertController(title: title, message: msg, preferredStyle: UIAlertControllerStyle.Alert)
//            alert.addAction(UIAlertAction(title: title, style:.Default, handler: nil))
//            vc.presentViewController(alert, animated: true, completion: nil)
//            
//        } else
//        {
        
            let alert = UIAlertView()
            alert.title = title
            alert.message = msg
            alert.delegate = delegate
            alert.addButton(withTitle: btn)
            alert.show()
            
//        }
        
    }
    
    func showAlert(_ title: String, errorMsg:String, delegate:UIAlertViewDelegate?, cancelBtn:String, otherBtn:String, vc:UIViewController)
    {
        
        if let gotModernAlert: AnyClass = NSClassFromString("UIAlertController") {
            
            if #available(iOS 8.0, *) {
                let alert : UIAlertController = UIAlertController(title: title, message: errorMsg, preferredStyle: UIAlertControllerStyle.alert)
                alert.addAction(UIAlertAction(title: title, style:.default, handler: nil))
                vc.present(alert, animated: true, completion: nil)
            } else {
                // Fallback on earlier versions
            }
            
            
        } else {
            
            let alert = UIAlertView()
            alert.title = title
            alert.message = errorMsg
            alert.delegate = delegate
            alert.addButton(withTitle: cancelBtn)
            alert.addButton(withTitle: otherBtn)
            alert.show()
            
        }

    }
    
}
