//
//  CategoryView.swift
//  PassKitApp
//
//  Created by Michael Bielodied on 10/3/14.
//  Copyright (c) 2014 Michael Bielodied. All rights reserved.
//

import UIKit

var cellIdentBanner = "CategoryBannerCell"
var cellIdentBannerDetails = "CategoryBannerDetailsCell"

class CategoryView: UIView, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet var tableView:UITableView!
    @IBOutlet var bannnerView:BannerView!
    var owner:UIViewController!

    var mall_id:String!
    var category_id:String!
    
    var items:Array<AnyObject> = []
    
    func setupView(_ mall_id_:String, category_id_:String)
    {
        mall_id = mall_id_
        category_id = category_id_
        bannnerView.setupView(mall_id_)
        items = CoreDataManager.sharedInstance.loadData(RequestType.store, key:category_id)
        tableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        let item = items[indexPath.row] as! StoreModel
        var height:CGFloat = 0.0
        if(item.isSelected)
        {
            height = 239.0
        } else {
            height = 118.0
        }
        return height
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        var item = items[indexPath.row] as! StoreModel
        var banners:Array<AnyObject> = CoreDataManager.sharedInstance.loadData(RequestType.BANNER, key: item.banner_id)
        var banner:BannerModel!
        if(banners.count > 0)
        {
            banner = banners[0] as! BannerModel
        }
        
        var url:String  = banner.image
        var parsed_url:NSString = url.stringByReplacingOccurrencesOfString("%20", withString: " ", options: nil, range: nil)
        var pngPath:NSString   = NSHomeDirectory().stringByAppendingPathComponent("Documents/\(parsed_url.lastPathComponent)");
        
        print(pngPath)

        
        var cell:UITableViewCell!
        if(item.isSelected)
        {
            cell = tableView.dequeueReusableCell(withIdentifier: cellIdentBannerDetails) as! CategoryBannerDetailsCell!
            if (cell == nil) {
                cell = CategoryBannerDetailsCell(style:.default, reuseIdentifier: cellIdentBannerDetails)
            }
            (cell as! CategoryBannerDetailsCell).bannerView.image = UIImage(named: pngPath as String)
            (cell as! CategoryBannerDetailsCell).titleLabel.text = item.name
            (cell as! CategoryBannerDetailsCell).detailsLabel.text = item.details
        } else {
            cell = tableView.dequeueReusableCell(withIdentifier: cellIdentBanner) as! CategoryBannerCell!
            if (cell == nil) {
                cell = CategoryBannerCell(style:.default, reuseIdentifier: cellIdentBanner)
            }
            (cell as! CategoryBannerCell).bannerView.image = UIImage(named: pngPath as String)
        }
        return cell

    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
       let item = items[indexPath.row] as! StoreModel
        if(item.isSelected)
        {
            item.isSelected = false
        } else {
            item.isSelected = true
        }
        tableView.reloadData()
       // tableView.reloadRowsAtIndexPaths(indexPath, withRowAnimation: UITableViewRowAnimation.Automatic)
        
        //owner?.performSegueWithIdentifier("showItems", sender: owner)

    }
    
    
}
