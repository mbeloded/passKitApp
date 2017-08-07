//
//  MallBannerModel.swift
//  PassKitApp
//
//  Created by Michael Bielodied on 10/8/14.
//  Copyright (c) 2014 Michael Bielodied. All rights reserved.
//

import UIKit
import CoreData

class MallBannerModel: NSManagedObject {
    @NSManaged var id:String!
    @NSManaged var mall_id:String!
    @NSManaged var banner_id:String!
    @NSManaged var createdAt:Date
    @NSManaged var updatedAt:Date

}
