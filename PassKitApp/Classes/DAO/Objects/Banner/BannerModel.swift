//
//  BannerModel.swift
//  PassKitApp
//
//  Created by Michael Bielodied on 10/3/14.
//  Copyright (c) 2014 Michael Bielodied. All rights reserved.
//

import UIKit
import CoreData

class BannerModel: NSManagedObject {
    @NSManaged var id:String!
    @NSManaged var image:String!
    @NSManaged var type_id:String!
    @NSManaged var createdAt:Date
    @NSManaged var updatedAt:Date
}
