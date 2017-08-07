//
//  StoreModel.swift
//  PassKitApp
//
//  Created by Michael Bielodied on 10/3/14.
//  Copyright (c) 2014 Michael Bielodied. All rights reserved.
//

import UIKit
import CoreData

class StoreModel: NSManagedObject {
    @NSManaged var id:String!
    @NSManaged var name:String!
    @NSManaged var details:String!
    @NSManaged var banner_id:String!
    @NSManaged var beacon_id:String!
    @NSManaged var location:String!
    @NSManaged var category_id:String!
    @NSManaged var createdAt:Date
    @NSManaged var updatedAt:Date
    var isSelected:Bool = false
}
