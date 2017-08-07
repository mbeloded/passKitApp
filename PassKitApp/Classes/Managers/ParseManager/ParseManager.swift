//
//  ParseManager.swift
//  PassKitApp
//
//  Created by Michael Bielodied on 10/6/14.
//  Copyright (c) 2014 Michael Bielodied. All rights reserved.
//

import UIKit
import CoreData

protocol ParseManagerDelegate
{
    func parseRequestComplete()
    func parseRequestError(_ error:String)
}

class ParseManager: NSObject {
    
    static let sharedInstance = ParseManager()
    
    var delegate:ParseManagerDelegate?
    var serverVersionObject:PFObject!
    
    var serverObjects:Array<AnyObject> = []
    
    func start()
    {
        Parse.setApplicationId(PARSE_APP_KEY, clientKey: PARSE_CLIENT_KEY)
    }

    func getBaseVersionFromServerObject()->PFObject
    {
        return serverVersionObject
    }
    
    func getBaseVersionFromServer()
    {
        var query = PFQuery(className: "ServerVersion")
        query.findObjectsInBackground {
            (objects: [AnyObject]!, error: NSError!) -> Void in
            if error == nil {
                // The find succeeded.
                NSLog("Successfully retrieved \(objects.count) version.")
                // Do something with the found objects
                for object in objects {
                    
                    self.serverVersionObject = object as PFObject
                    
                    NSLog("%@", object.objectId)
                    var serverVerion = object["version"] as String
                    println("version: \(serverVerion)")
                    self.delegate?.parseRequestComplete()
                }
            } else {
                // Log details of the failure
                self.delegate?.parseRequestError(error.localizedDescription)
                NSLog("Error: %@ %@", error, error.userInfo!)
            }
        }
    }
    
    //Need optimize this code!!!!!
    
    func getCategoryFromServer()
    {
        var query = PFQuery(className: "CategoryModel")
        query.findObjectsInBackground {
            (objects: [AnyObject]!, error: NSError!) -> Void in
            if error == nil {
                // The find succeeded.
                NSLog("Successfully retrieved \(objects.count) category.")
                // Do something with the found objects
                self.serverObjects.removeAll(keepingCapacity: false)
                
                for object in objects {
                    self.serverObjects.append(object as PFObject)
                }
                self.delegate?.parseRequestComplete()
            } else {
                // Log details of the failure
                self.delegate?.parseRequestError(error.localizedDescription)
                NSLog("Error: %@ %@", error, error.userInfo!)
            }
        }
    }

    func getMallFromServer()
    {
        var query = PFQuery(className: "MallModel")
        query.findObjectsInBackground {
            (objects: [AnyObject]!, error: NSError!) -> Void in
            if error == nil {
                // The find succeeded.
                NSLog("Successfully retrieved \(objects.count) mall.")
                // Do something with the found objects
                self.serverObjects.removeAll(keepingCapacity: false)
                
                for object in objects {
                    self.serverObjects.append(object as PFObject)
                }
                self.delegate?.parseRequestComplete()
            } else {
                // Log details of the failure
                self.delegate?.parseRequestError(error.localizedDescription)
                NSLog("Error: %@ %@", error, error.userInfo!)
            }
        }
    }

    func getBannerFromServer()
    {
        var query = PFQuery(className: "BannerModel")
        query.findObjectsInBackground {
            (objects: [AnyObject]!, error: NSError!) -> Void in
            if error == nil {
                // The find succeeded.
                NSLog("Successfully retrieved \(objects.count) banner.")
                // Do something with the found objects
                self.serverObjects.removeAll(keepingCapacity: false)
                
                for object in objects {
                    self.serverObjects.append(object as PFObject)
                }
                self.delegate?.parseRequestComplete()
            } else {
                // Log details of the failure
                self.delegate?.parseRequestError(error.localizedDescription)
                NSLog("Error: %@ %@", error, error.userInfo!)
            }
        }
    }

    func getMallBannerFromServer()
    {
        var query = PFQuery(className: "MallBannerModel")
        query.findObjectsInBackground {
            (objects: [AnyObject]!, error: NSError!) -> Void in
            if error == nil {
                // The find succeeded.
                NSLog("Successfully retrieved \(objects.count) mall_banners.")
                // Do something with the found objects
                self.serverObjects.removeAll(keepingCapacity: false)
                
                for object in objects {
                    self.serverObjects.append(object as PFObject)
                }
                self.delegate?.parseRequestComplete()
            } else {
                // Log details of the failure
                self.delegate?.parseRequestError(error.localizedDescription)
                NSLog("Error: %@ %@", error, error.userInfo!)
            }
        }
    }

    func getStoreFromServer()
    {
        var query = PFQuery(className: "StoreModel")
        query.findObjectsInBackground {
            (objects: [AnyObject]!, error: NSError!) -> Void in
            if error == nil {
                // The find succeeded.
                NSLog("Successfully retrieved \(objects.count) stores.")
                // Do something with the found objects
                self.serverObjects.removeAll(keepingCapacity: false)
                
                for object in objects {
                    self.serverObjects.append(object as PFObject)
                }
                self.delegate?.parseRequestComplete()
            } else {
                // Log details of the failure
                self.delegate?.parseRequestError(error.localizedDescription)
                NSLog("Error: %@ %@", error, error.userInfo!)
            }
        }
    }

    //All this
}
