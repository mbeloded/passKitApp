//
//  CoreDataManager.swift
//  PassKitApp
//
//  Created by Michael Bielodied on 10/6/14.
//  Copyright (c) 2014 Michael Bielodied. All rights reserved.
//

import UIKit
import CoreData

class CoreDataManager: NSManagedObject {
    
    static let sharedInstance = CoreDataManager()
    
    var contxt:NSManagedObjectContext! = (UIApplication.shared.delegate as! AppDelegate).managedObjectContext!
    
    init() {
        self.contxt = (UIApplication.shared.delegate as! AppDelegate).managedObjectContext!
    }
    
    func start()
    {
//        self.appDelegate = UIApplication.sharedApplication().delegate as AppDelegate
//        self.contxt = appDelegate.managedObjectContext
    }
    
    func initNewObject(_ requestType:RequestType)->AnyObject
    {
        var object:AnyObject!
        switch(requestType)
            {
        case RequestType.version:
                let en = NSEntityDescription.entity(forEntityName: "Version", in: self.contxt)
                object = en
            break;
            
        default:
            break;
        }
        return object
    }
    
    
    func saveData(saveArray savedArray:Array<AnyObject>, requestType:RequestType)
    {
        switch(requestType)
            {
            case .version:
                self.removeData(.version)
                    for object in savedArray
                    {
                        let en = NSEntityDescription.entity(forEntityName: "Version", in: self.contxt)
                        var newItem = Version(entity: en!, insertInto: contxt)
                        newItem.version = (object as! PFObject)["version"] as! String
                        newItem.createdAt = ((object as! PFObject).createdAt! as NSDate) as Date
                        newItem.updatedAt = ((object as! PFObject).updatedAt! as NSDate) as Date
                    }
            break;
        case .category:
            self.removeData(.category)
            for object in savedArray
            {
                let en = NSEntityDescription.entity(forEntityName: "CategoryModel", in: self.contxt)
                var newItem = CategoryModel(entity: en!, insertInto: contxt)
                var object1:PFObject = (object as! PFObject)
                
                var icon:PFFile = (object as! PFObject)["icon"] as! PFFile
                
                var pngPath:NSString   = NSHomeDirectory().stringByAppendingPathComponent("Documents/\(icon.name)");
                var imageData:Data = icon.getData()
                imageData.writeToFile(pngPath, atomically: true)
                
                newItem.id = (object as! PFObject).objectId
                newItem.name = (object as! PFObject)["name"] as? String
                newItem.icon = ((object as! PFObject)["icon"] as? PFFile)?.url
                newItem.createdAt = ((object as! PFObject).createdAt as! NSDate) as Date
                newItem.updatedAt = ((object as! PFObject).updatedAt as! NSDate) as Date
            }
            break;
        case .mall:
            self.removeData(.mall)
            for object in savedArray
            {
                let en = NSEntityDescription.entity(forEntityName: "MallModel", in: self.contxt)
                var newItem = MallModel(entity: en!, insertInto: contxt)
                var object1:PFObject = (object as! PFObject)
                
                newItem.id = (object as! PFObject).objectId
                newItem.name = (object as! PFObject)["name"] as? String
                newItem.beacon_id = (object as! PFObject)["beacon_id"] as? String
                newItem.information = (object as! PFObject)["information"] as? String
                newItem.location = (object as! PFObject)["location"] as? String
                newItem.createdAt = ((object as! PFObject).createdAt as! NSDate) as Date
                newItem.updatedAt = ((object as! PFObject).updatedAt as! NSDate) as Date
            }
            break;
        case .banner:
            self.removeData(.banner)
            for object in savedArray
            {
                let en = NSEntityDescription.entity(forEntityName: "BannerModel", in: self.contxt)
                var newItem = BannerModel(entity: en!, insertInto: contxt)
                var object1:PFObject = (object as! PFObject)
                
                var icon:PFFile = (object as! PFObject)["image"] as! PFFile
                
                
                var pngPath:NSString   = NSHomeDirectory().stringByAppendingPathComponent("Documents/\(icon.name)");
                var imageData:Data = icon.getData()
                imageData.writeToFile(pngPath, atomically: true)
                
                newItem.id = (object as! PFObject).objectId
                newItem.type_id = (object as! PFObject)["type_id"] as? String
                newItem.image = ((object as! PFObject)["image"] as? PFFile)?.url
                newItem.createdAt = ((object as! PFObject).createdAt as! NSDate) as Date
                newItem.updatedAt = ((object as! PFObject).updatedAt as! NSDate) as Date
            }
            break;
        case .mall_BANNER:
            self.removeData(.mall_BANNER)
            for object in savedArray
            {
                let en = NSEntityDescription.entity(forEntityName: "MallBannerModel", in: self.contxt)
                var newItem = MallBannerModel(entity: en!, insertInto: contxt)
                newItem.id = (object as! PFObject).objectId
                newItem.mall_id = (object as! PFObject)["mall_id"] as? String
                newItem.banner_id = (object as! PFObject)["banner_id"] as? String
                newItem.createdAt = ((object as! PFObject).createdAt as! NSDate) as Date
                newItem.updatedAt = ((object as! PFObject).updatedAt as! NSDate) as Date
            }
            break;
        case .store:
            self.removeData(.store)
            for object in savedArray
            {
                let en = NSEntityDescription.entity(forEntityName: "StoreModel", in: self.contxt)
                var newItem = StoreModel(entity: en!, insertInto: contxt)
                newItem.id = (object as! PFObject).objectId
                newItem.name = (object as! PFObject)["name"] as? String
                newItem.details = (object as! PFObject)["details"] as? String
                newItem.banner_id = (object as! PFObject)["banner_id"] as? String
                newItem.beacon_id = (object as! PFObject)["beacon_id"] as? String
                newItem.location = (object as! PFObject)["location"] as? String
                newItem.category_id = (object as! PFObject)["category_id"] as? String
                newItem.createdAt = ((object as! PFObject).createdAt as! NSDate) as Date
                newItem.updatedAt = ((object as! PFObject).updatedAt as! NSDate) as Date
            }
            break;
            
        default:
            break;
        }
        contxt.save(nil)
    }
    
