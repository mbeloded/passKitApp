//
//  BannerView.swift
//  PassKitApp
//
//  Created by Michael Bielodied on 10/3/14.
//  Copyright (c) 2014 Michael Bielodied. All rights reserved.
//

import UIKit

class BannerView: UIView {

    @IBOutlet var bannerImage:PFImageView?
    @IBOutlet var pageControl:UIPageControl?

    var mall_banner_items:Array<AnyObject>!
    var banner_items:Array<AnyObject> = []
    
    var index:Int = 0
    
    @IBOutlet weak var guest:UISwipeGestureRecognizer!
    @IBOutlet weak var guest1:UISwipeGestureRecognizer!
    
    func setupView(_ mall_id:String)
    {
        if guest != nil {
            self.addGestureRecognizer(guest)
        }
        
        if guest1 != nil {
            self.addGestureRecognizer(guest1)
        }
        
        mall_banner_items = CoreDataManager.sharedInstance.loadData(RequestType.mall_BANNER, key:mall_id)
        for object in mall_banner_items {
            var banners:Array<AnyObject>  = CoreDataManager.sharedInstance.loadData(RequestType.BANNER, key:(object as MallBannerModel).banner_id)
            for items in banners {
                banner_items.append(items)
            }
        }
        pageControl?.numberOfPages = banner_items.count
        pageControl?.pageIndicatorTintColor = UIColor.black
        pageControl?.currentPageIndicatorTintColor = UIColor.lightGray
        pageControl?.currentPage = index
        if(banner_items.count > 0)
        {
            var url:NSString  = (banner_items[index] as! BannerModel).image! as NSString
            var pngPath:NSString   = NSHomeDirectory().stringByAppendingPathComponent("Documents/\(url.lastPathComponent)");
            bannerImage?.image = UIImage(named: pngPath as String)
        }
        var timer = Timer.scheduledTimer(timeInterval: 5.0, target: self, selector: #selector(BannerView.update), userInfo: nil, repeats: true)
    }
    
    
    func update() {
        index += 1
        if(index >= banner_items.count)
        {
            index = 0
        }
        pageControl?.currentPage = index
        if(banner_items.count > 0)
        {
            //println((banner_items[0] as MallBannerModel).id)
            var url:NSString  = (banner_items[index] as! BannerModel).image! as NSString
            var pngPath:NSString   = NSHomeDirectory().stringByAppendingPathComponent("Documents/\(url.lastPathComponent)");
            bannerImage?.image = UIImage(named: pngPath as String)
        }
    }
    
    func updateMinus() {
        index -= 1
        if(index < 0)
        {
            index = 0
        }
        pageControl?.currentPage = index
        if(banner_items.count > 0)
        {
            //println((banner_items[0] as MallBannerModel).id)
            var url:NSString  = (banner_items[index] as! BannerModel).image! as NSString
            var pngPath:NSString   = NSHomeDirectory().stringByAppendingPathComponent("Documents/\(url.lastPathComponent)");
            bannerImage?.image = UIImage(named: pngPath as String)
        }
    }

    @IBAction func rightSwipeAction(_ sender: AnyObject) {
        self.updateMinus()
    }
    
    @IBAction func leftSwipeAction(_ sender: AnyObject) {
        self.update()
    }
    
    @IBAction func pageAction(_ sender:AnyObject) {
        index = (sender as! UIPageControl).currentPage
        pageControl?.currentPage = index
        if(banner_items.count > 0)
        {
            //println((banner_items[0] as MallBannerModel).id)
            var url:NSString  = (banner_items[index] as! BannerModel).image! as NSString
            var pngPath:NSString   = NSHomeDirectory().stringByAppendingPathComponent("Documents/\(url.lastPathComponent)");
            bannerImage?.image = UIImage(named: pngPath as String)
        }
    }
}
