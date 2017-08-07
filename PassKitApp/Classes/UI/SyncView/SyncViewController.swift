//
//  SyncViewController.swift
//  PassKitApp
//
//  Created by Michael Bielodied on 10/10/14.
//  Copyright (c) 2014 Michael Bielodied. All rights reserved.
//

import UIKit

class SyncViewController: UIViewController {

    @IBOutlet weak var activity: UIActivityIndicatorView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.setNavigationBarHidden(true, animated: false)
        
        activity.startAnimating()

        NotificationCenter.default.addObserver(self, selector: #selector(SyncViewController.updateData(_:)), name:NSNotification.Name(rawValue: NOTIFICATION_SYNC_COMPLETE), object: nil)

        SyncManager.sharedInstance.start()
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func updateData(_ notification: Notification){
        //Action take on Notification
        activity.stopAnimating()
        self.performSegue(withIdentifier: "showMenu", sender: self)
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