    func loadData(_ requestType:RequestType)->Array<AnyObject>
    {
        var data:Array<AnyObject>? = []
        var freq:NSFetchRequest<NSFetchRequestResult>!
        switch(requestType)
            {
            case RequestType.version:
                freq = NSFetchRequest(entityName: "Version")
            break;
        case .category:
            freq = NSFetchRequest(entityName: "CategoryModel")
            break;
        case .mall:
            freq = NSFetchRequest(entityName: "MallModel")
            break;
        case .banner:
            freq = NSFetchRequest(entityName: "BannerModel")
            break;
        case .mall_BANNER:
            freq = NSFetchRequest(entityName: "MallBannerModel")
            break;
        case .store:
            freq = NSFetchRequest(entityName: "StoreModel")
            break;
            
        default:
            break;
        }
        if self.contxt != nil {
            data = self.contxt.executeFetchRequest(freq, error: nil)!
        }
        return data!
    }

    func loadData(_ requestType:RequestType, key:String)->Array<AnyObject>
    {
        var data:Array<AnyObject>? = []
        var freq:NSFetchRequest<NSFetchRequestResult>!
        switch(requestType)
            {
        case RequestType.version:
            freq = NSFetchRequest(entityName: "Version")
            break;
        case .category:
            freq = NSFetchRequest(entityName: "CategoryModel")
            break;
        case .mall:
            freq = NSFetchRequest(entityName: "MallModel")
            break;
        case .banner:
            freq = NSFetchRequest(entityName: "BannerModel")
            
            let predicate = NSPredicate(format: "id == %@", key)
            print(predicate)
            freq.predicate = predicate
            break;
        case .mall_BANNER:
            freq = NSFetchRequest(entityName: "MallBannerModel")
            let predicate = NSPredicate(format: "mall_id == %@", key)
            print(predicate)
            freq.predicate = predicate
            break;
        case .store:
            freq = NSFetchRequest(entityName: "StoreModel")
            let predicate = NSPredicate(format: "category_id == %@", key)
            print(predicate)
            freq.predicate = predicate
            break;
            
        default:
            break;
        }
        if self.contxt != nil {
            data = self.contxt.executeFetchRequest(freq, error: nil)!
        }
        return data!
    }

    func removeData(_ requestType:RequestType)
    {
        var freq:NSFetchRequest<NSFetchRequestResult>!
        switch(requestType)
            {
            case RequestType.version:
                freq = NSFetchRequest(entityName: "Version")
                var results:NSArray = self.contxt.executeFetchRequest(freq, error: nil)!
                if(results.count > 0)
                {
                    for object in results {
                        self.contxt.delete(object as! NSManagedObject)
                        self.contxt.save(nil)
                    }
                }
            break;
        case .category:
            freq = NSFetchRequest(entityName: "CategoryModel")
            var results:NSArray = self.contxt.executeFetchRequest(freq, error: nil)!
            if(results.count > 0)
            {
                for object in results {
                    self.contxt.delete(object as! NSManagedObject)
                    self.contxt.save(nil)
                }
            }
            break;
        case .mall:
            freq = NSFetchRequest(entityName: "MallModel")
            var results:NSArray = self.contxt.executeFetchRequest(freq, error: nil)!
            if(results.count > 0)
            {
                for object in results {
                    self.contxt.delete(object as! NSManagedObject)
                    self.contxt.save(nil)
                }
            }
            break;
        case .banner:
            freq = NSFetchRequest(entityName: "BannerModel")
            var results:NSArray = self.contxt.executeFetchRequest(freq, error: nil)!
            if(results.count > 0)
            {
                for object in results {
                    self.contxt.delete(object as! NSManagedObject)
                    self.contxt.save(nil)
                }
            }
            break;
        case .mall_BANNER:
            freq = NSFetchRequest(entityName: "MallBannerModel")
            var results:NSArray = self.contxt.executeFetchRequest(freq, error: nil)!
            if(results.count > 0)
            {
                for object in results {
                    self.contxt.delete(object as! NSManagedObject)
                    self.contxt.save(nil)
                }
            }
            break;
        case .store:
            freq = NSFetchRequest(entityName: "StoreModel")
            var results:NSArray = self.contxt.executeFetchRequest(freq, error: nil)!
            if(results.count > 0)
            {
                for object in results {
                    self.contxt.delete(object as! NSManagedObject)
                    self.contxt.save(nil)
                }
            }
            break;
            
        default:
            break;
        }
    }
    
}
