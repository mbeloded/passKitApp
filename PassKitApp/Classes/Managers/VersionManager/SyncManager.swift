//
//  SyncManager.swift
//  PassKitApp
//
//  Created by Michael Bielodied on 10/6/14.
//  Copyright (c) 2014 Michael Bielodied. All rights reserved.
//

import UIKit

class SyncManager: NSObject, ParseManagerDelegate {
 
    static let sharedInstance = SyncManager()

    var action:ActionType = ActionType.no_ACTION
    
    func start()
    {
        ParseManager.sharedInstance.delegate = self
        action = ActionType.version
        ParseManager.sharedInstance.getBaseVersionFromServer()
    }
    
    func checkVersion()
    {
        if(self.serverHaveNewVersion())
        {
            var items:Array<AnyObject> = []
            items.append(ParseManager.sharedInstance.getBaseVersionFromServerObject())
            CoreDataManager.sharedInstance.saveData(saveArray: items, requestType: RequestType.version)
            action = ActionType.category
            ParseManager.sharedInstance.getCategoryFromServer()
            
            //have new version
        } else {
            action = ActionType.sync_COMPLETE
            NotificationCenter.default.post(name: Notification.Name(rawValue: NOTIFICATION_SYNC_COMPLETE), object: nil)
            // do not have new version
        }
    
    }
    
    func serverHaveNewVersion()->Bool
    {
        var result = false
        let serverVersion: AnyObject! = (ParseManager.sharedInstance.getBaseVersionFromServerObject() as PFObject)["version"] as AnyObject
        
        print("server version: \(serverVersion) local version: \(self.loadVersionFromLocal())")
        if((serverVersion as! NSString) as String != self.loadVersionFromLocal())
        {
            result = true
        }
        return result
    }
    
    func loadVersionFromLocal()->String
    {
        var version:String = "-1"
        let data:Array = CoreDataManager.sharedInstance.loadData(RequestType.version)
        for object in data {
            version = (object as! Version).version
        }
        return version
    }

    func parseRequestComplete()
    {
        switch(action) {
        case ActionType.version:
            self.checkVersion()
            break;
        case ActionType.category:
            self.syncCategory()
            break;
        case ActionType.mall:
            self.syncMall()
            break;
        case ActionType.banner:
            self.syncBanner()
            break;
        case ActionType.mall_BANNER:
            self.syncMallBanner()
            break;
        case ActionType.store:
            self.syncStore()
            break;
        case ActionType.sync_COMPLETE:
            NotificationCenter.default.post(name: Notification.Name(rawValue: NOTIFICATION_SYNC_COMPLETE), object: nil)
            break;
        default:
            break;
        }
    }
    
    func parseRequestError(_ error:String)
    {
        let alert = UIAlertView()
        alert.title = error
        alert.message = ""
        alert.addButton(withTitle: BUTTON_TEXT_OK)
        alert.show()
    }
 
    func syncCategory()
    {
        CoreDataManager.sharedInstance.saveData(saveArray: ParseManager.sharedInstance.serverObjects, requestType: RequestType.category)
        action = ActionType.mall
        ParseManager.sharedInstance.getMallFromServer()
    }

    func syncMall()
    {
        CoreDataManager.sharedInstance.saveData(saveArray: ParseManager.sharedInstance.serverObjects, requestType: RequestType.mall)
        action = ActionType.banner
        ParseManager.sharedInstance.getBannerFromServer()
    }

    func syncBanner()
    {
        CoreDataManager.sharedInstance.saveData(saveArray: ParseManager.sharedInstance.serverObjects, requestType: RequestType.banner)
        action = ActionType.mall_BANNER
        ParseManager.sharedInstance.getMallBannerFromServer()
    }

    func syncMallBanner()
    {
        CoreDataManager.sharedInstance.saveData(saveArray: ParseManager.sharedInstance.serverObjects, requestType: RequestType.mall_BANNER)
        action = ActionType.store
        ParseManager.sharedInstance.getStoreFromServer()
    }

    func syncStore()
    {
        CoreDataManager.sharedInstance.saveData(saveArray: ParseManager.sharedInstance.serverObjects, requestType: RequestType.store)
        action = ActionType.sync_COMPLETE
        self.parseRequestComplete()
    }
}
