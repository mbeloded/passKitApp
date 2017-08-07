//
//  MainMenuViewController.swift
//  PassKitApp
//
//  Created by Michael Bielodied on 10/3/14.
//  Copyright (c) 2014 Michael Bielodied. All rights reserved.
//

import UIKit

class MainMenuViewController: RootViewController {

    @IBOutlet weak var mainMenuView: MainMenuView!
    @IBOutlet weak var bannerView: BannerView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mainMenuView.owner = self
        mainMenuView.setupView()
        
        var items:Array<AnyObject> = CoreDataManager.sharedInstance.loadData(RequestType.mall)
        if(items.count > 0)
        {
            let mallModel:MallModel = items[0] as! MallModel
            self.title = mallModel.name
            bannerView.setupView(mallModel.id)
            
        }
        self.hideLeftButton()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any!) {
        if(segue.identifier == "showCategory")
        {
            let viewController:CategoryViewController = segue.destination as! CategoryViewController
            var items:Array<AnyObject> = CoreDataManager.sharedInstance.loadData(RequestType.mall)
            if(items.count > 0)
            {
                let mallModel:MallModel = items[0] as! MallModel
                viewController.mall_id = mallModel.id
                viewController.category_id = mainMenuView.category_id
                
            }
        }
    }

    @IBAction func rightSwipeAction(_ sender: AnyObject) {
        bannerView.update()
    }
    
    @IBAction func leftSwipeAction(_ sender: AnyObject) {
        bannerView.updateMinus()
    }
    
}
